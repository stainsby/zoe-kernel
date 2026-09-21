# Any host

The Claude Code adapter beside this folder is written in that tool's own formats. This folder
is for every other host: one start file in a format most agent tools read, and notes on the
things that differ from tool to tool. Like every adapter it sits beside `kernel/`, not
inside it, and adds packaging, not behaviour.

## What is here

- `AGENTS.md` — the start file. It tells a session what to read first, where the skills are,
  which role it is, and how the cycle starts. It adds as little of its own as it can — what to
  do when a file is missing, and how a launched role knows what it is; the rules are the
  kernel's. Copy it to the root of the enterprise's project, beside the `kernel/` folder.

## What to check on your tool

Take each answer from your tool's own documentation — these details change, and differ more
than they appear to.

1. **Does it read `AGENTS.md` without being told to?** Most agent tools do. Some read it only
   when a setting says so; some stop reading it as soon as a file of their own is present
   (Claude Code ignores it once there is a `CLAUDE.md`); a few do not read it at all. Where
   yours does not, point whatever file it does read at this one.
2. **Can the start file pull in another file?** On most tools it cannot, which is why
   `AGENTS.md` tells the session to read the instructions rather than importing them. Where
   your tool has an import line, add one for `kernel/instructions/zoe.instructions.md` — text a
   host loads is more dependable than text a session is asked to read.
3. **Where does it look for skills?** The kernel's skills are in the open Agent Skills format,
   which nearly every agent tool reads, and `.agents/skills/` in the project root is the folder
   most of them share. Link each skill there, from the project root:

   ```sh
   [ -d kernel/skills ] || { echo "no kernel/skills here"; exit 1; }
   mkdir -p .agents/skills
   for d in kernel/skills/*/; do ln -sfn "../../$d" ".agents/skills/$(basename "$d")"; done
   ```

4. **Can it run separate agents?** Formats for declaring one differ. The commonest is a
   Markdown file with a short header, and several tools read the very folder the Claude Code
   adapter uses, so `hosts/claude-code/agents/` may work on yours as it stands — check the
   header fields your tool accepts. Where your tool can limit what an agent may write, limit
   it; where it cannot, that limit rests on the agent being told, and is worth recording as a
   known weakness. Where your tool cannot run a separate agent at all, `zoe-setup` says what to
   record.

## Check it took

Count the links, which must equal the number of kernel skills with none dangling:

```sh
ls -d kernel/skills/*/ | wc -l
n=0; for l in .agents/skills/*; do [ -e "$l/SKILL.md" ] && n=$((n+1)) || echo "DANGLING $l"; done; echo $n
```

Then start a session and ask it to quote the numbered list under *Precedence* in the
instructions. There is one right answer — five lines, the charter's hard rules first — and a
session that has not read the instructions cannot give it, and will not say so unprompted.
