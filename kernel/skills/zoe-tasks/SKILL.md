---
name: zoe-tasks
description: Understanding — what a task is, what any task store must provide, and how long work is decomposed. Read before planning, running, or checking work.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

This is an understanding skill: it is read for orientation, not run. Skills
are your capabilities — the "how". Tasks are the work in flight — the "what".

## What a task is

A **task** is a unit of charter work with a durable home, a status, and a completion
criterion. Write the most verifiable completion criterion you can (see `## Verification`
in the instructions): a test, a logged outcome, a check that says objectively whether the
task is done — not "seems finished".

## What any task store must provide

The store itself is this enterprise's choice — files, a database, an issue tracker,
anything — recorded in the index under `where tasks are kept`. Whatever it is, it must be:

- **durable** — tasks survive dropped sessions;
- **listable** — you can list what is open;
- **tracked** — each task shows where it stands;
- **ordered** — it supports ordering and dependencies between tasks.

An enterprise that already tracks its work somewhere inherits that store at setup; adopt
it, do not replace it.

## Working tasks

- **Decomposition**: a task too large or complex for one session is broken into sub-tasks
  until each is sized for the work.
- **Long or many-item work**: keep the item list in the store, work one item at a time —
  never batch — and checkpoint after each, so the work survives a dropped session. Newly
  discovered items join the list.
- **Creation**: tasks are created by whatever identifies work — the plan, the director via
  the director channel, discoveries during run, inbound feedback.

Three things are deliberately left open: what a task record looks like, how tasks are
arranged as they move through their life, and what the status names are. Each enterprise
settles those for itself, to suit the store it chose.
