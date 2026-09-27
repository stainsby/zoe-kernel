---
name: zoe-orient
description: Run first, every session — check the wiring, take bearings from state and log, and hand off.
---

> ZOE Core file — read-only.

## When it runs

Every session, including one opened for a specific director request and one on an
enterprise so new there is nothing to read.

## Steps, in order

1. Check the wiring before trusting it: the index exists and is visible to you as a
   skill; the agents the index says this enterprise
   runs are visible on the host. On a failure here — or no index at all — hand off to
   `zoe-setup`, which runs with a director, and record what was found.
2. Read the clock; every timestamp this session comes from it.
3. Read your index, and the director-specific index if there is one; everything else is
   located through them. Where the index says directors keep director-specific records and
   none are here, enquire: ask who is present. Among the index's directors, they are working
   in a new copy of the files: create their director-specific index and state and go on. Not
   among them, they have just joined: add them, create their records, and record in the log
   that they joined and when, so every other director sees it.
4. Check the gate states your index's approval route names. An approved decision that
   has not yet been acted on is news to act on; anything still gated is waiting.
5. Sweep the task store your index points at: reconcile each unfinished item's status
   against its completion criterion and evidence, correcting the record only, and flag
   contradictions.
6. Read the log tail and identify any interrupted step, to resume it from state and log —
   and any session still open there (see `## Terms` in the instructions), whose
   management-grade work you leave alone.
7. Name the live trigger — a director request, an approved item, inbound feedback, a due
   check — and from it the kind of session. State both to the director if one is present,
   before you hand off, so they can choose otherwise; ask only if you cannot tell.
   Record in the log that this session has opened, which director and which kind, before
   you hand off; a work session that finds management is needed records a planning
   item and carries on. Nothing due means report a short state summary and stop — offering
   a management session in that summary where one is due and this session may open it.

## Must obey

This skill ends at the hand-off; the work belongs to the skill you handed it to.

## Hand off

`zoe-setup` when the wiring check fails or the enterprise is blank; `zoe-run` for due
work; `zoe-redesign` in a management session; the interrupted step's own skill when
resuming; whatever a director's specific request needs, once the wiring check has passed.
