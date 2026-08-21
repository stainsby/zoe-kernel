---
name: zoe-claude-init
description: Sets up a ZOE in any Claude environment, including Cowork and Claude Code. Use once, on a new ZOE or one whose instructions are missing.
---

# Starting ZOE in a Claude environment

This is a one-off. It puts the kernel's instructions into the workspace and makes the
environment load them, after which the enterprise runs on its own skills and this one is done.

The other time to run it is to repair an enterprise whose instructions have gone missing — an
install that half finished, or a workspace moved to an environment that loads them differently.
That is safe: every step below either changes nothing or fixes a difference.

The instruction files travel with this skill, in its own `assets/` folder, so what lands in the
workspace is a copy of the released text rather than anything retyped.

## What differs between environments

**Every environment gets the same file in the workspace**: `kernel/instructions/zoe.instructions.md`.
That is what the enterprise reads, what its index points at, and what its upgrade comparison is
made against. It must not live only inside this plugin — a plugin is replaced when it updates,
and an enterprise must never have the rules it runs under changed underneath it.

What differs is only how the environment is told to load it:

- **Claude Code** reads a `CLAUDE.md` at the workspace root every session. Add the import line
  and the instructions are unconditional, in front of the model before it decides anything.
- **Cowork** has no such file, but a Cowork *project* has an **Instructions** field — standing
  guidance applied to every session in that project. It does the same job. You cannot write it
  yourself: it is set in the project's settings, so give the person the exact line and ask them
  to paste it in.
- **Anywhere with neither**, the file still goes into the workspace and the enterprise's index
  records that every session reads it first. Say plainly that this is the weakest of the three:
  nothing but discipline puts the rules in context before the model acts, and it belongs in the
  index as a known weakness of the host.

If you cannot tell which you are, say so and ask, rather than guessing.

## Setting it up

1. **Confirm where.** State the directory you are about to write into and have the person
   confirm it is the enterprise's project root. Do not infer it from where a shell happens to
   be.

2. **See what instructions the workspace already has, and talk to the person about them.** It
   may carry its own — a `CLAUDE.md`, an `AGENTS.md`, anything either of them imports — written
   for whatever it was doing before ZOE arrived. Read them, and raise what you find.

   This is a conversation, not a form to fill in. The ZOE instructions order the charter,
   themselves, the skills and your own judgement; they say nothing about instructions that were
   already here, because the kernel cannot know what those are. So there is no rule for you to
   apply — and two sets of standing directions that quietly disagree is how a gate stops being
   enforced without anyone noticing. Work out together what should happen.

   These are the shapes such a conversation usually takes, offered as a starting point rather
   than a menu: the old instructions stay and ZOE's take precedence where they conflict; the old
   ones are cleared out first; or you both satisfy yourselves that nothing really conflicts, in
   which case say what you checked.

   Two things are yours rather than theirs. **Delete nothing yourself.** And **say plainly if
   anything already there would weaken a gate** — a direction to act without asking, to skip
   approval, to push or publish unprompted; that belongs in the conversation whether or not they
   raise it. Record whatever you settle on, so a later session is not left guessing.

3. **Put the instruction file in the workspace.** Where you can run commands:

   ```sh
   mkdir -p kernel/instructions
   cp "${CLAUDE_PLUGIN_ROOT}"/skills/zoe-claude-init/assets/*.md kernel/instructions/
   ```

   The plugin's own files sit outside the workspace, so that copy may be refused until you are
   given access to them. If it is, say so plainly and offer the fix rather than working around
   it: the person approves the read when prompted, or runs `/add-dir ${CLAUDE_PLUGIN_ROOT}`
   first. Where you have no shell, read each file in this skill's `assets/` folder and write it
   into `kernel/instructions/` under the same name, and say that is what you did. Either way it
   is a copy: never retype the text, and never summarise or tidy it.

   **Do not go on to step 4 until the file is really there.** An import pointing at a file that
   is not there fails silently, and the enterprise then starts with no instructions and no
   gates, looking entirely normal.

   The copy is deliberate, not a link. A plugin is replaced when it updates, and an enterprise
   must never have the rules it runs under changed underneath it. When the plugin's version
   changes, compare the two files: that comparison is what the kernel's upgrade skill acts on,
   and adopting a new kernel needs the director's approval.

4. **Make the environment load it.** Which of these applies was settled above.

   **In Cowork**, ask the person to open the project's settings and add this to its
   **Instructions**, then confirm they have done it before you go on:

   > This project is a ZOE enterprise. At the start of every session, before anything else,
   > read `kernel/instructions/zoe.instructions.md` from this project's folder and follow it.

   You cannot set that field yourself, so do not claim it is done on their word alone — ask them
   to confirm, and say in your report that it rests on their confirmation.

   **In Claude Code**, add this one line to the workspace's `CLAUDE.md`, creating that file if
   there is none:

   ```
   @kernel/instructions/zoe.instructions.md
   ```

   If a `CLAUDE.md` already exists, **add that line and change nothing else.** Never overwrite a
   file you did not create.

   An import resolves relative to the file holding it. At the workspace root the line above is
   right; inside `.claude/CLAUDE.md` it must read `@../kernel/instructions/zoe.instructions.md`.

   **Where the environment offers neither**, there is nothing to add here. Record in the
   enterprise's index that its instructions are read from the workspace at the start of every
   session, and that nothing enforces it.

5. **Check it, and give a count.** Nothing warns you when an import points at nothing.

   ```sh
   grep -rn 'zoe\.instructions\.md' CLAUDE.md .claude/CLAUDE.md 2>/dev/null
   ls -l kernel/instructions/zoe.instructions.md
   ```

   Where step 4 added an import line, every such line must name a file that exists and there
   must be **at least one**; where it added a project instruction, the check is that the person
   has confirmed it and that you have said the check rests on their word; where it added
   neither, the check is that the instruction file is in the workspace and complete. **The count is the point, not the listing** — a check that only inspects what it finds
   passes silently when it finds nothing, which is exactly what happens when the merge in step 4
   was missed. If part of that is refused, enumerate the same things with your file tools and
   say which you used. State a count and a verdict, not an impression.

## Then hand over

If you have just set the workspace up, it is a ZOE now, but a blank one: no charter, no index,
no stores. Say so, say what you found about this environment — whether it has a project
instructions file, a shell, sub-agents, durable files — and stop. Those answers belong in the
enterprise's index as its known weaknesses.

What comes next belongs to the kernel, not here: its orient skill runs first, finds no index,
and hands over to setup, where the person is interviewed as director to write the charter.
**Do not start that interview from this skill.**

While setting up: change nothing else in the workspace, never overwrite a file you did not
create, and report what this environment cannot do rather than quietly working around it.
