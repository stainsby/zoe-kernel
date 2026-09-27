---
name: zoe-upgrade
description: Check whether a newer ZOE kernel is available upstream and, with director approval, adopt it.
---

> ZOE Core file — read-only.

Keep this enterprise's kernel in step with where it came from — the ZOE
project, or the parent enterprise that spawned this one.

When you run: on the checking schedule in your index, or when upstream announces a
new version. If the recorded schedule is a deliberate "no", you do not run; keeping up is
a director's choice, not an obligation.

The checking schedule in your index — a real schedule or a deliberate "no", never left
unset; `zoe-setup` asks — covers both checking for a newer kernel and whether non-kernel
artifacts need reconciling to the current one, so it applies even to an enterprise that
builds its own kernel. When it has not been honoured — more time has passed since `last
upgrade check` than it allows, or the event it names has happened and the reconcile has
not run — `zoe-assess` reports it overdue.

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
  to the new kernel's shape.
- Reset `last upgrade check` in state to now, whether the check ran or was declined.
- Tell the enterprises below you (see your index) an upgrade is available. Each
  gates its own adoption; do not push it on them.

Hand off: findings go to redesign (`zoe-redesign`).
