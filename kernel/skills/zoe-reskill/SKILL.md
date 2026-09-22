---
name: zoe-reskill
description: Create, improve, or delete a skill from the plan.
---

> ZOE Core file — read-only.

You carry out one change to your own skills. You do not decide what to change.

Read: the single change you were given; for improve or delete, the existing skill.

Skill file frontmatter — every skill you write uses this:

```yaml
---
name: short id
kind: action | understanding
model-kind: <capability tier>  # optional; see below
description: what it does (action) or what it explains (understanding), and when to use it
version: integer; raise by one on each change
---
```

The `zoe-` skills came before this format, so do not copy their frontmatter as a model.

`model-kind` (optional): the capability tier this skill needs — the full rule is stated in
`## Models` in the instructions. Declare it when the skill runs as its own agent; omit
it when the skill runs in the manager's own context.
Keep `description` to one sentence — most hosts load it into context every session.

Body, in this order:
- Purpose: one or two lines.
- Required Reading (if any): the skills and files to read before using this one — a parent
  skill it builds on, an understanding skill, or a reference file (a skill may keep these
  in a references/ folder beside it). Name each explicitly; hosts do not find the folder on
  their own.
- When it runs (action skills) — the trigger. (Understanding skills are read, not run; say
  when to read them instead.)
- Reads: its inputs.
- Produces: its outputs and where they go.
- Must obey: the rules and gates that apply.
- Hand off: what runs next, if anything.
State what it does, not how to think.

Two kinds of skill:
- action — does something.
- understanding — exists to be read for orientation, not to act (for example, a skill that
  explains where this enterprise's data lives and how to reach it). Use these to record
  what you learn about your domain, so later cycles can read it.

Orthogonality: before a create or improve goes live, check the skill covers one
capability no other active skill covers (the orthonormal-basis rule — see `## Adding to
yourself` in the instructions); where it overlaps one, narrow or merge first.

Verify before it goes live: where a skill's success can be checked objectively, write the
check and make it pass before the skill becomes active — do not rely on eyeballing a run.
Where it cannot be checked that way, say so in the skill, and lean on the slower measures
and audits instead.

Possible actions:
- create: write a new file in this format; record where your skills are kept in your index
  if this is the first one. A create may instead be a sub-enterprise: start another
  agent under the charter and hard rules the plan derived (no looser than yours), record it
  in your index; it reports to you.
- improve: write a new version. The target may be the enterprise instructions rather than a
  skill (see `zoe-redesign`).
- delete: remove it from your active skills

How: build the new version beside the old, check it, switch to it; never edit in place a
file you are currently running on.

Never take a gated action that has not been approved.

Log every change: what, why, and the version before and after.
