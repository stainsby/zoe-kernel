# Claude Code host adapter

The kernel is host-neutral; this folder is what Claude Code, specifically, needs.
It lives **alongside** `kernel/`, not inside it — host-specific packaging is not part of
the kernel proper. Adapt it freely to your setup. The kernel's prose rules bind
regardless; these files add packaging, not new behaviour.

## Contents

- `CLAUDE.md` — stub that imports the kernel instructions. Copy to the enterprise's
  project root (or merge the import line into an existing CLAUDE.md). Its import is
  written relative to that root and expects the kernel at `kernel/` — see *Install*.
- `agents/` — three thin stubs: the `zoe` manager, and one each for the `zoe-redesign` and
  `zoe-assess` skills. They carry the host-specific packaging — frontmatter, and for the two
  skill-backed stubs a tool list and a `model-kind`. The manager stub carries neither, since
  it runs the whole cycle and its model is set at launch. Role logic lives in the skills, not
  duplicated here. Copy (or symlink) into `.claude/agents/`.
- `settings.json` — an empty placeholder to merge into `.claude/settings.json`. It is
  deliberately empty: ZOE prescribes no permissions, and what you allowlist is your
  call, made against your own gates.

## Install

ZOE needs the kernel tree reachable **from the file that imports it**. Get that wrong and
the enterprise starts with no instructions, and therefore no gates, without saying so — which
is why the checks in step 4 matter more than they look. Every command runs from your
enterprise's project root, and `$ZOE` is wherever you cloned this repository — set it first:

```sh
ZOE=/path/to/your/clone/of/zoe-kernel
```

**1. Put the kernel tree in the project.** Either copy it in:

```sh
cp -r "$ZOE/kernel" .
```

Copying brings the kernel and nothing else. Several files you are about to install refer to
things that live elsewhere in the ZOE project — the host examples, this README, the
changelog — so keep your clone at `$ZOE` rather than deleting it once you are done. The
submodule path below avoids this: everything sits under `.zoe/`.

or track it as a submodule, which pins the exact kernel commit you run on and makes an
upgrade a reviewable change of that pin rather than a re-copy. The project root has to be a
git repository already for this to work:

```sh
git init                       # only if it is not a repository yet
git submodule add https://github.com/stainsby/zoe-kernel .zoe
ln -sfn .zoe/kernel kernel
ZOE=.zoe                       # the rest of the steps read $ZOE
```

Each release is tagged `v<version>`, so you can pin to one rather than to a bare commit:
`git -C .zoe checkout v1.1.0`, then commit the changed submodule pointer. Upgrading is then
checking out the next tag.

**2. Wire in the skills and agents.** Safe to re-run:

```sh
[ -d kernel/skills ] || { echo "step 1 did not complete"; exit 1; }
mkdir -p .claude/skills .claude/agents
for d in kernel/skills/*/; do ln -sfn "../../$d" ".claude/skills/$(basename "$d")"; done
cp "$ZOE"/hosts/claude-code/agents/*.md .claude/agents/
```

The guard on the first line matters: without it, a step 1 that failed leaves no
`kernel/skills/`, the loop's pattern goes through unexpanded, and you get a symlink named
`*` inside `.claude/skills/`.

The `-fn` on `ln` is not decoration: a plain `ln -s` over a link that already exists writes
the new link *inside* the directory it points at, which on the submodule path means writing
into the kernel tree itself.

**3. Add the instructions import — this is the step that can overwrite your own files.**
If you have neither a `CLAUDE.md` nor a `.claude/settings.json`, copy the stubs:

```sh
cp -n "$ZOE/hosts/claude-code/CLAUDE.md" .
cp -n "$ZOE/hosts/claude-code/settings.json" .claude/settings.json
```

`cp -n` refuses to overwrite, so nothing of yours is lost if you already had one. If you do
already have either file, merge rather than copy: add the stub's single `@` import line into
your own `CLAUDE.md`, and leave your settings alone. The shipped `settings.json` is an empty
object on purpose — ZOE prescribes no permissions, and permitting an action in advance is one
of the few ways to blunt a gate.

**Where you put that import line decides what it resolves against.** A `@` import resolves
relative to the file containing it. So `@kernel/instructions/zoe.instructions.md` is right in
a `CLAUDE.md` at the project root, but wrong in `.claude/CLAUDE.md`, where it would look for
`.claude/kernel/…` and quietly find nothing. From `.claude/CLAUDE.md`, write
`@../kernel/instructions/zoe.instructions.md` instead.

**4. Check the install took.** This tests the import as you actually wrote it, rather than
assuming where you put it:

```sh
n=0
for f in CLAUDE.md .claude/CLAUDE.md; do
  [ -f "$f" ] || continue
  for imp in $(grep -o '@[^[:space:]]*zoe\.instructions\.md' "$f"); do
    n=$((n+1)); t="$(dirname "$f")/${imp#@}"
    [ -f "$t" ] && echo "OK   $f -> $t" || echo "FAIL $f -> $t"
  done
done
[ "$n" -gt 0 ] || echo "FAIL no ZOE import line anywhere — the instructions will not load"

m=0
for l in .claude/skills/*; do
  [ -L "$l" ] || continue
  m=$((m+1)); [ -e "$l" ] || echo "DANGLING: $l"
done
[ "$m" -gt 0 ] || echo "FAIL no skills linked into .claude/skills/"
echo "checked $n import line(s), $m skill link(s)"
```

It must print no `FAIL` and no `DANGLING`, and the last line must read `checked 1 import
line(s), N skill link(s)`, where N is the number of skills the kernel ships — check it with
`ls -d kernel/skills/*/ | wc -l` rather than trusting a number written here, which ages every
time the kernel gains a skill. **The counts are the point, not decoration.** A check that only
inspects what it finds passes silently when it finds nothing — which is exactly what happens
if you were merging into an existing `CLAUDE.md` and the merge got missed. Claude Code gives
no warning when an `@` import points at nothing, or when there is no import at all: it
carries on without the kernel instructions, and the enterprise looks like it started
perfectly normally.

**5. Start it.**

```sh
claude -p "run the ZOE cycle" --agent zoe
```

That is the non-interactive form, and it is what a scheduled run uses. Interactively, run
`claude` and say "run the ZOE cycle" — or, if the enterprise is new, simply ask it how to
proceed, and `zoe-setup` will take over and interview you for the charter.

## Models

How models are chosen is the kernel's rule, not this host's — see `## Models` in
`kernel/instructions/zoe.instructions.md` and the tier-to-model mapping in the
enterprise's index. Host-specific part only: to override a tier for your setup, add
`model:` to your copies (Claude Code accepts aliases — `opus`, `sonnet`, `haiku` —
which age better than full names).

## Scheduling

Claude Code runs headless: `claude -p "run the ZOE cycle" --agent zoe` from cron or CI
gives the kernel its "on a schedule" primitive. Gates survive headless runs because
gated actions are simply not allowlisted: the run does all ungated work, writes its
gate requests to the director channel named in the index, and exits. A director approves on
the next interactive session. Do not pass `--dangerously-skip-permissions`; that
removes the gate.
