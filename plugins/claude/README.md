# The ZOE plugin for Claude

This folder packages ZOE as a plugin for Anthropic's Claude products, so that installing it is
three commands instead of the manual wiring in `hosts/claude-code/README.md`. It sits beside
`kernel/`, not inside it: packaging is not part of the kernel, and the kernel's rules bind
whichever way ZOE arrives.

The two routes differ in where the kernel lives. The manual route puts the whole kernel tree in
the enterprise's project and pins it, by copy or by submodule; it is Claude Code only. This
route runs the kernel's skills from the plugin, on any Claude environment; only the
instructions and a version file are written into the project. It is the weaker of the two on
version control — see *Upgrades* below for why that is acceptable.

**Everything here is specific to one provider, and the paths say so.** `plugins/claude/` holds
the packaging and `dist/claude/` holds what it builds. `plugin.json`, `marketplace.json` and
the `.claude-plugin/` directory are Anthropic's formats, not an open standard, and another
provider's plugin system would get its own `plugins/<provider>/` beside this one rather than
changing anything here. Only the skills themselves are portable: the Agent Skills format is an
open standard, so `kernel/skills/` stays host-neutral where it lives and this folder merely
copies it into the package at build time.

The catalogue is a separate repository, `stainsby/zoe-plugins`, which hosts the plugins it
lists. Its `scripts/update-plugin.py` takes the package built here, unpacks it into that
repository, and copies the name, version, description and author from the package's own
`plugin.json` into the catalogue entry. What an adopter installs is that unpacked copy.

**The package is assembled, not declared.** `plugin.json` can name where components live, and
pointing `skills` at `kernel/skills/` does work in Claude Code — but it does not travel. Cowork
rejected that manifest with *"No agent files found in specified directories"*, having read the
file paths as directories, while `claude plugin validate` rejects a directory outright with
`agents: Invalid input`. No value satisfies both. So the build declares no component paths at
all and instead places everything where every surface looks by default: `skills/` and `agents/`
at the plugin's own root. The cost is that the kernel's skills are copied into the package
rather than served in place — regenerated every build, never edited, and the build is
reproducible, so a drifted copy would show up as a changed file.

Only the zip is committed. The assembled tree is staging, built in a temporary directory and
thrown away, so nothing may depend on it existing.

The agent stubs are the ones in `hosts/claude-code/agents/`, copied in at build time. There is
one set: there used to be two, and they drifted.

## Installing

```sh
claude plugin marketplace add stainsby/zoe-plugins
claude plugin install zoe-kernel@zoe
claude plugin enable zoe-kernel@zoe
```

The plugin arrives switched off — a ZOE is something you start on purpose, not something that
loads into every project on the machine — so the third step enables it in the project that is
to become the enterprise. Then ask Claude to set ZOE up. That runs the `zoe-claude-init` skill,
which is the other half of the install and is described below.

Where a surface offers no command line, the same steps are in its own interface: add the
marketplace by its repository address, install the plugin, enable it, then ask Claude to set
ZOE up. A package at `dist/claude/plugin.zip` can also be uploaded directly, on the surfaces
that accept a plugin as a file — which is how to try ZOE in Cowork without registering
anything. The current release's package is always at one address,
`https://raw.githubusercontent.com/stainsby/zoe-kernel/latest-release/dist/claude/plugin.zip`:
the tag `latest-release` moves to each release commit.

## What arrives, and what actually works where

| | Claude Code | Cowork | Chat |
|---|---|---|---|
| The kernel's ten skills | yes | yes | unclear |
| `zoe-claude-init`, the one skill added | yes | yes | unclear |
| `VERSION` and `CHANGELOG/`, for the kernel's upgrade skill | yes | yes | unclear |
| The three agents | yes | yes | no |
| Standing per-project instructions | yes, `CLAUDE.md` | yes, a project's **Instructions** field | no |

Skills are the only part every surface loads, so ZOE is built to stand on skills alone. The
rest changes how well it runs, not whether it runs.

**Chat is marked unclear because Anthropic's own documentation disagrees with itself**, and
guessing which half is right would be worse than saying so. The Cowork guide states that
plugins "are available in Cowork and Code" and "aren't used in Chat"; the support article
describes skills working in chat with hooks and sub-agents greyed out. Nobody here has tried
it. Treat Claude Code and Cowork as the supported pair until someone does.

**The instructions are the part that needs care.** They carry the gates, so they have to be in
front of the model before it decides anything — and a plugin cannot make that happen by itself,
because a `CLAUDE.md` at a plugin's root is not read as project context. The one added skill,
`zoe-claude-init`, closes that gap. It runs once when the ZOE is started; the only other
times are to repair a missing instruction file, to apply an approved kernel upgrade (see
*Upgrades*), and to write the enterprise's instructions file where none exists.

