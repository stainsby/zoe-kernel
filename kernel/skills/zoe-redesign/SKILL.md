---
name: zoe-redesign
description: Decide what to change in your own skill set.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

Your purpose here is to decide what changes to make to this enterprise's own skill set —
not to make them. Carrying out the changes belongs to reskill (`zoe-reskill`).

You are read-only to the work itself: skills, the kernel, the charter, and the state that
represents the world are not yours to change. Persist your plan to the
place your index records for plans. The plan stays there until
reskill completes; the log records only that the plan was produced and what
became of it.

Read, before deciding: the charter, including its hard rules; the latest assessment report
(`zoe-assess`) and the findings of any audits you have established; your state and log;
and your existing skills — the `zoe-` skills and your own — together with what each one is
for. On the first cycle there is no assessment and there are likely no audits — use
whatever you have at hand: the charter, the verification and checks plan from setup.

Produce: an ordered list of changes. For each change, record:
- action: create | improve | delete
- target: one of your own skills, the host packaging recorded in your index, a
  sub-enterprise, or a short name for a new one
- why: one line
- reversible: yes | no
- cost: negligible | notable | breaches a constraint | unknown  (judged against the
  charter's Constraints)
- gated: yes | no  (yes if the charter's hard rules require approval, or the cost would
  breach a constraint)

Add, where applicable, **charter notes**: where the charter itself appears stale or
incoherent (typically surfaced by the assessment report's "Drifted" finding,
`zoe-assess`), name the offending text and the revision you would suggest.
The charter is read-only to you, so such changes are recommendations for a
director, never changes you make yourself; put them to a director with the approval
request, or on their own when nothing is gated.

## Gating

When any change is gated, the plan and the approval request are two separate artifacts.
The full plan stays where it was written. What goes to the director is a self-contained
artifact holding only the gated changes, nothing ungated. Each gated change appears in it
with its why, its cost, whether it is reversible, and the consequence of approving it and
of declining it; cite each by the name it carries in the plan's ordered list, and
reference the full plan for optional context. The request, like the plan, is a durable
artifact — persist it where your index accounts for it, and write it to the standard in
`## Communicating with directors` in the instructions.

## Rules

- Stay within the charter's hard rules. If the goal cannot be pursued without breaking
  one, do not work around it — stop and ask a director.
- The improve and delete actions never apply to a `zoe-` skill; it is specialised as
  described in `## Adding to yourself` in the instructions, never edited.
- Building and maintaining this enterprise's measures, checks, and audits is part of the
  work itself, not overhead to defer. An audit or check must be a separate skill from the
  work it inspects — the thing doing the work must never also be the thing that
  certifies it.
- Prefer the fewest changes that address the report, and actively look for skills of
  your own that can be deleted.
- Keep the skill set an orthonormal basis (see `## Adding to yourself` in the
  instructions): overlap between existing skills is grounds for narrowing them (improve)
  or merging them (delete).
- What the create action creates is normally a skill. The exception is a sub-goal with
  its own ongoing success and its own rules: create that as a sub-enterprise — a child
  agent under a charter you derive. Creating a sub-enterprise is gated.

Hand off: ungated changes go to reskill (`zoe-reskill`) as soon as the plan is done;
each gated change — and any change that depends on one — goes to reskill only once a
director has approved it.
