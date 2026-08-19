# GitHub Copilot host adapter

The kernel is host-neutral; this folder is what **GitHub Copilot** needs. Copilot runs
inside VS Code, but the host here is the assistant, not the editor — Claude Code also runs
inside VS Code and has its own adapter alongside this one. What makes this folder specific
to Copilot is its custom-agent file format and tool vocabulary, not the editor.

It lives **alongside** `kernel/`, not inside it — host-specific packaging is not part of
the kernel proper. Adapt it freely to your setup. The kernel's prose rules bind
regardless; these files add packaging, not new behaviour.

> **Status: best effort, not yet exercised end to end.** The ZOE project runs its own
> cycles on Claude Code, so this adapter has not been run through a full cycle. The tool
> names were corrected on 2026-08-19 against Copilot's published alias table, after
> shipping since 0.7.0 with names from VS Code's separate chat-mode vocabulary, which are
> silently ignored in this format. Expect rough edges and please report them.

## Agents

Three thin stubs reference the kernel skills (`zoe`, `zoe-redesign`, `zoe-assess`) and carry
the host-specific packaging (frontmatter, tool list, `model-kind`). Role logic lives in
the skills, not duplicated here. The stubs enforce the kernel's separation rules
(decide / do / judge) by running planner and checker as subagents in their own context.

- `zoe.agent.md` — the manager; the agent a human talks to. Full tools. Dispatches to
  the other two.
- `zoe-redesigner.agent.md` — wraps `zoe-redesign`. Read-only to the work; owns its plan
  artifact (write + edit on the plan store).
- `zoe-assessor.agent.md` — wraps `zoe-assess` and consumes audit findings. Read-only to
  the work; owns its report artifact (append-only / immutable once issued).

## Install

Copy (or symlink) the `agents/*.agent.md` files to `.github/agents/` in the enterprise's
workspace so VS Code discovers them, then select **zoe** in the chat agent dropdown.

## Models

How models are chosen is the kernel's rule, not this host's — see `## Models` in
`kernel/instructions/zoe.instructions.md` and the tier-to-model mapping in the
enterprise's index. Host-specific part only: to override a tier for your setup, add a
`model:` line to your copy of an agent file (the value must match the model picker
exactly, e.g. `Claude Sonnet 4.5 (copilot)`).

## Where the host falls short

VS Code has no scheduler: "on a schedule" means a human (or an external trigger such
as cron or CI invoking the CLI) starts the cycle.
