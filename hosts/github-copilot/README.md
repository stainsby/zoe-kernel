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

Copilot needs three separate things in the workspace: the agent files, the kernel tree and
its skills, and a route by which the kernel instructions reach the assistant. The agent files
alone are not enough — the stubs are thin by design and refer to kernel skills they do not
contain, so without the other two the manager starts with nothing to run.

**1. The agent files.** Copy (or symlink) `agents/*.agent.md` to `.github/agents/` in the
enterprise's workspace so VS Code discovers them. **zoe** then appears in the chat agent
dropdown.

**2. The kernel tree and its skills.** Put the tree in the workspace at `kernel/`, either by
copying the `kernel/` folder from this repository or by adding the repository as a submodule
and linking to it. Then wire the skills in, exactly as the Claude Code adapter does — Copilot
discovers Agent Skills in the same `SKILL.md` format, from `.github/skills/`, `.claude/skills/`
or `.agents/skills/`:

```sh
mkdir -p .github/skills
for d in kernel/skills/*/; do ln -sfn "../../$d" ".github/skills/$(basename "$d")"; done
```

Because `.claude/skills/` is one of the directories Copilot reads, a workspace already set up
for the Claude Code adapter needs nothing further here — the two hosts can share one layout.

**3. The instructions.** Create `.github/copilot-instructions.md`, which Copilot applies
as repo-wide custom instructions. Copilot has no import directive, so either paste the
contents of `kernel/instructions/zoe.instructions.md` into it, or point at the file and
require it be read first:

```markdown
# ZOE enterprise

Read `kernel/instructions/zoe.instructions.md` in full before acting. It is the
operating instruction for this workspace. Then read the charter and the index skill.
```

Pasting the contents is the more reliable of the two, since it does not depend on the
assistant choosing to follow a pointer; linking keeps one copy of the text, which matters
when you upgrade the kernel. If you paste, re-paste on every kernel upgrade.

You may also need `github.copilot.chat.codeGeneration.useInstructionFiles` enabled in VS
Code settings for the instructions file to be applied.

**Check it took.** Open the **zoe** agent and ask it what the ZOE precedence order is, and
what it must do before it may run unattended. Both answers are in the instructions
themselves — the charter's hard rules first, and the director channel recorded in the index —
so the check works on a brand-new enterprise that has no charter yet, which is exactly the
case these notes serve. If it cannot answer, the instructions have not reached it, and
nothing else it tells you about its own gates can be relied on.

## Models

How models are chosen is the kernel's rule, not this host's — see `## Models` in
`kernel/instructions/zoe.instructions.md` and the tier-to-model mapping in the
enterprise's index. Host-specific part only: to override a tier for your setup, add a
`model:` line to your copy of an agent file (the value must match the model picker
exactly, e.g. `Claude Sonnet 4.5 (copilot)`).

## Where the host falls short

VS Code has no scheduler: "on a schedule" means a human (or an external trigger such
as cron or CI invoking the CLI) starts the cycle.
