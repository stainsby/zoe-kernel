# ZOE kernel changelog

What changed in the ZOE kernel, per release, for adopters: one file per release, named by
the version it introduces. This directory ships **alongside** `kernel/` but is **not part of
it** (it is not counted in the "kernel stays small" measure, and it is not under the
kernel-immutability baseline).

Each entry exists to help you upgrade, not for reading: what changed, what it means for an
existing enterprise, which file to compare first, and what to do. Read every entry in the span
from the version you last reconciled against up to the current one.

How to read an entry:
- **Files** — the machine-derived added / removed / changed delta under `kernel/` for that
  release. Trivial host-rendering churn (frontmatter reserialisation, etc.) is excluded from
  the delta and called out separately where it occurred.
- **Size** — the kernel's size before and after, and why it grew where it did.
- **Adopter notes** — what changed and why it matters, which files/sections to compare
  first, any migration steps, and whether any of *your own* skills' "Required Reading" of a
  core skill is affected.
- Entries are framed **version X → Y** so an adopter on any earlier version can read the
  range up to current and catch up across several versions at once. Adopters who **symlink**
  the kernel are always on HEAD; "what changed since I adopted" is the span from the version
  they last reconciled against to current — read every entry in that span. Adopters who keep
  a **copy** diff their copy against the new tree and read the same span.

One terminology note, so older entries stay readable: what 1.0.0 calls an **approval
request** — the self-contained artifact put to a director for a decision that needs their
approval — earlier entries call a *gate ask*. Same thing; the term was retired in 1.0.0.

Where a historical detail could not be recovered, the entry says so rather than inventing it.
Entries for 0.1.0–0.5.0 were reconstructed after the fact from the maintainer's records.

*Corrections to older entries.* Entries are appended, never edited — with two marked
exceptions. At 1.3.0, quotations, approval narrative, pointers to the maintainer's private
records and a corrupted passage in the 0.14.1 entry were removed. In the release that split
this changelog into one file per version, every entry was trimmed to upgrade help: release
back-story, internal evidence and adopter names were removed. In neither pass was any entry's
account of what changed in its release altered, and every **Files** and **Size** paragraph is
as first published.

Size figures are over the whole `kernel/` tree. Up to 1.4.0 they are lines / words / bytes as
`wc` reports them, bytes authoritative; from 1.4.1 they are tokens (tiktoken `cl100k_base`)
with bytes beside them as the cross-check, tokens authoritative.

## Releases, newest first

- [1.4.1](1.4.1.md) — 1.4.0 → 1.4.1 (a work session does not open a management session by its own act; the worker brief's dispatch time is a clock reading)
- [1.4.0](1.4.0.md) — 1.3.0 → 1.4.0 (work and management sessions; tasks go to workers; an enterprise instructions file; checks run by something other than the agent; the changelog is a directory; the plugin ships VERSION and the changelog)
- [1.3.0](1.3.0.md) — 1.2.1 → 1.3.0 (test a check both ways; ZOE installs as a plugin)
- [1.2.1](1.2.1.md) — 1.2.0 → 1.2.1 (the kernel now asks for the index fields the 1.2.0 template actually creates)
- [1.2.0](1.2.0.md) — 1.1.0 → 1.2.0 (bookkeeping is watched and cut back; a defect's cause is decided rather than always filed; the setup templates are in plain English)
- [1.1.0](1.1.0.md) — 1.0.1 → 1.1.0 (setup sets up your agents; orient runs first and checks the wiring; the any-one-director default is stated)
- [1.0.1](1.0.1.md) — 1.0.0 → 1.0.1 (the charter template marks its two halves: Intent and Operating rules)
- [1.0.0](1.0.0.md) — 0.19.0 → 1.0.0 (first public-track release: the director's full kernel revision, the review of it, and the limited-context fix)
- [0.19.0](0.19.0.md) — 0.18.0 → 0.19.0 (the review release: three changes plus the full service of an independent kernel review — one blocker, seven major, thirteen minor fixes)
- [0.18.0](0.18.0.md) — 0.17.0 → 0.18.0 (three adopter-evidenced fixes: index-template store entries, host-adapter plan target, import-resolution check)
- [0.17.0](0.17.0.md) — 0.16.0 → 0.17.0 (the gate ask is split from the redesign plan; ungated work no longer waits)
- [0.16.0](0.16.0.md) — 0.15.0 → 0.16.0 (director's hand revision — director terminology, plain-language pass, plan-store and run-skill corrections)
- [0.15.0](0.15.0.md) — 0.14.1 → 0.15.0 (three adopter-evidenced instruction edits)
- [0.14.1](0.14.1.md) — 0.14.0 → 0.14.1 (VERSION-only — Zoe→ZOE terminology fix outside kernel/)
- [0.14.0](0.14.0.md) — 0.13.0 → 0.14.0 (zoe-orient — deterministic session entry)
- [0.13.0](0.13.0.md) — 0.12.0 → 0.13.0 (bounded-artifact wording)
- [0.12.0](0.12.0.md) — 0.11.0 → 0.12.0 (orthonormal basis)
- [0.11.0](0.11.0.md) — 0.10.0 → 0.11.0 (coherence + renames)
- [0.10.0](0.10.0.md) — 0.9.0 → 0.10.0 (channels)
- [0.9.0](0.9.0.md) — 0.8.0 → 0.9.0 (tasks + instructions-vs-data)
- [0.8.0](0.8.0.md) — 0.7.0 → 0.8.0 (setup dual-mode + upgrade-check)
- [0.7.0](0.7.0.md) — 0.6.0 → 0.7.0 (structural refactor)
- [0.6.0](0.6.0.md) — 0.5.0 → 0.6.0 (durable artifacts)
- [0.5.0](0.5.0.md) — 0.4.0 → 0.5.0 — agent hint
- [0.4.0](0.4.0.md) — 0.3.0 → 0.4.0 — charter coherence + reuse-first
- [0.3.0](0.3.0.md) — 0.2.0 → 0.3.0 — limited-context blind spot
- [0.2.0](0.2.0.md) — 0.1.0 → 0.2.0 — Tools section + repeatable checks
- [0.1.0](0.1.0.md) — 0.1.0 — first recorded baseline
