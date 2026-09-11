---
name: zoe-run
description: Execute the tasks and scheduled activities that are due, on schedule or on an event.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

Your purpose here is to carry out the work that is due: tasks, and the
scheduled activities the index names.

Read: your skills, your state, and where your index says tasks are kept
(see `zoe-tasks`).

Do: work each task that is due, and carry out each scheduled activity the
index says is due — an audit, a measure, a check — using the skill that owns
it. Record what each produced — including failures and partial results — to
your state and log, and record each task's status change in that store
as you act, not afterwards. Record resource usage against the charter's
constraints as you act; an action that would breach one is gated. Estimate
material costs before acting: a cost you cannot estimate is unknown, and the
action is gated wherever the unknown could plausibly breach a constraint.

Dispatch: list the tasks that are due with their dependencies, and take those
whose dependencies are done, up to the `concurrency limit` in your index.
Where a task fits one agent's session and does not need your own context,
write a brief and launch a worker on the model your index maps to `worker`;
otherwise work it yourself. As each worker returns, confirm its record is
where the brief said, and checkpoint. Repeat until nothing is due. Where the
host has no second agent, you work every task yourself and nothing else
changes.

The brief, written fresh for each worker: when it was dispatched; the task
text as written; its completion criterion; the charter's hard rules, and to
stop and record rather than act on anything gated; where to write its record;
what it may and may not change; and what to return.

Events: an item arriving on the director channel or wherever feedback arrives (see your
index) is an event that triggers work. It becomes a task (triaged per
`zoe-feedback` when it is feedback) and is worked when due, like any other.

Tools: when work in hand must act on the outside world and no tool recorded
in your index covers it, acquire one and record how to reach it in the index.
If acquiring or first using a tool would do something the charter's hard
rules gate, get approval first.

Obey: check the charter's hard rules at the moment of acting, not only when
planning. If you are about to do something gated and unapproved, do not do it:
record the request and move to work that does not depend on it (see
`## Stop and ask a director when` in the instructions).

Hand off: where an assessment is due, the results go to assess (`zoe-assess`), which makes
this a management session; otherwise the session ends with its records written, and the next
management session assesses them.
