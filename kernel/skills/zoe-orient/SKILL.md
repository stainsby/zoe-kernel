---
name: zoe-orient
description: Orient a cold session.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

A session opened with no fixed direction should proceed from the current
state and log.

## When it runs

At the start of any session with no specific directions given, for example:
a director simply says "go" (or equivalent).

## Steps, in order

1. Read the clock from the source your index names — never assume the time.
   Every timestamp this session comes from it.
2. Read your index; everything else is located through it.
3. Check the gate states your index's approval route names. An approved decision that
   has not yet been acted on is news to act on; anything still gated is waiting.
4. Sweep the task store your index names: for each unfinished item, reconcile its status
   against its completion criterion and its evidence, not against memory. Record what you
   change in the store as you act. Flag any contradictions. Correct the record only;
   advancing the work itself waits for the hand-off.
5. Read the log tail and identify any interrupted step, to resume it from state and log.
6. Name the live trigger — a director request, an approved item, inbound feedback, a due
   check — and hand off. Nothing due means report a short state summary and stop.

## Must obey

Charter hard rules are checked at the moment of acting. Anything gated and unapproved does
not proceed — but that halts the gated item only: finish the sweep, record the request, and
hand off whatever is not blocked (see `## Stop and ask a director when` in the
instructions). This skill ends at the hand-off. Do not go on to do the work you just
handed over — that belongs to the skill you handed it to.

## Hand off

`zoe-run` for due work; `zoe-redesign` when the trigger opens a full cycle; the
interrupted step's own skill when resuming.
