# Claude Code host adapter

The kernel is host-neutral; this folder is what Claude Code, specifically, needs.
It lives **alongside** `kernel/`, not inside it — host-specific packaging is not part of
the kernel proper. Adapt it freely to your setup. The kernel's prose rules bind
regardless; these files add packaging, not new behaviour.

## Contents

- `CLAUDE.md` — stub that imports the kernel instructions. Copy to the enterprise's
  project root (or merge the import line into an existing CLAUDE.md).
- `agents/` — three thin stubs that reference the kernel skills (`zoe`, `zoe-redesign`,
  `zoe-assess`) and carry the host-specific packaging (frontmatter, tool list,
  `model-kind`). Role logic lives in the skills, not duplicated here. Copy (or symlink)
  into `.claude/agents/`.
- `settings.json` — suggested permissions. Merge into `.claude/settings.json`.

## Install

1. Symlink the kernel skills into `.claude/skills/` (one link per skill folder — the
   SKILL.md format is native to Claude Code).
2. Copy `agents/*.md` into `.claude/agents/`.
3. Copy `CLAUDE.md` to the project root, or add its import line to yours.
4. Merge `settings.json` into `.claude/settings.json`.
5. Start `claude` and say "run the ZOE cycle" — or ask it how to proceed if the
   enterprise is new (setup will take over).

## Models

How models are chosen is the kernel's rule, not this host's — see `## Models` in
`kernel/instructions/zoe.instructions.md` and the tier-to-model mapping in the
enterprise's index. Host-specific part only: to override a tier for your setup, add
`model:` to your copies (Claude Code accepts aliases — `opus`, `sonnet`, `haiku` —
which age better than full names).

## Scheduling

Claude Code runs headless: `claude -p "run the ZOE cycle" --agents zoe` from cron or CI
gives the kernel its "on a schedule" primitive. Gates survive headless runs because
gated actions are simply not allowlisted: the run does all ungated work, writes its
gate requests to the director channel named in the index, and exits. A director approves on
the next interactive session. Do not pass `--dangerously-skip-permissions`; that
removes the gate.
