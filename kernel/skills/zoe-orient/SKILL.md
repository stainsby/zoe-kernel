---
name: zoe-orient
description: Run first, every session — check the wiring, take bearings from state and log, and hand off.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

A session should proceed from the current state and log — after checking the
wiring that carries them.

## When it runs

Every session starts here, even one opened with a specific director request, and even on
an enterprise so new there is nothing to read.

## Steps, in order

1. Check the wiring before trusting it: the index exists and is visible to you as a
   skill; the agents the index says this enterprise
   runs are visible on the host. On a failure here — or no index at all — hand off to
   `zoe-setup`, which runs with a director, and record what was found. A limitation the
   index already records as a known
   weakness (for example, a host that cannot run separate agents) is not a failure — do
   not re-flag it.
2. Read the clock — never assume the time.
   Every timestamp this session comes from it.
3. Read your index; everything else is located through it.
4. Check the gate states your index's approval route names. An approved decision that
   has not yet been acted on is news to act on; anything still gated is waiting.
5. Sweep the task store your index names: for each unfinished item, reconcile its status
   against its completion criterion and its evidence, not against memory. Record what you
   change in the store as you act. Flag any contradictions. Correct the record only;
   advancing the work itself waits for the hand-off.
6. Read the log tail and identify any interrupted step, to resume it from state and log.
7. Name the live trigger — a director request, an approved item, inbound feedback, a due
   check — and hand off. Nothing due means report a short state summary and stop.

## Must obey

Charter hard rules are checked at the moment of acting. Anything gated and unapproved does
not proceed — but that halts the gated item only: finish the sweep, record the request, and
hand off whatever is not blocked (see `## Stop and ask a director when` in the
instructions). This skill ends at the hand-off. Do not go on to do the work you just
handed over — that belongs to the skill you handed it to.

## Hand off

`zoe-setup` when the wiring check fails or the enterprise is blank; `zoe-run` for due
work; `zoe-redesign` when the trigger opens a full cycle; the interrupted step's own
skill when resuming; whatever a director's specific request needs, once the wiring
check has passed.
