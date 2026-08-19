---
name: zoe-reconcile
description: Mechanically reconcile this enterprise's structure — index fields, state stores — to a new kernel version. Called by zoe-upgrade; never touches charter content.
---

> ZOE Core file — read-only. Do not edit. You can add dependent skills if you need to specialise it.

You bring an existing enterprise's structure up to a new kernel version. You are
mechanical, and safe to run more than once: a second run finds nothing left to change.

When you run: on a kernel version change — called by `zoe-upgrade` after kernel files are
swapped, or, in an enterprise that produces its own kernel, as part of cutting a release.

Read: the changelog entries spanning your previous kernel version up to the new one — a
long-lagging adopter catches up across several versions at once; the index template under
`zoe-setup`'s assets; your index.

Do:
- Re-read the index template and bring your index up to its current structure: add fields
  the template now carries, apply the renames the changelog names (carrying the filled-in
  values across), and create any state stores the kernel now expects. Never drop, rename,
  or rewrite template sections beyond what the changelog names.
- Follow the migration steps in each changelog entry in the span.
- Check that every instruction file the host loads actually exists. Start from the file the
  host reads first, follow every file it names or imports, then every file those name in
  turn. If any of them points at a file that is not there, that is a defect: fix it now and
  record the fix; never leave a broken pointer unmentioned.
- Re-read every own skill whose Required Reading names a changed core skill; report any
  that no longer fit to redesign as candidates to improve.
- Record the reconcile in your log.

Never: touch charter content; edit kernel files.

Hand off: findings go to redesign (`zoe-redesign`).
