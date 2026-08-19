---
name: zoe-setup
description: First setup, with a director — write the charter and index and make a blank enterprise runnable. Also used when the director revises the charter.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

Use this skill when first setting up a ZOE. An alternative use for this skill
is if a director decides to revise their charter and asks for help.

You run with a director present, to turn a blank enterprise into a runnable
one. The normal cycle must not start without a completed charter.
You close that gap and hand over. (Reconciling an EXISTING enterprise to a
new kernel version is not this skill — see `zoe-reconcile`.)

Read: the charter and index templates under this skill in `assets`.

Open the conversation yourself; do not wait to be asked. Greet the director,
say you are set up to pursue a goal but do not have one yet, and invite them
to describe what they want in their own words, even loosely. Whatever they
first say — "help me manage my corner store", or even "what do I do here?"
— is your starting point, not a finished goal; help build the charter from it
with the steps below. Try to guide this to be at a high 'vision' level.

Do, with a director, through negotiation:

- Use the charter template to create the charter.
  - Ask where the charter should live. The top level of the enterprise's own
    storage is the usual choice.
  - Whenever you copy a template, fill in its source-template line so later edits can be
    checked against it (see *Template-derived files* in the instructions).
- If the enterprise already has assets or running processes — documents, code, accounts,
  habits — record them in the index and treat them as inherited state to bring under
  management, not to ignore.
- Task tracking: ask whether the work is already tracked somewhere — an issue tracker, a
  board, files. Adopt what exists rather than replacing it; if nothing exists, decide the
  store now. Either way record it in the index as `task store` (see `zoe-tasks`).
- Storage: ask, for each kind of record the enterprise will produce — state, log,
  audit findings, tasks, anything else — where it should be kept and who needs to
  read it. Different kinds may belong in different places (in a corporate software
  project, source code and audit results live in separate storages). Record each
  answer in the index against its store entry; keeping everything in one
  place is allowed, but as a recorded decision, never a silent default.
- Decide where new skills should be created.
  - The user may need help configuring their host to find these skills.
- Create a new skill that **is** the index.
  - It is a skill, not a plain file, so that every host is guaranteed to show it to
    the agent; do not "simplify" it into a loose document.
  - The index template can be copied to create an asset under the new skill (in `assets`)
  - Check the new skill is visible to you AS A SKILL — the director may need to give more setup help if it's not.
  - Immediately add the charter location and the kernel version (see `VERSION` beside the
    kernel's instructions and skills).
- Charter: ask for their vision, scope (in and out), what success looks like, and the hard
  rules — what the agent must never do, and what must get director approval first. Write the
  charter from their answers. They own and approve it; you do not invent the goal, and the
  hard rules are theirs to set, not yours.
- Constraints: ask what resources are limited — money, time, compute, attention, anything
  spendable — and what the limits and periods are. Write them into the charter's
  Constraints section. If nothing is limited, say so there rather than leaving it blank.
- Verification & checks plan: this is as important as the goal itself. For each strand of the
  vision-level success, agree the most checkable measure you can — a test, a logged outcome,
  a fixed-scale rating, a sampled review — and how often it is taken. Identify the
  independent audits this enterprise needs (for example money, safety, ethics, quality —
  whatever its risks demand) and how often each runs. Where a strand genuinely cannot be made
  checkable, name it as a known blind spot rather than inventing a number. A director reviews
  this; weak or gameable measures here cap everything later.
- Your index: fill in what is known now and you may write — the enterprise name, the
  schedule, the kernel version and upstream, and the director channel: the full route for
  approval, feedback, and direction, with the approval route explicit within it (you can
  record this because a director is here). Ask where inbound feedback should arrive and record
  `feedback intake` — a real route or an explicit "none", never a silent blank. Leave
  the rest (state store, log store, tools) unset; the cycle records those as
  it creates them.
- Upgrade-checking: put this to a director as its own EXPLICIT question with a recommended
  schedule, and record either a real schedule or an explicit, deliberate "no" in the
  index's `upgrade-check schedule` line — never leave it silently unset. Record the setup
  date in state as the starting value of `last upgrade check`. What the schedule covers,
  and why no enterprise is exempt, is stated in full in `zoe-upgrade`.

Before you finish: confirm the director channel — with its approval route explicit — is in
your index, because the cycle may not run unattended without it.

Hand off: once the charter is written and approved, the normal cycle takes
over at redesign (`zoe-redesign`).
