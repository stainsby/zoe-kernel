> Copy this into your own index and fill it in at setup. The AI keeps it current afterwards.
> Source template: zoe-setup/assets/index.template.md

# Index

Where everything is, and the settings you run by. Fill in each line as you set that thing up.

Three rules for this file. Write down where things are and what they are set to; how they
work belongs in a skill. Write only what is true now; what changed belongs in the log. Where
you know you will need somewhere to keep something but have not set it up yet, keep the line
and write "not yet created".

## Core

- enterprise name: {a name for this enterprise, used in your log and when you send feedback}
- where the charter is: {the file or place holding it}
- how to reach a director: {how you contact them for approval, feedback and instructions, and
  how they answer. You cannot run unattended until this is filled in.}
- directors: {who they are — in general terms, or listed individually. Where there are
  several, any one of them can do anything a director can do; if that is not how you want
  it, say here what the arrangement is.}
- where feedback arrives: {where messages from people using your work come in. Write "none"
  if there is nowhere yet.}
- schedule: {what "due" and "this cycle" mean here, and how often you run feedback and your
  checks. Checking for a new kernel has its own line below.}
- date and time: {the timezone to use — normally the director's — and the format. Always
  record the offset, like 2026-06-14T07:38:29+08:00, so times stay in order.}
- kernel version: {which version of the ZOE kernel you run on}
- where the kernel came from: {the ZOE project, or the enterprise above you. If you build
  your own kernel, say so. If you started from a ready-made enterprise design, you have two
  sources — list both, each with its version.}
- where the kernel's changelog is: {the list of what changed in each kernel version}
- how often to check for a newer kernel: {see `zoe-upgrade`}
- host packaging: {where the per-host files live — the stubs, README and settings that let a
  particular AI platform run this. They sit beside the kernel, never inside it.}
- which model does which job: {your skills ask for a kind of model, such as "heavy
  planning". Say which real model each kind means. See `## Models` in the instructions.}
- agents this enterprise runs: {which ones, and where their definitions live. Every session
  starts by checking they are all there, so this line is what that check reads.}
- known weaknesses: {anything about this setup that will keep looking like a fault but is
  not — for example a host that cannot run separate agents. Recorded here so it is not
  reported afresh every session.}
- where state is kept: {what is currently true}
- where the log is kept: {what has happened}
- where tasks are kept: {they must survive a restart, be listable, carry a status and an
  order — see `zoe-tasks`. Files, a database, an issue tracker: your choice, and if a
  tracker is already in use, use it.}
- where plans are kept: {redesign plans and the approvals they need, until the work is done}
- where reports are kept: {assessments, added to and never edited}
- where audit findings are kept:
- where your own skills are kept: {keep them separate from the ZOE skills}
- enterprises below you: {for each one, where its charter is and how it reports to you}
- tools: {how you reach the outside world}

## Other

{anything else this enterprise needs a home for}
