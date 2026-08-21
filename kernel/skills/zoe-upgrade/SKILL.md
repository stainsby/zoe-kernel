---
name: zoe-upgrade
description: Check whether a newer ZOE kernel is available upstream and, with director approval, adopt it.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you
> need to specialise it.

Keep this enterprise's kernel in step with where it came from — the ZOE
project, or the parent enterprise that spawned this one.

When you run: on the checking schedule in your index, or when upstream announces a
new version. If the recorded schedule is a deliberate "no", you do not run; keeping up is
a director's choice, not an obligation.

The checking-schedule rule — the full rule is stated here; other skills point at it.
That schedule covers both how often to check for a newer kernel or upstream and
whether non-kernel artifacts need reconciling against the current kernel. Its value is a
real schedule (e.g. weekly, monthly) or an explicit, deliberate "no" — never silently
unset; `zoe-setup` asks at setup. It applies to every enterprise, however its kernel
arrived: even with no parent upstream, local kernel changes can leave non-kernel
artifacts needing reconciliation. When the recorded schedule has not been honoured,
`zoe-assess` raises an overdue finding. For a schedule measured in time, that means more
time has passed since `last upgrade check` than the schedule allows. For one triggered by
an event, it means the event happened and the reconcile never ran.

Read: `kernel version`, `where the kernel came from`, and `how often to check for a newer kernel` in your index; upstream's
current kernel and its `VERSION`.

Do:
- Compare versions. If upstream is not newer, stop.
- Show a director what changed between the two kernels, from upstream's changelog (shipped
  alongside the kernel; your index records where it is). Read the entries spanning your
  current version up to upstream's — a long-lagging adopter catches up across several
  versions at once. If you keep a copy of the kernel, also diff your copy against the new
  tree; if you symlink it, the changelog span is the authoritative account of what moved
  under you. Adopting a new kernel is always gated: it replaces the rules you run on.
- On approval: replace your kernel files whole with the new ones — never
  merge or hand-edit them — and update `kernel version` in your index.
- After swapping kernel files, call `zoe-reconcile` to bring the enterprise's structure up
  to the new kernel's shape; it follows the changelog span's migration steps and touches
  only structure, never the charter content.
- Reset `last upgrade check` in state to now (read from the real clock) — whether a check
  ran or was declined. Recording the date is deliberate even when the check was declined:
  it is state, written by the part allowed to write, not an edit to a read-only kernel
  file.
- Tell the enterprises below you (see your index) an upgrade is available. Each
  gates its own adoption; do not push it on them.

Never: adopt a kernel without approval; edit kernel files yourself.

Hand off: findings go to redesign (`zoe-redesign`).