**It always writes the same two files into the workspace**, whatever the surface, and may
write a third:
`.zoe/instructions/zoe.instructions.md`, a pinned copy of the kernel's instructions, and
`.zoe/VERSION`, the kernel version they and the plugin's skills came from. Where the
enterprise has no instructions file of its own, it writes an empty one from the kernel's
template as well, for `zoe-setup` to fill in with the director. The instruction file is what
the enterprise reads and what its index points at; the version file is what its upgrade
comparison starts from. Neither lives only in the plugin: a plugin update replaces the
skills, and an enterprise must never have the rules it runs under changed underneath it.
`.zoe/` is named for what it is — what this enterprise holds of ZOE — and not `kernel/`, because
the kernel is the instructions *and* the skills, and the skills stay in the plugin.

What differs is only whether the surface will load those files for you:

- **Claude Code** reads a project `CLAUDE.md` every session, so the skill adds the import
  lines and the instructions become unconditional — the same property the manual install has.
- **Cowork** has no `CLAUDE.md`, but a Cowork *project* has an **Instructions** field —
  standing guidance applied to every session in that project — which does the same job. The
  skill cannot write that field, so it hands the person the exact lines and asks them to paste them
  into the project's settings, and says in its report that the check rests on their
  confirmation.
- **Anywhere with neither**, the instruction files still go into the workspace and the
  enterprise's index records that every session reads them first. That is the weakest of the
  three, and the enterprise is told to record it as a known weakness of its host: nothing but
  discipline puts the rules in context before the model acts.

The instruction file and `VERSION` travel inside the skill, under its `assets/`, so the skill
can write them out even where nothing can be copied from disk. That is a source for the
writing, not a second home for the instructions.

## Upgrades

An adopter's kernel should never change without their director agreeing to it — that is the
kernel's own rule, and adopting a new kernel replaces the rules the enterprise runs under.

Three things keep that true here. The marketplace holds the released package, unpacked,
replaced only when a release is cut, so what installs is a released kernel and never whatever
`main` happens to hold. The package carries `VERSION` and `CHANGELOG/` at its root, so the
kernel's upgrade skill has what it needs without leaving the plugin: it compares the project's
`.zoe/VERSION` with the plugin's `VERSION`, reads the changelog entries between the two, and
asks the director before the instruction file and `VERSION` are rewritten (by running
`zoe-claude-init` again). And on Claude Code an update is the adopter's own act: Anthropic's
documentation states that third-party marketplaces have auto-update disabled by default, and
an update then happens only when the adopter turns it on for the marketplace, installs
explicitly, or an administrator enables it in managed settings for the organisation. Cowork's documentation describes an **Update** control on a marketplace and says
Cowork "checks for plugin updates", but does not say whether one can apply without the
person's action; until it does, treat a Cowork plugin update as something to confirm with the
director, not something that cannot happen unasked.

What a plugin update does replace is the skills, for every enterprise on the machine at once,
since one plugin cache per user serves them all. The pinned instructions outrank the skills
under the kernel's own precedence, and the changelog span accounts for what moved in the
skills; that is why the weaker pin is acceptable on this route.

## Building

`build.sh` is the release step. From the repository root:

```sh
plugins/claude/build.sh
```

It reads the version from `kernel/VERSION` and writes it into the package's `plugin.json`,
copies the kernel's skills in, generates `zoe-claude-init` from
`zoe-claude-init.template.md`, the kernel's instruction files and `kernel/VERSION`, copies the
agent stubs, the licence, `VERSION` and the `CHANGELOG/` directory, checks the counts add up
and the version files agree, validates the plugin, and writes the package. It does not
touch the catalogue: that lives in the marketplace repository and is updated from the package
it produces — see *Release ordering* below.

**The package always lands at `dist/claude/plugin.zip`** — one fixed path, naming the provider
whose plugin format it holds, with no version in the name or the path, so anything pointing at
the package keeps pointing at it release after release. It is built with a sorted file list and
fixed timestamps, which makes its bytes depend on content alone: rebuilding unchanged content
gives a byte-identical archive. That is what lets a release run the build and treat any
unexpected modified path as a fault.

**Release ordering.** The package embeds the version from `kernel/VERSION`, so it is rebuilt
after the version is bumped and committed with the release. Then, from the marketplace
repository, `scripts/update-plugin.py <path to this plugin.zip>` unpacks it and brings the
catalogue entry into line with it; that change is published after the kernel's release tag, so
the marketplace never offers a version this repository has not released. The tag
`latest-release` is moved to the same release commit, so the fixed address above always serves
the released package.

Things worth knowing if you change it:

- **The skill and the package are generated.** Edit `zoe-claude-init.template.md`, or the
  kernel's instructions, and build again. The instruction text is inserted by a literal
  replacement, never by `sed` or `awk`: both interpret `&` and backslash escapes in the
  *replacement*, so prose containing either is corrupted silently.
- **The plugin and the catalogue are validated separately.** This build validates the
  assembled plugin; the marketplace repository's `scripts/validate.py` validates the catalogue
  against the plugins it holds. A tree holding a `marketplace.json` is validated as a catalogue
  and the plugin inside it is never looked at, which is why the two are separate subjects.
- **Do not declare component paths in `plugin.json`.** See above: the two surfaces disagree
  about what such a path means, and the disagreement is not resolvable.
