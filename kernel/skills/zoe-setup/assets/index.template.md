> Copied and filled out at setup, then managed by AI.
> Source template: zoe-setup/assets/index.template.md

# Index

The one file you keep updating: where the parts of your world are, and the settings you
run by. Record each item here as you set it up. Named locations, references, and settings
only — no behaviour. Current state only — history lives in the log, never here. A store a
skill will need but that is not yet created keeps its entry, marked "not yet created" — a
deferred store is visible here, never a silent absence.

## Core

- enterprise name: {unset — a name for this enterprise, used in your log and in feedback}
- where the charter is
- director channel: {unset — the route to reach a director for approval, feedback, and any other
  needed instructions. Make the approval route explicit within it; it must be set before
  you may run unattended.}
- feedback intake: {unset — where inbound feedback from downstream/adopters arrives, if
  anywhere; an explicit "none" is allowed, never a silent blank. Serviced by
  `zoe-feedback`.}
- schedule: {unset — what "due" and "this cycle" mean, and how often you run feedback and
  your audits. Upgrade checks have their own entry below.}
- date/time: {unset — the timezone to record and show times in (default: the director's
  own), and the format. Record times with an explicit timezone offset so they stay
  orderable, e.g. 2026-06-14T07:38:29+08:00.}
- kernel version: {set at setup — the ZOE kernel version this enterprise runs on}
- upstream: {unset — where this kernel came from and how to reach it: the ZOE project, or
  the parent enterprise. An enterprise that produces its own kernel (the ZOE project itself)
  records that here — the kernel IS the upstream for its adopters, even though there is no
  parent above to pull from. A sub-ZOE built on a template ZOE (a ready-made enterprise
  design it was started from) has more than one update source — the ZOE project
  and its parent template: list each one here, with the version it is on. Used by
  `zoe-feedback` and `zoe-upgrade`.}
- changelog location: {unset — where the kernel's changelog lives: the shipped list of what
  changed in each kernel version. Set at setup, or on first upgrade if the kernel arrived
  without one.}
- upgrade-check schedule: {unset — how often to check for a newer kernel and for needed
  reconciliation; the rule is in `zoe-upgrade`}
- host-adapter layer: {unset — where the per-host packaging lives (agent stubs, README,
  settings). Lives alongside `kernel/`, NOT inside it. Role logic stays in the skills; the
  stubs carry frontmatter, tool lists, and `model-kind` tiers.}
- tier-to-model mapping: {unset — the concrete model for each `model-kind` capability tier
  your skills declare. The full rule is stated in `## Models` in the instructions.}
- state store: {unset}
- log store: {unset}
- task store: {unset — where tasks live: durable, listable, tracked, ordered (see
  `zoe-tasks`). Files, a database, an issue tracker — the enterprise's choice; an existing
  tracker is adopted at setup, not replaced.}
- plan store: {unset — where redesign plans and their approval requests are kept until
  reskill completes (see `zoe-redesign`)}
- report store: {unset — where assessment reports are written, append-only (see
  `zoe-assess`)}
- audit findings: {unset — where your audits record their findings}
- your skills: {unset — where the skills you create are kept — recommended separate from the ZOE skills}
- sub-enterprises: {unset — each child: its charter location and how it reports to you}
- tools: {unset — how you reach the outside world}

## Other

{as needed}
