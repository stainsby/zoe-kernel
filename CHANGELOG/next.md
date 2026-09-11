# 1.3.0 → next

Draft: at the cut this file is renamed to the version it introduces, and the **Files** and
**Size** paragraphs are added.

**Adopter notes.**

1. **A check is run by something other than the agent whose work it checks.** Two sentences on
   the independent-checks bullet in the *Verification* section of
   `kernel/instructions/zoe.instructions.md`: where the host allows, a check runs as automation
   or as a second agent, and only where neither is possible does the agent check its own work,
   recording the command and its raw output. `zoe-setup` now asks whether the host can run the
   enterprise on a schedule with nobody present, and
   `kernel/skills/zoe-setup/assets/index.template.md` gains a `running unattended` line for the
   answer.

   **What to do:** add `running unattended` to your index and fill it in — "no" is an answer.
   Then go through your existing checks: any the agent runs over its own work, that this host
   could run as a hook, a job or a CI step, moves there. Where a check must stay with the
   agent, its record now carries the command and the raw output.

2. **Setup asks what triggers an assessment and what triggers a redesign.** `zoe-setup` asks
   both questions, and the index template's `schedule` line has room for both answers.

   **What to do:** write both triggers into your index's `schedule` line. Nothing else changes
   — if you leave them out you keep whatever cadence you already run.

3. **Two kinds of session: work and management.** *Terms* in the instructions defines a
   **work session** — an ordinary session that does the charter's work — and a **management
   session** — one that does the bookwork and management of the ZOE, the index listing the
   circumstances under which one can occur; *The cycle* says steps 1, 2, 3 and 5 run only in a
   management session. `zoe-orient`'s last step now names the kind of session from the trigger,
   records a management session's start in the log before handing off, and offers a management
   session in its state summary rather than starting one. `zoe-setup` asks, where there are
   several directors, who may open one.

   **What to do:** add who may open a management session to your index's `schedule` line. With
   one director the answer is usually "the director" and nothing about your running changes.
   With several, this is the line that stops two sessions redesigning the same skill set at
   once — a standing director, a rota, or a scheduled unattended run are all workable answers,
   and the kernel prefers none of them.

4. **`zoe-run` dispatches due tasks to workers.** `zoe-run` gains the dispatch procedure — list
   the due tasks with their dependencies, take those whose dependencies are done up to the
   index's concurrency limit, launch a worker for each that fits one agent's session, and
   confirm and checkpoint as each returns — and the brief every worker is launched
   with. `zoe-tasks` now reads "record one item at a time … independent items may run
   together": that rule was always about recording, not execution, and `zoe-reskill`'s *Long
   work* line, which restated it, is removed. The index template gains `concurrency limit`, `worker`
   joins the example model tiers in *Models* and is defined in *Terms*, and
   `hosts/claude-code/README.md` says how a worker is launched on that host.

   **What to do:** add `concurrency limit` to your index — 1 if this host runs one agent at a
   time — and map a real model to a `worker` tier if you use one. If one of your own skills
   restates the old "never batch", reword it. Where the host has no second agent nothing
   changes: every task is worked in the manager's own context, as before.

5. **An enterprise instructions file.** New template
   `kernel/skills/zoe-setup/assets/instructions.template.md`: a short file of standing
   directions from directors, conventions, and facts every session needs, read at the start
   of every session beside the kernel's instructions. The instructions define it in *Terms*
   and say in *Adding to yourself* that it is yours to edit, within the size limit its
   template states. `zoe-setup` creates it, asks for standing directions to start it with,
   and records where it is; the index template gains `where the enterprise instructions are`.
   `zoe-reskill` lists editing it among its actions and `zoe-redesign` among its targets.
   Both host adapters say how the file is loaded: on the manual Claude Code route a second
   `@` import beside the kernel's; on the plugin route the same mechanism, with
   `zoe-claude-init` writing the file from the template if it is not there.

   **What to do:** copy the template into place, add the index line, and add the import (or
   your host's equivalent standing-instructions mechanism) so it is loaded every session. Then
   move what belongs in it: a director's standing directions in their own words, the
   conventions you run by, and the facts a new session gets wrong first. Most of that is
   probably in a skill today, which only loads when the agent decides to read it. Keep the file
   inside sixty lines; what grows past that is a skill.

6. **The changelog is one file per release.** `CHANGELOG.md` is replaced by the `CHANGELOG/`
   directory: one file per version, named by the version it introduces, plus a `README.md` that
   lists them newest first and says how to read an entry. Every entry was trimmed to what helps
   an upgrade; no entry's account of what changed in its release was altered.

   **What to do:** if your index's `where the kernel's changelog is` points at `CHANGELOG.md`,
   point it at `CHANGELOG/`. Reading a span is unchanged — one file per version in the span.

7. **The plugin ships `VERSION` and `CHANGELOG/`, and writes `.zoe/`.** The package built by
   `plugins/claude/build.sh` now carries the kernel's version file and the changelog directory
   at its root, so the upgrade skill has what it needs without leaving the plugin.
   `zoe-claude-init` writes two files into the workspace on every environment, under `.zoe/`,
   where it previously wrote one file under `kernel/`:
   `.zoe/instructions/zoe.instructions.md`, a pinned copy of the kernel's instructions, and
   `.zoe/VERSION`, the version they came from. Where the enterprise has no instructions file
   of its own, it also writes `enterprise.instructions.md` at the workspace root from the
   kernel's template (entry 5). Its re-run cases are stated: repairing a missing instruction
   file, applying an approved upgrade, and writing that file where none exists. The two
   install routes — the manual tree in `hosts/claude-code/README.md` and the plugin in
   `plugins/claude/README.md` — now name each
   other and say which to pick.

   **What to do:** on the plugin route, the instruction file moves from `kernel/instructions/`
   to `.zoe/instructions/`. Move it, delete the now-empty `kernel/`, and change the one import
   line in your `CLAUDE.md` from `@kernel/instructions/zoe.instructions.md` to
   `@.zoe/instructions/zoe.instructions.md` — in Cowork, re-paste the project **Instructions**
   pointer with the new path. Write `.zoe/VERSION` yourself, containing the kernel version you
   were on *before* this release, so your next upgrade check reads the right span; do not run
   `zoe-claude-init` to create it, because that writes the new version and hides the span. Then
   set two index lines: `where the kernel came from` to this plugin, and `where the kernel's
   changelog is` to `${CLAUDE_PLUGIN_ROOT}/CHANGELOG/`. On the manual route, nothing.

8. **`zoe-reskill` no longer tells you to keep old skill versions.** Its improve and delete
   actions and its How paragraph drop "keep the old": whether a file is recoverable is a
   property of where the enterprise keeps its files, decided at setup, not a rule per skill.

   **What to do:** nothing, unless one of your own skills restates it.

9. **The instructions quote the index template in its current words.** *Template-derived files*
   quoted a rule the template no longer carries; it now quotes "Write only what is true now;
   what changed belongs in the log." Two lines in `kernel/instructions/zoe.instructions.md`.

   **What to do:** nothing.
