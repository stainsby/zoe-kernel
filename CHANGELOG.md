# ZOE kernel changelog

What changed in the ZOE kernel, per release, for adopters. This file ships **alongside**
`kernel/` but is **not part of it** (it is not counted in the "kernel stays small" measure,
and it is not under the kernel-immutability baseline).

How to read an entry:
- **Files** — the machine-derived added / removed / changed delta under `kernel/` for that
  release. Trivial host-rendering churn (frontmatter reserialisation, etc.) is excluded from
  the delta and called out separately where it occurred.
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

Where a historical detail could not be recovered, the entry says so rather than inventing it
(per the kernel's own verifiability rule). Entries for 0.1.0–0.5.0 were reconstructed on
2026-06-21 from the maintainer's own approval records, size history and immutability
baselines, which are not published.

Size figures are over the whole `kernel/` tree as `wc` reports them (lines / words / bytes);
bytes are authoritative.

---

## 1.2.0 → 1.2.1 (the kernel now asks for the index fields the 1.2.0 template actually creates)

A repair release. 1.2.0 rewrote the two setup templates in plain English, renaming thirteen
fields in the index template — and left the rest of the kernel telling you to read the old
names. If you filled in an index from the 1.2.0 template, nine of its skills sent you looking
for lines your index does not contain. Nothing crashed, and a capable agent bridges the gap,
but the kernel was asking for fields it had also told you not to create.

**Files:** 15 files, 0 added, 0 removed, **10 changed** — `kernel/VERSION`,
`kernel/instructions/zoe.instructions.md`, and the `zoe-assess`, `zoe-feedback`, `zoe-orient`,
`zoe-redesign`, `zoe-run`, `zoe-setup`, `zoe-tasks` and `zoe-upgrade` skills.

**Size:** 1001 / 9310 / 53791 → 1001 / 9350 / 53954 (lines / words / bytes). Growth of
+0 / +40 / +163, entirely from replacing short field names with the longer plain-English ones.

**Adopter notes.**

1. **Forty-two references repointed.** Every place the kernel named an index field it now
   names the one the template creates: `feedback intake` → where feedback arrives,
   `upgrade-check schedule` → how often to check for a newer kernel, `plan store`,
   `report store`, `state store`, `log store`, `task store` → where … are kept,
   `changelog location` → where the kernel's changelog is, `host-adapter layer` →
   host packaging, `tier-to-model mapping` → which model does which job, `sub-enterprises` →
   enterprises below you, `upstream` → where the kernel came from.

   Where a sentence only needed to point at something, it now describes it instead of quoting
   the label — "where your index says tasks are kept" rather than the literal field name. That
   leaves far fewer literal labels in the kernel, so a future rename breaks less.

   **`director channel` is deliberately unchanged**, all seven times it appears. It is a
   defined term in the instructions, not an index field label, and every use is the term.

   **Migration:** none. If you are on 1.2.0 with an index built from its template, this
   release simply stops sending you to fields that were never there. If your index predates
   1.2.0 and still uses the old field names, nothing here forces you to rename them — your
   index is yours, and the kernel reads whatever it says.

2. **`zoe-feedback` now says when to open it.** Its description was "Send or receive
   feedback.", which told a host nothing about when the skill applies — and since a host loads
   only descriptions, nothing anywhere triggered it. It now reads: *"Send the feedback you have
   gathered upstream, on the schedule your index sets. Also holds how feedback arriving from
   others is triaged."* **Compare first:** the frontmatter of
   `kernel/skills/zoe-feedback/SKILL.md`.

3. **A small plain-language fix carried over.** `zoe-setup` still asked for a route "or an
   explicit 'none', never a silent blank" — the same construction the 1.2.0 rewrite existed to
   remove. It now just says: a real route, or "none" written out.

## 1.1.0 → 1.2.0 (bookkeeping is watched and cut back; a defect's cause is decided rather than always filed; the setup templates are in plain English)

Three changes, all of them about a ZOE spending its effort on its own work rather than on
itself. Two came from watching this project's own machinery grow to fourteen internal skills
before being cut back to five; the third came from a director asking why the file every new
director has to fill in was not written in plain English.

**Files:** 15 files, 0 added, 0 removed, **4 changed** —
`kernel/instructions/zoe.instructions.md`,
`kernel/skills/zoe-setup/assets/index.template.md`,
`kernel/skills/zoe-setup/assets/charter.template.md`, and `kernel/VERSION`.

**Size:** 994 / 9201 / 53647 → 1001 / 9310 / 53791 (lines / words / bytes). Growth of
+7 / +109 / +144 — the smallest of any release so far, because two of the three changes
replace text rather than adding it.

**Adopter notes.**

1. **Watch what your own bookkeeping costs you.** A new bullet in the instructions'
   *Conduct* section asks you to keep an eye on how much effort goes on running yourself —
   records, checks, plans, skills about skills — rather than on the charter's work, and to cut
   it back in the cycle you notice it. It is deliberately a judgement and not a ratio: no
   number can tell you, and some enterprises are right to carry heavy record-keeping. This is
   encouragement, not a rule you can fail. **Compare first:** `## Conduct` in
   `kernel/instructions/zoe.instructions.md`.

2. **A defect's cause is decided, not automatically turned into a task.** The *Verification*
   section used to require two things of every finding, however small: fix it, and raise its
   root cause as a planning item. That manufactured work faster than any enterprise could
   finish it. It now asks you to record the cause, fix the defect, and record what you are
   doing about the cause — where "nothing, because there is nothing worth fixing" is a
   complete answer. In exchange it is stricter about repetition: if the same kind of defect
   turns up three times, the cause is raised or the matter goes to a director. And it states a
   preference that was missing: fix a cause by removing whatever allowed the defect, rather
   than by adding a rule against it.
   **Migration:** none required. If you built a rule or a skill around the old "always raise a
   planning item" wording, you may now retire it. **Compare first:** the paragraph after the
   bullet list in `## Verification`.

3. **The two setup templates are rewritten in plain English.** `index.template.md` and
   `charter.template.md` are what a director fills in when starting a ZOE, and they were
   written in the maintainer's shorthand — "host-adapter layer", "tier-to-model mapping",
   "feedback intake", "plan store". Someone setting up a ZOE to run a shop should not have to
   decode a phrase before filling in a line. The explanations are rewritten throughout and the
   opaque field names are replaced with plain ones: `feedback intake` becomes
   `where feedback arrives`, `tier-to-model mapping` becomes `which model does which job`,
   `host-adapter layer` becomes `host packaging`, and the five `… store` fields become
   `where … are kept`.

   The index template also gains three lines that 1.1.0's own features needed and it never
   provided: `directors` (the kernel says any one of several can act unless the index records
   otherwise), `agents this enterprise runs` (every session's opening wiring check reads it),
   and `known weaknesses` (without it, a host that cannot run separate agents is reported as a
   fresh fault at the start of every session).

   **Migration, if you already have an index:** rename the fields to match, keeping each
   value as it is, and add the three new lines. Nothing else changes; no behaviour depends on
   the old names. If you would rather keep your own field names, nothing breaks — the template
   is a starting point, and your index is yours.

**Also in this release, outside `kernel/`:** the Claude Code adapter's install instructions
gained fixes for six defects an install audit found — a guard so a failed first step cannot
leave a file named `*`, a runnable block for the final step, a derived rather than hardcoded
skill count, a correction to how the adapter describes its own agent stubs, and clearer
handling of the copy path, which installs files that refer to parts of the project the copy
path does not bring with it. The adapter also stopped asserting a rule the kernel does not
make, about clock readings in subagent launch briefs.

**Releases are now tagged.** Each release carries an annotated git tag `v<version>` on its
commit, so you can pin a submodule to a version rather than to a bare commit id. `v1.0.1` and
`v1.1.0` have been added retrospectively.

## 1.0.1 → 1.1.0 (setup sets up your agents; orient runs first and checks the wiring; the any-one-director default is stated)

Three capability-and-safety changes, each born from a real failure or a director's
question, all reviewed and amended by the maintainer before staging. Cut
2026-08-20T11:27+1000.

**Files:** 15 files, 0 added, 0 removed, **4 changed** —
`kernel/instructions/zoe.instructions.md`, `kernel/skills/zoe-orient/SKILL.md`,
`kernel/skills/zoe-setup/SKILL.md`, and `kernel/VERSION`.

**Size:** 963 / 8760 / 51141 → 994 / 9201 / 53647 (lines / words / bytes). Growth of
+31 / +441 / +2506, justified in the maintainer's size log per measure M4.

**Adopter notes.**

1. **Setup now sets up your agents.** A ZOE runs as three agents — a manager, a
   redesigner that plans changes to the ZOE's own skills, and an assessor that judges
   results — and `zoe-setup` now walks you through declaring them on your host and
   checks each is visible before setup finishes. How agents are declared differs by
   host; the `hosts/` folder holds a worked example for one host (Claude Code), which
   shows the shape but is not a specification. A host that cannot run separate agents
   is recorded in the index as a known weakness, so the trade is visible. This closes
   the failure where an install produced zero agents and the whole cycle ran in one
   context. **Compare first:** the "Set up the agents" bullet in
   `kernel/skills/zoe-setup/SKILL.md`.

2. **Orient runs first, every session, and checks the wiring.** `zoe-orient` is now the
   entry point for every session — not only cold ones — and its new first step verifies
   the wiring before anything trusts it: the index is visible as a skill, the agents the
   index names are visible. A failure hands off to
   `zoe-setup`; a limitation the index already records as a known weakness is not
   re-flagged. The instructions' cycle step 0 is now "Orient, then set up if needed".
   The skill's one-line description carries the run-first trigger, since a host
   hard-loads only descriptions. **Compare first:** `kernel/skills/zoe-orient/SKILL.md`
   (whole file — it also gained a fourth hand-off case and lost some prose), then step 0
   in `kernel/instructions/zoe.instructions.md`.

3. **Several directors: the default is now stated.** Where an enterprise has more than
   one director, any one of them can do anything a director can do, unless the index
   records a different arrangement — previously the kernel's silent behaviour, now its
   stated rule (see the **director** entry in the instructions' Terms). Setup asks one
   light question of a director team — is any-one-approves OK, and do their actions need
   auditing — and requires nothing beyond "that's OK": no roster, no roles.
   **Migration:** none required for any adopter; single-director enterprises are
   unaffected. If your own skills' Required Reading lists `zoe-orient` or `zoe-setup`,
   re-read them against the new text.

## 1.0.0 → 1.0.1 (the charter template marks its two halves: Intent and Operating rules)

A single change, and an organisational one: the charter template's sections are now grouped
under two headings so a director can see, while writing, that a charter holds two different
kinds of thing. Cut 2026-08-19T13:19+1000.

**Files:** 15 files, 0 added, 0 removed, **1 changed** —
`kernel/skills/zoe-setup/assets/charter.template.md`.

**Size:** 959 / 8755 / 51104 → 963 / 8760 / 51141 (lines / words / bytes). Growth of
+4 / +5 / +37: the two new heading lines and six added `#` characters, nothing else.

**Adopter notes.**

1. **The charter template now has two top-level headings.** `## Intent` covers Vision and
   Goals, Success, and Scope — what the enterprise is for, how you will know it is working,
   and where it stops. `## Operating rules` covers Hard rules, Constraints, and Preferences —
   how the agent must go about it. The six original sections keep their names exactly and sit
   beneath the new headings as `###`.

   The point is to make the distinction visible while a charter is being written. Intent
   changes when your intention changes, which is rare; operating rules move with
   circumstances — a new limit, a rule you no longer need — with the goal untouched. Knowing
   which half you are revising tells you whether you owe yourself a rethink or just an edit.

   **Compare first:** `kernel/skills/zoe-setup/assets/charter.template.md`.

2. **Migration: optional, and mechanical if you take it.** Nothing in the kernel reads a
   charter's heading levels, so an existing charter keeps working untouched and no skill's
   Required Reading is affected. If you want your charter to match the current template,
   insert `## Intent` before Vision and Goals and `## Operating rules` before Hard rules,
   then change the six existing `##` headings to `###`. Do not rename or reword anything —
   this release changed no section name and no guidance text. If your charter nests anything
   inside one of the six (a Definitions block, say), push it one level deeper so it stays a
   child rather than becoming a sibling.

3. **Nothing else changed.** No rule, no procedure, no skill. If you are on 1.0.0 and do not
   care about the charter template, there is nothing here you need.

## 0.19.0 → 1.0.0 (first public-track release: the director's full kernel revision, the review of it, and the limited-context fix)

This release carries three pieces of work, all director-approved: a rewrite of the
kernel's limited-context rule; the director's own full hand revision of the whole kernel;
and an independent review of that revision, with the director's decisions on each of its
findings. It is numbered 1.0.0 rather than 0.19.1 because the director decided the first
release on the public track would be 1.0.0. Cut 2026-08-17T13:50+1000.

**Files:** 15 files, 0 added, 0 removed, **13 changed**. Unchanged:
`kernel/skills/zoe-setup/assets/charter.template.md` and
`kernel/skills/zoe-feedback/assets/feedback.template.md` — the review found nothing to fix
in either, which is worth knowing since they are the two most director-facing files.

**Size:** 931 / 8467 / 49887 → 959 / 8755 / 51104 (lines / words / bytes). Growth of
+28 / +288 / +1217, about 3%. Almost all of it is note 1 below plus rules restored in
note 6; the plain-language pass is roughly size-neutral.

**Adopter notes.** Read these in order; the first is the one that changes behaviour.

1. **A gate no longer stops your enterprise — only the gated action.** Previously the
   kernel said "stop and ask" in five places without ever distinguishing halting the
   *action* from halting the *session*. On a host where asking a director ends the agent's
   turn — an agentic chat above all — that reading stalls a whole cycle at the first gated
   item. The instructions now state once, under *Stop and ask a director when*, that
   "Stop" halts the action in question and never the enterprise: you record the request and
   carry on with everything that does not depend on it. `## Conduct`, `zoe-run` and
   `zoe-orient` inherit that statement instead of restating it. A new section,
   *Communicating with directors*, sets when to actually put the accumulated questions to a
   director — when you run out of unblocked work, or at a scheduled contact point — with an
   explicit exception for anything that cannot safely wait. **Compare first:** the
   instructions' *Stop and ask a director when* and *Communicating with directors*.

2. **The limited-context rule was rewritten, and we owe you a correction.** The old bullet
   invited a fixed size cap, a check on every write, and a running summary kept *inside*
   the file being capped. Measured on this enterprise's own log, that summary grew one line
   per archived cycle and cut the usable budget from 391 lines to 299 in two months. The
   new text asks you to archive on a schedule, never lose history, and never evict the
   current cycle's own records.

   **The correction:** the 0.3.0 changelog pointed adopters at this enterprise's
   `artifact-budget` skill as the reference implementation of that rule. That design was
   the defective one. If you copied it, check for the same fault — a running summary living
   inside the capped file, and a size check that fires on every write.

3. **Index field renamed — migration step.** `upgrade-check cadence` is now
   `upgrade-check schedule`. Carry your existing value across unchanged; the meaning is
   identical, including the explicit, deliberate "no" option. Any of your own skills that
   read the field by name must be updated in the same change, or it silently stops
   resolving.

4. **Index field narrowed — migration step.** The general `schedule` entry no longer lists
   upgrade checks; they are governed solely by `upgrade-check schedule`. The two fields
   previously both claimed upgrade checks. If you wrote an upgrade cadence into your
   general `schedule` entry, move it to the dedicated entry and remove it from `schedule`,
   so exactly one field governs it.

5. **Sections renamed — check your own skills' Required Reading.** Any of your own skills
   that cite a kernel section by name may now point at nothing:
   - `## How you conduct yourself` → `## Conduct`
   - `## Outlook` → `## Can-do approach`
   - The director-reporting rule moved out of the conduct list into the new
     `## Communicating with directors`
   - In `zoe-upgrade`, "The cadence rule" is now "The upgrade-check schedule rule"

6. **"Gate ask" is retired in favour of "approval request"**, which the kernel already used
   for the same artifact in *Setting yourself up*. `zoe-redesign` also regained the full
   specification of what an approval request contains — why, cost, reversibility, and the
   consequence of approving and of declining — which the revision had reduced to "in the
   usual way", leaving it defined nowhere.

7. **A plain-language pass over all 14 files.** Jargon with plain equivalents was replaced
   throughout ("enumerable"/"statused" → "listable"/"tracked"; "always-loaded context";
   "instantiate"; "canonical statement"; "cadence"; "domain-agnostic"; "pure judgement, no
   side effect"), and filesystem assumptions were removed from store-agnostic text — a task
   store may be an issue tracker, so the kernel no longer speaks of folders where it means
   whatever your store provides. The one deliberately technical term kept is the
   orthonormal-basis metaphor, which defines its own three components inline.

   `zoe-redesign` also regained its read-list: it is told again to read your state, your
   log, and your existing skills before deciding what to change about them.

## 0.18.0 → 0.19.0 (the review release: three director-tasked changes plus the full service of an independent kernel review — one blocker, seven major, thirteen minor fixes)

Source: the director's 2026-08-12 tasking (an AI review of the whole kernel ahead of a
public release, plus three feedback-driven changes) — items
three director-tasked changes, plus the findings of an independent review of the whole
kernel (1 blocker, 7 major, 15 minor). Shipped after director approval (all six
decisions approved in-channel 2026-08-14, plus a follow-up pointer fix approved with the
director's read-through go) together with the morning approval of the three staged
changes. Cut 2026-08-14T12:12+10:00.
Kernel content is exactly the content the director approved, independently verified
byte-identical, plus the VERSION bump.

**Files:**
- added: none.
- removed: none.
- changed: `kernel/instructions/zoe.instructions.md` — new Terms entries ("host",
  defined once, replacing "engine"/"scaffold" throughout the kernel; "director channel"
  formatted and alphabetised); the "Sequencing" section renamed "Before running
  unattended" and its duplicate definition cut; `zoe-orient` now named at the
  resume-from-state line; the memory conduct bullet re-worded in plain English; a new
  conduct bullet: anything a director reads leads with what the director needs; the
  "super-human" clause cut; "span" glossed; "tier→model" now "tier-to-model"; the
  gated-stop rule trimmed from the Terms definition (the Stop-and-ask list and the
  conduct bullet remain, deliberately).
- changed: `kernel/skills/zoe-feedback/SKILL.md` — upstream posture: enterprises
  volunteer feedback upward unprompted and do not reply to feedback unless a reply is
  genuinely needed.
- changed: `kernel/skills/zoe-feedback/assets/feedback.template.md` — the
  source-template line now names the file that actually exists (`feedback.template.md`,
  dot not hyphen). This was the review's release-stopper: every derived copy carried a
  reference that resolved to nothing.
- changed: `kernel/skills/zoe-setup/SKILL.md` — setup now asks where each kind of
  record should be stored (source, audits, logs may belong in different storages);
  the charter-location step re-worded in plain English; setup records the setup date
  as `last upgrade check`'s starting value; the cadence-rule pointer follows the rule
  to `zoe-upgrade`.
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — new `changelog
  location` entry (closes the first-upgrade dead end: two skills read the changelog
  but no kernel file said where it lives); the `upgrade-check cadence` entry is now a
  setting plus a pointer (the rule moved to `zoe-upgrade`); the `upstream` entry
  defines "template ZOE" in place instead of citing a README that may not ship; the
  MCP example dropped.
- changed: `kernel/skills/zoe-setup/assets/charter.template.md` — "above user stories
  or specifications" is now "the big picture, not detailed plans or task lists".
- changed: `kernel/skills/zoe-upgrade/SKILL.md` — now carries the canonical
  upgrade-cadence rule (moved from the index template, which forbids behaviour in its
  own header); changelog wording points at the new index entry; the "honest snooze"
  sentence re-worded.
- changed: `kernel/skills/zoe-assess/SKILL.md` — points at `zoe-upgrade` for the
  cadence rule; reads `last upgrade check` from state (one home, not "state/index").
- changed: `kernel/skills/zoe-reconcile/SKILL.md` — "mechanical and idempotent" is now
  "mechanical, and safe to run more than once: a second run finds nothing left to
  change".
- changed: `kernel/skills/zoe-redesign/SKILL.md` — the restated orthonormal-basis rule
  cut (pointer and the improve/merge mapping stay); the "Drifted" finding attributed
  to the assessment report; reports-lead-with-director-needs change from the morning
  gate.
- changed: `kernel/skills/zoe-reskill/SKILL.md` — notes that the `zoe-` skills predate
  the mandated frontmatter format and version through `VERSION`; "engines" → "hosts".
- changed: `kernel/skills/zoe-orient/SKILL.md` — step 4's boundary made explicit:
  correct the record only; advancing the work waits for the hand-off.
- changed: `kernel/VERSION` — 0.18.0 → 0.19.0.
- `kernel/skills/zoe-run/SKILL.md` and `kernel/skills/zoe-tasks/SKILL.md` are
  byte-identical (same SHA-256) to the 0.18.0 baseline.

**Size:** 907 / 8199 / 48249 → 931 / 8467 / 49887 (+24 lines / +268 words / +1638
bytes; the three morning changes account for +13 lines and the review service +11 net —
the review's deletions were taken except two director-approved defensive keeps;
justification in the maintainer's size history).

**Adopter notes.** One release, two threads; compare `zoe.instructions.md`, the two
zoe-setup templates, and `zoe-upgrade` first — they carry the changes of substance.

- **If you copied the feedback template**, your copies name a source file that does
  not exist; new copies made from 0.19.0 are correct. Existing copies can be fixed by
  changing `feedback-template.md` to `feedback.template.md` in their source line.
- **Record your changelog location.** The index template now has an entry for it; add
  the equivalent entry to your live index at your next reconcile so `zoe-upgrade`'s
  instruction resolves.
- **The upgrade-cadence rule moved.** If any of your own skills cite the index
  template's `upgrade-check cadence` entry as the rule's home, repoint them at
  `zoe-upgrade`. The rule's content is unchanged.
- **Language pass.** "Host" is now the kernel's one word for the AI platform an
  enterprise runs on, defined in the instructions' Terms; jargon ("idempotent",
  "out-of-band", "user stories") is gone from director-facing text. If your own
  skills' Required Reading quotes kernel phrases, re-check the quoted wording.
- **Setup behaves differently in two places:** it now asks where each kind of record
  should be stored rather than defaulting everything into one repository, and it seeds
  `last upgrade check` with the setup date so the overdue test computes from day one.
- **Feedback posture:** volunteer feedback upward without waiting to be asked; do not
  reply to feedback unless a reply is genuinely needed.
- No migration steps beyond the above; no own-skill Required Reading target was
  renamed or removed.

## 0.17.0 → 0.18.0 (three adopter-evidenced fixes: index-template store entries, host-adapter plan target, import-resolution check)

Source: three feedback items relayed through the feedback intake against 0.17.0 —
deferred stores in the index template, the redesign skill's host-adapter target, and
silent import failures (two passed on from phaisor-synth, an
enterprise built on ZOE SDLC's base) — each independently confirmed against our own
kernel files, drafted on a staging branch, and shipped with director approval (all five
decisions approved in-channel
2026-08-09, including the standing trim commitment
a queued kernel-trim item, which rode this draft and closed with it).
Cut 2026-08-09T12:01+10:00. Kernel content is exactly the content the director approved,
plus the VERSION bump.

**Files:**
- added: none.
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — plan-store and
  report-store entries added, plus the "not yet created" convention for planned
  stores.
- changed: `kernel/skills/zoe-redesign/SKILL.md` — the host-adapter layer added as a
  valid plan target, and the target guard reworded to carry it.
- changed: `kernel/skills/zoe-reconcile/SKILL.md` — new import-resolution check: after
  any kernel version change, verify every file the host's instruction chain references
  actually resolves; a dead pointer is a defect, never silence.
- changed: `kernel/VERSION` — 0.17.0 → 0.18.0.
- removed: none.
- All 11 other `kernel/` files byte-identical (same SHA-256) to the 0.17.0 baseline.

**Size:** 902 / 8163 / 47993 → 907 / 8199 / 48249 (+5 lines / +36 words / +256 bytes;
the approved trims of the three touched files held the fixes to +5 lines where they
would otherwise have been roughly +16; justification in the maintainer's size history).

**Adopter notes.** Three independent fixes, each against a real adopter incident;
compare the three changed files above first — no other kernel file moved.

- **The setup index template now names the plan and report stores.** The template
  every new enterprise copies was missing entries for where redesign plans live and
  where assessment reports are written, though the kernel's own skills require both;
  an enterprise that filled the template faithfully reached its first assessment with
  nowhere to write it (hit independently by two enterprises —
  adopter feedback). The template also now marks
  any store that is planned but not yet created as "not yet created", so a gap is
  visible instead of silent.
- **Redesign plans may target host-adapter files.** `zoe-redesign` previously allowed
  a planned change to target only the enterprise's own skills, a sub-enterprise, or a
  new one — leaving the thin per-host launch files (agent stubs, host README,
  settings) with no legitimate place in a plan, though the kernel expects them to
  exist (adopter feedback). The host-adapter layer
  is now a named valid target.
- **Reconcile now checks that instruction references resolve.** After an upstream
  rename, an adopter's host kept pointing at an instructions file that no longer
  existed; nothing errored, and the agent ran every session with none of its process
  rules loaded (adopter feedback). `zoe-reconcile` — which
  runs at exactly the moment renames land — now verifies every file the host's
  instruction chain points at exists, and treats a dead pointer as a defect to fix.
  The host-side half (a host that resolves silently) remains beyond the kernel's
  reach.
- **Migration.** Add plan-store and report-store entries to your index if it lacks
  them (enterprises set up from earlier templates may have neither; mark a store you
  have planned but not created as "not yet created"). Then run `zoe-reconcile` for
  this version as usual — its new import-resolution check will exercise your host's
  instruction chain for the first time.
- **Required Reading:** `zoe-redesign` and `zoe-reconcile` changed among the skills —
  re-read any own skill or host stub whose Required Reading or text depends on either;
  `zoe-setup` itself is unchanged (only its index template asset moved).

## 0.16.0 → 0.17.0 (the gate ask is split from the redesign plan; ungated work no longer waits)

Source: a director-directed design item ("I def dont want
to see noise about what is not gated, and I don't want things held up that don't need
to be"), drafted with in-channel approval 2026-07-24 ("Yes, draft it"), and shipped after
the director was shown the complete diff and answered in-channel 2026-07-24: "Yes, ship it". Cut
2026-07-24T16:17+10:00. Kernel content is exactly that one staged commit plus the
VERSION bump.

**Files:**
- added: none.
- changed: `kernel/skills/zoe-redesign/SKILL.md` — the plan/approval-request split and
  the holding rule, detailed below (+25/−7 lines across the two content files).
- changed: `kernel/instructions/zoe.instructions.md` — cycle step 2 (**Gate**) only.
- changed: `kernel/VERSION` — 0.16.0 → 0.17.0.
- removed: none.
- All 12 other `kernel/` files byte-identical (same SHA-256) to the 0.16.0 baseline.

**Size:** 884 / 7928 / 46705 → 902 / 8163 / 47993 (+18 lines / +235 words / +1288
bytes; justification in the maintainer's size history).

**Adopter notes.** One behavioural change to how every ZOE runs its gate; compare
`zoe-redesign` (the new *The gate ask* paragraphs and the revised hand-off) first,
then cycle step 2 of the instructions.

- **Approval requests now carry only gated items.** Until now, a redesign plan
  containing any gated change was itself the approval bundle: the director was handed
  the whole plan, ungated detail and all. From 0.17.0 the plan and the approval
  request are two artifacts. The full plan stays in the plan store; what goes to a
  director is a separate, small, self-contained document holding only the gated
  changes — each with its why, its cost, whether it is reversible, and the consequence
  of approving and of declining — written in plain language, citing each change by the
  name it carries in the plan and referencing the full plan for optional context. The
  ask is durable: persist it where your index accounts for it.
- **Ungated work no longer waits on the gate.** Cycle step 2 now reads: put the gated
  changes — and only those — to a director; they and anything that depends on them
  wait for the decision, while everything else continues. The holding rule is
  deterministic: a change with no dependency on a gated change proceeds immediately; a
  change that depends on one holds until that gated change is decided.
- **Hand-off aligned.** Ungated changes go to `zoe-reskill` as soon as the plan is
  done; each gated change (and its dependents) goes only once a director approves it.
- **Migration.** If your index's plan-store entry states the old rule (the plan
  doubles as the approval bundle), reword it to the split; nothing else structural
  changes — no rename, no new file, no template change (`index.template.md` is
  byte-identical). Keep any effort-projection or similar charter-driven content your
  gate asks carry: the split changes the ask's scope, not your charter's constraints.
- **Required Reading:** only `zoe-redesign` changed among the skills, so re-read any
  own skill or host stub whose Required Reading or text depends on it — in particular
  any restatement that "a gated plan is the approval bundle", which is now wrong.

## 0.15.0 → 0.16.0 (director's hand revision — director terminology, plain-language pass, plan-store and run-skill corrections)

Source: the director hand-revised the whole kernel in-session over 2026-07-19 to
2026-07-23 and directed release preparation in-channel 2026-07-23 ("prepare to cut a new
kernel release"). The content needed no approval bundle — it is the director's own
edit; the action needing approval is the cut itself, approved in-channel and cut
2026-07-23T15:11+10:00. The release also carries a separately-approved edit (director "Fix now" 2026-07-19), noted
below.

**Files:**
- added: none.
- changed: all 15 `kernel/` files — the instructions, every skill, every template, and
  `kernel/VERSION` (0.15.0 → 0.16.0).
- removed: none.

**Size:** 860 / 7989 / 46930 → 884 / 7928 / 46705 (+24 lines / −61 words / −225 bytes;
justification in the maintainer's size history). Bytes are authoritative: the kernel
shrank. The line increase is re-wrapping of long lines to a narrower width.

**Adopter notes.** A director-authored, whole-kernel revision: terminology, prose
register, and several rule corrections. Compare the instructions' *Terms* section
first, then `zoe-redesign` and `zoe-run`.

- **"Director" is a defined term; "user channel" is renamed "director channel".** A
  director is an entity that directs a ZOE — by default, and always at the highest
  level, a human user. Every rule that said "human" now says "director". The index
  template's `user channel` field is renamed `director channel`. Migration: rename
  that field in your index, carrying its value across (`zoe-reconcile`'s
  template-driven step covers it), and update any of your own skills or documents
  that use the old term.
- **The Terms entry "core skills/instructions" is renamed "kernel"**, matching how the
  rest of the kernel already spoke. The charter's definition now states that only a
  director may revise it or approve revision to it.
- **Plan persistence corrected (`zoe-redesign`).** Every plan now persists in the plan
  store named in your index; a plan containing gated items also serves as the approval
  bundle, and the log records only that a plan was produced and what became of it. The
  old rule sent ungated plans to the log, which contradicted the log's history-only
  definition and made a revisable artifact live in an append-only store. Migration: if
  any live plan is recorded only in your log, move it to your plan store.
- **What falls due is work, not skills (`zoe-run`; cycle step 4).** Tasks and
  scheduled activities — audits, measures, checks — are what become due; a skill is
  the instruction sheet the work runs under. Tool acquisition left the description; it
  remains in the body (acquire a tool when work in hand needs one the index does not
  record).
- **New conduct rule: out-of-band memory is not durable.** A host's memory feature can
  be lost when the host changes; vital information goes to state, the log, or a store.
- **Skill descriptions minimised.** Every kernel skill description is cut to the
  ~25-word budget, and the format guidance in `zoe-reskill` now says to omit what a
  skill does not do.
- **`zoe-orient` loosened.** It runs at the start of any session where no specific
  direction was given, not only on "go".
- **Index template: the `upstream` entry now allows one update source per installed
  base** (staged edit dfc8e94, director-approved 2026-07-19 from ZOE SDLC feedback).
  A sub-ZOE built on a template ZOE has more than one update source — the ZOE project
  and its parent template: list each, with the version it is on. Migration: if your
  enterprise sits under a template ZOE, list both sources in your index's `upstream`
  entry.
- **Required Reading:** every kernel skill changed, so re-read any own skill whose
  Required Reading names a core skill. No kernel skill was added, removed, or renamed,
  so existing pointers stay valid.

## 0.14.1 → 0.15.0 (three adopter-evidenced instruction edits)

Source: a director-approved bundle of decisions (D1, D2, D4 approved
in-channel 2026-07-10T16:56:44+10:00) plus the already-approved work item
an adopter-evidenced item (MyMoney feedback, approved in-channel
2026-07-06). Cut 2026-07-10T17:08+10:00. All edits were staged separately and merged only at
this approved cut.

**Files:**
- added: none.
- changed: `kernel/instructions/zoe.instructions.md` — three edits, detailed in the
  adopter notes below.
- changed: `kernel/VERSION` — 0.14.1 → 0.15.0.
- removed: none.
- All 13 other `kernel/` files byte-identical (same SHA-256) to the 0.14.1 baseline.

**Size:** 848 / 7854 / 46139 → 860 / 7989 / 46930 (+12 lines / +135 words / +791 bytes;
justification in the maintainer's size history). The growth is entirely the instruction
edits; the VERSION string is the same length.

**Adopter notes.** Instructions only — no skill changed, no renames, no template file
changed. All three edits tighten existing rules on evidence from adopter incidents;
compare `kernel/instructions/zoe.instructions.md` sections *Terms*, *Setting yourself
up*, and *Template-derived files* first.

- **Creating stores after setup is now a planned change** (*Setting yourself up*, new
  second paragraph). The free hand to provision stores and conventions applies at setup
  only. Once set up, a new store or convention routes through redesign like a skill
  change, unless a human explicitly requests it in-session — in which case the request
  is recorded alongside the result. Either way, a store's usage conventions must be
  owned by a skill, new or existing, so its rules surface through normal skill reading.
  Migration: if any of your stores has conventions living only in a README or nowhere,
  give them a skill owner (this enterprise did the same for its own work store at this
  release). Evidence: an adopter built a new store in one session and its director
  challenged it as out of process.
- **Self-contained artifacts must use plain professional language** (*Setting yourself
  up*, third paragraph). The rule now reads: write the artifact in plain professional
  language and define every internal term at first use — not only the terms it coins.
  This widens the old "define the terms it coins", which did not catch kernel vocabulary
  used unexplained. Evidence: two director corrections at one adopter inside two weeks.
- **Rules stated in template prose are binding** (two related edits staged after 0.14.x). The *Terms* definition of **log** now states the operative
  rule directly: history lives only in the log — the charter, the index, and state carry
  what is currently true, never a narrative of past events. And *Template-derived files*
  extends the contract from a template's sections to the rules its prose states (the
  index template's "current state only — history lives in the log, never here" is the
  named example): those rules bind the derived file for its whole life, including
  through revisions. Migration: check your index and state files for narrative history
  and move any into the log. Evidence: an adopter treated template-embedded rules as
  decorative once the derived file existed.
- **No Required-Reading breakage.** No kernel skill's content changed, so no own skill's
  Required Reading of a core skill is affected. The changed file is the instructions,
  which every ZOE reads each session anyway — the new rules take effect on next read.

## 0.14.0 → 0.14.1 (VERSION-only — Zoe→ZOE terminology fix outside kernel/)

Source: director request in-channel, this session (2026-07-06): apply a director-supplied
patch correcting "Zoe" → "ZOE" terminology, then cut a release. Cut 2026-07-06T06:33+10:00.

**Files:**
- added: none.
- changed: `kernel/VERSION` — 0.14.0 → 0.14.1.
- removed: none.
- All 14 other `kernel/` files byte-identical (same SHA-256) to the 0.14.0 baseline.

**Size:** 848 / 7854 / 46139 → 848 / 7854 / 46139 (+0 lines / +0 words / +0 bytes;
justification in the maintainer's size history). The VERSION string is the same length
("0.14.0" → "0.14.1"), so the measured tree is byte-identical.

**Adopter notes.** No kernel content changed — this release exists solely to record a
terminology correction made OUTSIDE `kernel/`, in this enterprise's own non-kernel
documents: "Zoe" → "ZOE" (matching the charter's own defined term) in `README.md`,
`docs/charter.md`, the maintainer's measures skillSKILL.md`,
the maintainer's index, and the maintainer's adopter-ratings state.
History-tracking documents (this CHANGELOG's own past entries, the maintainer's work store*`,
the maintainer's log archive*`, the maintainer's size history) were deliberately left as-is — corrected
prose only, no history rewritten.

- **No Required-Reading breakage.** No kernel skill's content changed, so no own skill's
  Required Reading of a core skill is affected.
- **No migration steps.** Adopters symlinking the kernel pick up the VERSION bump only;
  adopters on a copy have nothing to diff beyond `kernel/VERSION` itself.
- If your own charter or README uses "Zoe" as a noun for a running instance, you may want
  to make the same "Zoe" → "ZOE" correction locally — it is a documentation-only fix, not
  a kernel behaviour change, so it is not required.

## 0.13.0 → 0.14.0 (zoe-orient — deterministic session entry)

Source: a director-approved bundle of decisions (change 5, approved
in-channel: "Accept; cut 0.14.0 this cycle"; kernel-skill form confirmed). Cut
2026-07-03T13:26+10:00. Staged on branch `kernel/0.14.0` in a separate worktree (the
enterprise's kernel-staging mechanism); merged to master only at this approved cut.

**Files:**
- added: `kernel/skills/zoe-orient/SKILL.md` — a new skill: a deterministic session
  entry, so a session opened with just "go" (or resumed after a drop) reaches the right
  next action from state and log, never from memory. Orientation, sweep, and dispatch
  only — it reads the clock, the index, the gate states, the task store, and the log tail,
  names the live trigger, and hands off; the work itself always runs under the skill it
  belongs to (`zoe-run`, `zoe-redesign`, or the interrupted step's own skill). It never
  runs the work.
- changed: `kernel/VERSION` — 0.13.0 → 0.14.0.
- removed: none.

**Size:** 807 / 7511 / 44168 → 848 / 7854 / 46139 (+41 lines / +343 words / +1971 bytes;
justification in the maintainer's size history). The growth is exactly the 41-line new skill.

**Adopter notes.** One new skill, no renames, no template change, no migration steps.

- **What it is:** `zoe-orient` names a capability every Zoe needs bootstrapped like the
  index — a repeatable cold-session entry (clock → index → gate sweep → task-store sweep →
  log tail → name the trigger → hand off) that fixes session drift without depending on the
  director to spot it. Compare `kernel/skills/zoe-orient/SKILL.md` first; it is self-
  contained.
- **Review your own session-entry-like skills for overlap.** If you have grown your own
  orientation / "start of session" / resume skill, it now overlaps `zoe-orient` — review it
  and either delete it or narrow it to a thin specialisation whose Required Reading lists
  `zoe-orient` (per the kernel's specialisation rule). This enterprise did exactly that:
  its own skill `orient` (the former `session-entry`) is deleted at this same release
  because `zoe-orient` now covers the capability.
- **No Required-Reading breakage.** No existing kernel skill changed, so no own skill whose
  Required Reading names a core skill is affected by content change; the only review prompt
  is the overlap check above.

## 0.12.0 → 0.13.0 (bounded-artifact wording)

Source: director-approved, with the exact diffs shown before approval. Evidence: index-narrative
and task-store drift observed in the kernel's own dogfooding enterprise on 2026-07-03. Cut 2026-07-03T11:16+10:00. First release staged on
a branch in a separate worktree (the enterprise's new kernel-staging mechanism).

**Files:**
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — the header contract now
  reads "…settings only — no behaviour. Current state only — history lives in the log,
  never here."
- changed: `kernel/instructions/zoe.instructions.md` — the limited-context rule names
  its artifacts: "(log, state, findings, the index, the task store)" replaces "(such as
  log, state, and findings)".
- changed: `kernel/VERSION` — 0.12.0 → 0.13.0.
- added / removed: none.

**Size:** 807 / 7498 / 44092 → 807 / 7511 / 44168 (+0 lines / +13 words / +76 bytes;
justification in the maintainer's size history).

**Adopter notes:** no migration steps. If your index carries history (rename notes,
"added after X" annotations, adoption dates), move it to your log — the index is
always-loaded context and now explicitly current-state-only. Check your artifact-budget
(or equivalent) covers your index and task store, not just log/state/findings.

## 0.11.0 → 0.12.0 (orthonormal basis)

Source: director-approved. The same concept entered the charter and README the same day, by
director direction. Cut 2026-07-03T10:50+10:00.

**Files:**
- changed: `kernel/instructions/zoe.instructions.md` — one bullet added to `## Adding to
  yourself`, the canonical statement: keep your skill set like an orthonormal basis in a
  vector space — each skill minimal (*normal*), no two overlapping (*orthogonal*),
  together spanning what the charter needs (*a basis*); a behaviour reachable by
  combining existing skills is not a new skill, and overlap between two skills is a
  defect to narrow or merge.
- changed: `kernel/skills/zoe-redesign/SKILL.md` — one rule added pointing at the
  canonical statement: a create must add a capability no existing skill covers; overlap
  between existing skills is grounds for an improve (narrow) or a delete (merge).
- changed: `kernel/skills/zoe-reskill/SKILL.md` — orthogonality check added before a
  create or improve goes live: the skill must cover one capability no other active skill
  covers; where it overlaps one, narrow or merge first.
- changed: `kernel/VERSION` — 0.11.0 → 0.12.0.
- added / removed: none.

**Size:** 795 / 7359 / 43235 → 807 / 7498 / 44092 (+12 lines / +139 words / +857 bytes;
justification in the maintainer's size history).

**Adopter notes:** no migration steps and no renames — this release only sharpens the
rules for skills you create yourself. Compare `## Adding to yourself` in the
instructions first; the zoe-redesign and zoe-reskill additions are one-pointer rules to
it. If your own skills' Required Reading names `zoe-redesign` or `zoe-reskill`, re-read
them against the new orthogonality rule: a pair of your skills that overlap is now
explicitly a defect to narrow or merge. Skill file format is unchanged.

## 0.10.0 → 0.11.0 (Release F — coherence + renames)

Source: a director-approved bundle of kernel critique findings (Release F scope). Cut 2026-07-03T06:44+10:00 under the director-approved bundle. Third
and final release of the bundle.

**Files (Release F scope):**
- removed: `kernel/skills/zoe-plan/SKILL.md` — RENAMED to `zoe-redesign` (F7a). The skill
  decides changes to your own skill set; it never planned the enterprise's work, and with
  tasks (0.9.0) in the kernel, "plan" collided with work-planning.
- removed: `kernel/skills/zoe-check/SKILL.md` — RENAMED to `zoe-assess` (F7b). The kernel
  reserves "check" for deterministic, repeatable procedures (see `## Verification`); this
  skill is the one non-deterministic judgement skill, so it no longer carries that word.
- added: `kernel/skills/zoe-redesign/SKILL.md`, `kernel/skills/zoe-assess/SKILL.md` — the
  renames; content unchanged apart from name, re-budgeted description, and hand-off names.
- added: `kernel/skills/zoe-reconcile/SKILL.md` — split from `zoe-setup` (F1): the
  mechanical, idempotent structure-reconcile on a kernel version change, called by
  `zoe-upgrade`. Follows the changelog span's migration steps; never touches charter
  content.
- changed: `kernel/skills/zoe-setup/SKILL.md` — reconcile mode removed (see
  `zoe-reconcile`); setup keeps first-setup + charter-revision help; upgrade-check bullet
  now points at the canonical index-template entry (F1, F2).
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — the `upgrade-check
  cadence` entry is now the canonical statement (including time-based vs event-based
  overdue semantics); `tier→model mapping` points at `## Models` (F2, F3).
- changed: `kernel/instructions/zoe.instructions.md` — cycle step labels now track the
  skill names: Setup, Redesign, Gate, Reskill, Run, Assess (F7c; "Author" had been stale
  since 0.7.0); one new sentence: an interrupted or failed step resumes from state and
  log, and repeated failure is a stop condition (F5); `## Adding to yourself` is the
  canonical specialise statement (F4).
- changed: `kernel/skills/zoe-reskill/SKILL.md` — model-kind and specialise paragraphs
  become pointers to their canonical statements (F3, F4).
- changed: `kernel/skills/zoe-run/SKILL.md` — estimate material costs before acting; an
  unestimable cost is unknown and gated where a constraint could plausibly be breached
  (F6); hand-off to `zoe-assess`.
- changed: `kernel/skills/zoe-upgrade/SKILL.md` — calls `zoe-reconcile` (was "zoe-setup in
  reconcile mode"); own-skill re-read moved into reconcile; hand-off to `zoe-redesign`.
- changed: `kernel/VERSION` — 0.10.0 → 0.11.0.

Size: 786 → 795 lines / 7418 → 7359 words / 43510 → 43235 bytes (+9 / −59 / −275) — a new
skill added, yet net smaller in words/bytes because the dedup landed in the same pass.
Bundle total (0.8.0 → 0.11.0): +107 lines / +954 words / +5830 bytes, above the bundle's
+45..+75-line estimate; per-release justifications are in the maintainer's size history.

**Adopter notes.** Two skill RENAMES and a new skill; migration steps:

1. **Update Required Reading and references**: any own skill naming `zoe-plan` now names
   `zoe-redesign`; any naming `zoe-check` now names `zoe-assess`. (Precedent: the 0.7.0
   `zoe-author`→`zoe-reskill` rename.) Your index's plan/report-store wording may also
   name the old skills — carry the values, update the names.
2. **Rename host stubs** if you carry them (this repo's `hosts/` stubs are now
   `zoe-redesigner` / `zoe-assessor`), and re-link any host mirror (e.g. `.claude/skills/`)
   that points at the old paths.
3. **Reconcile is its own skill now**: on future upgrades `zoe-upgrade` calls
   `zoe-reconcile`; nothing to do beyond knowing where the behaviour lives. `zoe-setup` is
   first-setup + charter help only.
4. **Canonical statements moved**: upgrade-check cadence semantics → the index template's
   entry; model-kind → `## Models` in the instructions; specialising a `zoe-` skill →
   `## Adding to yourself`. If your own skills restate these, point instead.
5. The cycle's step names in the instructions are now Setup, Redesign, Gate, Reskill, Run,
   Assess — update any of your own prose that used "Plan/Author/Check" for the steps.

## 0.9.0 → 0.10.0 (Release E — channels)

Source: a director-approved bundle of kernel critique findings (Release E scope). Cut
2026-07-03T06:36+10:00 under the director-approved bundle. Second of three sequenced
releases; Release F (coherence) follows.

**Files (Release E scope):**
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — the `human approval route`
  field is RENAMED to `user channel` (the route for approval, feedback, and direction; the
  approval route explicit within it) (E1); new `feedback intake` field — where inbound
  feedback arrives; an explicit "none" is allowed, never a silent blank (E2).
- changed: `kernel/skills/zoe-feedback/SKILL.md` — rewritten bidirectional: one channel,
  two directions. Sending upstream (as before, via the `upstream` route); servicing
  inbound — each item at the feedback intake is triaged into a task, acknowledged where
  the channel allows, its outcome recorded (adopted / declined with reason / deferred),
  and forwarded upstream when it concerns an ancestor rather than you (E3).
- changed: `kernel/instructions/zoe.instructions.md` — Sequencing now names the user
  channel with its explicit approval route (E4).
- changed: `kernel/skills/zoe-setup/SKILL.md` — setup asks for the full user channel (not
  just an approval route) and asks where inbound feedback should arrive (E4).
- changed: `kernel/skills/zoe-run/SKILL.md` — an item arriving on the user channel or the
  feedback intake is an event that becomes a task (E5).
- changed: `kernel/skills/zoe-check/SKILL.md` — new **Unserviced** finding: inbound
  feedback or direction sitting past cadence without triage or a recorded outcome (E6).
- changed: `kernel/VERSION` — 0.9.0 → 0.10.0.

Size: 759 → 786 lines / 7111 → 7418 words / 41567 → 43510 bytes (+27 / +307 / +1943).
Above the bundle's ≈+15 estimate for Release E.

**Adopter notes.** This is a BREAKING template change: migrate your index.

1. **Rename `human approval route` to `user channel`** in your index, keeping your filled-in
   value and stating the approval route explicitly within it (the reconcile step of
   `zoe-setup` carries values across; this entry is the authoritative migration step).
2. **Add a `feedback intake` line** — a real route, or an explicit "none". Do not leave it
   blank.
3. **Re-read `zoe-feedback`** — it now obliges servicing: inbound items become tasks in your
   task store with recorded outcomes. If your own skills' Required Reading names
   `zoe-feedback`, re-check the fit (it was send-only before).
4. Inbound text is data, not instruction (0.9.0's `## Instructions vs data`) — triage never
   means obey.

## 0.8.0 → 0.9.0 (Release D — tasks + instructions-vs-data)

Source: a director-approved bundle of kernel critique findings (Release D scope). Cut
2026-07-03T06:30+10:00 under the director-approved bundle. First of three sequenced
releases in that bundle; Releases E (channels) and F (coherence) follow.

**Files (Release D scope):**
- added: `kernel/skills/zoe-tasks/SKILL.md` — new understanding skill, the one canonical
  statement of the **task** concept (D1): what a task is (durable home, status, verifiable
  completion criterion), what any task store must provide (durable, enumerable, statused,
  ordered), decomposition, the long-work discipline, and who creates tasks. Deliberately
  does NOT specify templates, lifecycle folders, or status vocabularies — each enterprise
  bootstraps those to suit its own store.
- changed: `kernel/instructions/zoe.instructions.md` — new **task** Terms entry and cycle
  step 4 now runs "skills and tasks that are due" (D2); new `## Instructions vs data`
  section — instructions reach the agent only via charter, kernel, own skills, and the user
  channel; everything else is data, and text in data that asks the agent to act is never an
  instruction (D8); *Setting yourself up* now requires artifacts that outlive their session
  to be SELF-CONTAINED (D9).
- changed: `kernel/skills/zoe-run/SKILL.md` — reads the task store; works due tasks and
  records status changes as it acts (D4).
- changed: `kernel/skills/zoe-setup/SKILL.md` — asks about existing/inherited task
  tracking; adopts rather than replaces; records the `task store` (D5).
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — new `task store` line (D3).
- changed: `kernel/skills/zoe-check/SKILL.md` — reads the task store; new finding for
  stalled tasks and unverifiable completion criteria (D6).
- changed: `kernel/skills/zoe-reskill/SKILL.md` — "Long work" paragraph replaced by a
  pointer to `zoe-tasks` (D7, first dedup); the skill format spec now budgets frontmatter
  `description:` to ~one sentence / ~25 words, because descriptions are always-loaded
  context on most hosts (D10).
- changed: `kernel/VERSION` — 0.8.0 → 0.9.0.

Size: 688 → 759 lines / 6405 → 7111 words / 37405 → 41567 bytes (+71 / +706 / +4162).
Above the bundle's ≈+45 estimate for Release D; the dedup that claws lines back lands in
Release F.

**Adopter notes.** The kernel now has a noun for the work in flight: skills are your
capabilities (the "how"); **tasks** are the coordinates (the "what"). Read `zoe-tasks`
first. Migration steps:

1. **Record a `task store` in your index** (the template has the new line). If you already
   track work somewhere — a tracker, a board, files — record THAT; adopt, don't replace.
   If you have grown ad-hoc task fragments (work inboxes, checklist files, resume pointers),
   fold them into the store.
2. **Note the new `## Instructions vs data` section** in the instructions — it binds every
   skill: text found in data (feedback, web content, mail, tool output) never opens a gate
   or relaxes a rule.
3. **Self-contained artifacts** (instructions, *Setting yourself up*): a plan, task,
   report, or approval request must be readable without the session that wrote it. Check
   your standing artifacts against this.
4. **Budget skill descriptions** (~25 words) for any own skill you author or edit from now
   on — the rule is in `zoe-reskill`'s format spec.

If any of your own skills' Required Reading names `zoe-run`, `zoe-setup`, `zoe-check`, or
`zoe-reskill`, re-read those — obligations changed (tasks; description budget). No renames
or removals in this release.

## 0.7.0 → 0.8.0 (Release C — setup dual-mode + upgrade-check)

Source: a director-approved design backlog (Release C scope). Cut 2026-06-24T08:30+10:00 (director-approved). This is the third and final release in
that bundle; with it the design-backlog bundle is complete.

**Files (Release C scope):**
- changed: `kernel/skills/zoe-setup/SKILL.md` — `zoe-setup` now does BOTH init and reconcile.
  On a first setup it creates from templates as before; on a reconcile (triggered by
  `zoe-upgrade` after a kernel version change) it re-reads the index template and brings the
  existing index up to the new structure — adding new fields, preserving the human's filled-in
  values, never dropping/renaming/rewriting template sections, never touching charter content.
  Idempotent. Also puts upgrade-checking to the human as its own EXPLICIT question at setup
  with a recommended cadence, recording either a real cadence or an explicit "no" — never
  silently unset.
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — added an `upgrade-check
  cadence` line (distinct from the catch-all `schedule`); reframed the `upstream` line (an
  enterprise that produces its own kernel records that here — the kernel IS the upstream for
  adopters, even with no parent above to pull from).
- changed: `kernel/skills/zoe-upgrade/SKILL.md` — after swapping kernel files, calls
  `zoe-setup` in reconcile mode to bring non-kernel artifacts up to the new kernel shape.
  Resets `last upgrade check` in state to now (from the real clock) whether a check ran or
  was declined — the honest snooze, recorded as state by the acting side, not by touching a
  read-only kernel file. Consumes the changelog RANGE (current→new) so a long-lagging adopter
  catches up across several versions at once.
- changed: `kernel/skills/zoe-check/SKILL.md` — raises an OVERDUE FINDING when the
  `upgrade-check cadence` is unmet (for a time-based cadence: now − last-check > cadence; for
  an event-based cadence: the event landed and the reconcile did not run). Pure judgement, no
  side effect. Applies even with no parent upstream — local kernel changes can leave
  non-kernel artifacts needing reconciliation.
- changed: `kernel/VERSION` — 0.7.0 → 0.8.0.

Size: 643 → 688 lines / 5827 → 6405 words / 33669 → 37405 bytes (+45 / +578 / +3736). Growth
is the Release C additions (dual-mode setup, reconcile step, upgrade-check cadence, overdue
nudge). Justified by capability: post-upgrade enterprises are no longer silently
out-of-conformance with the kernel they run on, and upgrade-checking is no longer
silent-off-by-default.

**Adopter notes.** This release fixes two blind spots: setup was init-only (no reconcile
after a kernel version change), and upgrade-checking defaulted to silent-off. Compare
`zoe-setup/SKILL.md` first (the reconcile mode is the substantive change), then
`zoe-upgrade/SKILL.md` (the reconcile call + last-upgrade-check reset), then
`zoe-check/SKILL.md` (the OVERDUE FINDING). Migration steps:

1. **Re-run `zoe-setup` in reconcile mode** after adopting this kernel. It will add the new
   `upgrade-check cadence` line to your index (preserving your existing values) and bring
   your index up to the new template structure. It will NOT touch your charter.
2. **Add an `upgrade-check cadence` line to your index** if reconcile does not add it
   automatically. Record either a real cadence (e.g. weekly, monthly) or an explicit,
   deliberate "no" — never leave it silently unset. `zoe-setup` now puts this to you as its
   own question at setup.
3. **Add a `last-upgrade-check` state file** if you do not have one
   (the maintainer's upgrade-check state is this enterprise's home). `zoe-upgrade` resets it to
   now on each check/decline; `zoe-check` reads it against the cadence.
4. **Update your `zoe-upgrade`** to call `zoe-setup` in reconcile mode after a kernel swap,
   and to reset `last-upgrade-check` from the real clock.
5. **Update your `zoe-check`** to raise an OVERDUE FINDING on a cadence breach.

If any of your own skills' Required Reading names `zoe-setup`, `zoe-upgrade`, or `zoe-check`,
re-read them — the reconcile mode and the overdue nudge are new behaviour.

With this release the design backlog that defined Releases A, B and C is complete.

---

## 0.6.0 → 0.7.0 (Release B — structural refactor)

Source: a director-approved design backlog (Release B scope).
Cut 2026-06-23T08:50+10:00 (director-approved). This is the second of three sequenced
releases in that bundle; Release C follows as its own gated release.

**Files (Release B scope):**
- removed: all 10 `kernel/hosts/**` files — moved to a sibling `hosts/` directory (#4). The
  host-adapter layer is no longer part of `kernel/`; it lives alongside it.
- removed: `kernel/skills/zoe-author/SKILL.md` — renamed to `zoe-reskill` (#3).
- added: `kernel/skills/zoe-reskill/SKILL.md` — the rename, with the `name:` field updated
  and the `model-kind` format spec added to the skill format (#1).
- changed: `kernel/instructions/zoe.instructions.md` — added a `## Models` section (tier→model
  mapping in the index; the manager's own model is pinned at launch by the user) (#1); updated
  cycle step 3 `zoe-author`→`zoe-reskill` (#3).
- changed: `kernel/skills/zoe-plan/SKILL.md` — hand-off line `zoe-author`→`zoe-reskill` (#3).
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — added `host-adapter layer` and
  `tier→model mapping` lines so new enterprises get them at setup (#1/#4).
- changed: `kernel/VERSION` — 0.6.0 → 0.7.0.

Size: 811 → 643 lines / 7007 → 5827 words / 41043 → 33669 bytes (−168 / −1180 / −7374). The
kernel tree SHRANK because the host layer left it (10 files moved to `hosts/`). The `hosts/`
tree is excluded from this figure — it lives alongside `kernel/`, not inside it.

**Adopter notes.** This is a structural refactor. Compare the new `## Models` section in the
instructions first, then the skill format in `zoe-reskill` (was `zoe-author`). Migration
steps:

1. **Move your host adapters out of `kernel/`.** If you have `kernel/hosts/<host>/`, move it
   to a sibling `hosts/<host>/`. The kernel is now host-neutral in shape as well as in
   intent — host-specific packaging does not belong inside it.
2. **Rename `zoe-author` to `zoe-reskill`** if you carry a local copy (the skill is the same;
   only the name and the `model-kind` format addition changed). Update any references in your
   own skills.
3. **Add `model-kind` to your agent stubs.** Each agent stub should declare a capability tier
   (e.g. `heavy-planning`, `quick-check`), not a concrete model name. Add a `tier→model
   mapping` line to your index. The manager's own model is pinned at launch by the user.
4. **Rewrite your agent files as thin stubs.** Role logic lives in the kernel skills; the stub
   references the skill and carries only host-specific packaging (frontmatter, tool list,
   `model-kind`). The planner stub is born writable for its own plan (write + edit on the plan
   store); the checker stub is born with append-only write for its report (immutable once
   issued). Tool-enforcement is no longer a goal — the read-only-to-the-work rule is enforced
   by guideline, not host machinery.
5. **Add `host-adapter layer` and `tier→model mapping` lines to your index** (the setup
   template now carries them).

If any of your own skills' Required Reading names `zoe-author`, update it to `zoe-reskill`.
If any name a `kernel/hosts/...` path, update it to `hosts/...`. The `kernel-conformance-audit`
and `kernel-size-measure` own-skills in this enterprise were rescoped for the new boundary;
if you carry equivalents, rescope theirs too.

Release C (setup dual-mode + explicit upgrade-check cadence/nudge) is approved in design but
**not yet authored** — it ships as its own gated release.

---

## 0.5.0 → 0.6.0 (Release A — durable artifacts)

Source: a director-approved design backlog (Release A scope).
Cut 2026-06-21T20:55+10:00 (director-approved). This is the first of three sequenced releases
in that bundle; Releases B and C follow as their own gated releases.

**Files (Release A scope):**
- changed: `kernel/instructions/zoe.instructions.md` — added the locatability invariant
  (every produced resource has a defined home; the index is the registry) under *Setting
  yourself up*, and the defect-handling discipline (a finding obliges instance-remediation
  AND a root-cause planning item) under *Verification*.
- changed: `kernel/skills/zoe-plan/SKILL.md` — reframed from "read-only" to "read-only to
  the work; owns its own artifact"; the planner persists and may revise its plan in the plan
  store (gated plan = the approval bundle; ungated plan = the log).
- changed: `kernel/skills/zoe-check/SKILL.md` — same reframe; the checker writes its report
  to the report store, append-only / immutable once issued.
- changed: `kernel/skills/zoe-upgrade/SKILL.md` — consumes this changelog instead of
  hand-waving "show what changed".
- changed: `kernel/VERSION` — 0.5.0 → 0.6.0.

Size: 771 → 811 lines / 6532 → 7007 words / 38343 → 41043 bytes (+40 / +475 / +2700). The
changelog (this file) lives outside `kernel/` and is excluded from the figure.

**Adopter notes.** Compare the *Setting yourself up* and *Verification* sections of the
instructions first, then the opening of `zoe-plan` / `zoe-check`. If any of your own skills
build on `zoe-plan` or `zoe-check` via Required Reading, re-read them: the read-only framing
they relied on is now "read-only to the work, not to your own output." If you symlink the
kernel and have no plan/report store recorded in your index, add one. The changelog
(this file) and any host-adapter layer now live outside `kernel/`.

Release B (agents→skills by model-kind; `zoe-author`→`zoe-reskill`; host layer out of
`kernel/`) and Release C (setup dual-mode; explicit upgrade-check cadence) are approved in
design but **not yet authored** — each ships as its own gated release.

---

## 0.4.0 → 0.5.0 — agent hint

Source: director-approved.

**Files:**
- changed: `kernel/instructions/zoe.instructions.md` — one bullet appended to *Adding to
  yourself*: standing up an independent agent (not just a skill) is a valid way to keep
  decide/do/judge separate or give a subtask its own context, where the host supports it.
- changed: `kernel/VERSION` — 0.4.0 → 0.5.0.

Size: 774 → 771 lines / 6485 → 6532 words / 38165 → 38343 bytes (net lines fell despite the
added prose because of the host churn below).

*Host-rendering churn, not part of the delta (recorded as director-accepted, 2026-06-21):*
three `kernel/hosts/claude-code/agents/*.md` files were reserialised (frontmatter quoting,
`color:` keys, a stripped blank line), and `kernel/hosts/claude-code/settings.json` was
emptied to `{ }` (its `permissions.deny` block removed). The emptied deny is **intended** for
this dogfooding repo — editing `kernel/**` on approval is its whole purpose — and is not a
regression for downstream Zoes, where the read-only-kernel rule still applies. See
the maintainer's immutability baseline.

**Adopter notes.** If you stand up independent audits/judges, *Adding to yourself* now names
the agent option explicitly. No migration needed. No own-skill Required Reading is affected.

---

## 0.3.0 → 0.4.0 — charter coherence + reuse-first

Source: director-approved.

**Files:**
- changed: `kernel/skills/zoe-plan/SKILL.md` — added a **charter notes** output slot to the
  *Produce* section, giving the planner's charter-change recommendations a home (they ride in
  the approval request; the charter stays human-owned).
- changed: `kernel/skills/zoe-check/SKILL.md` — broadened the *Drifted* finding beyond
  template-structure drift to also cover stale/incoherent charter language (placeholder text
  left past its event; constraints/success that no longer match reality).
- changed: `kernel/instructions/zoe.instructions.md` — added a reuse-first balance to the
  build line in *Outlook* (do not rebuild what an existing skill/template/tool already does
  well; reuse when one fits, build when none does).
- changed: `kernel/VERSION` — 0.3.0 → 0.4.0.

Size: 766 → 774 lines / 6374 → 6485 words / 37479 → 38165 bytes (+8 / +111 / +686).

**Adopter notes.** Compare those two skills and the *Outlook* section. If your own skills
build on `zoe-plan` or `zoe-check`, re-read them — the planner now has a charter-notes slot
and the checker's drift detection is wider. No structural migration.

---

## 0.2.0 → 0.3.0 — limited-context blind spot

Source: director-approved.

**Files:**
- changed: `kernel/instructions/zoe.instructions.md` — third bullet appended to *Tools*:
  working artifacts (log, state, findings) grow without bound and crowd out context; keep
  them bounded (rotate / summarise / archive) without losing history; the *how* is recorded
  in your index.
- changed: `kernel/VERSION` — 0.2.0 → 0.3.0.

Size: 761 → 766 lines / 6311 → 6374 words / 37095 → 37479 bytes (+5 / +63 / +384).

**Adopter notes.** The kernel now expects an artifact-bounding approach recorded in your
index (this enterprise implements it as an `artifact-budget` own-skill; yours may differ).
If your index has no limited-context entry, add one. No own-skill Required Reading affected.

---

## 0.1.0 → 0.2.0 — Tools section + repeatable checks

Source: director-approved.

**Files:**
- changed: `kernel/instructions/zoe.instructions.md` — added the *Tools* section (no model
  has a reliable clock; read date/time from an authoritative source at the moment of use and
  record with timezone + sub-day granularity; no UTC imposed) and a repeatability rule in
  *Verification* (an audit/measure must give the same finding from the same inputs — pin it
  to a deterministic procedure).
- changed: `kernel/skills/zoe-setup/assets/index.template.md` — added a `date/time`
  convention field to *Core* (timezone to record in, format, read the clock — never assume).
- changed: `kernel/VERSION` — 0.1.0 → 0.2.0.

Size: 743 → 761 lines / 6123 → 6311 words / 36000 → 37095 bytes (+18 / +188 / +1095).

**Adopter notes.** Fill the new index `date/time` field at setup (or via the dual-mode setup
reconcile once that ships). The clock rule was evidence-driven — cycle 1 stamped an assumed
date across a midnight boundary. No own-skill Required Reading affected.

---

## 0.1.0 — first recorded baseline

The first version with a recorded immutability baseline and size measure (743 lines /
6123 words / 36000 bytes over `kernel/`), established 2026-06-13.

**Pre-0.1.0 bootstrap — partial record (honest blind spot).** The kernel's initial authoring
predates this project's approval and logging discipline. The version-control history before
the bootstrap commit is squashed, there are no version tags, and no approval records exist
for it. The shape of 0.1.0 is therefore knowable (the baseline
manifest and size are recorded) but the *sequence of pre-0.1.0 changes that produced it* is
not reconstructable file-by-file. This is stated rather than invented. An adopter on a
pre-0.1.0 / "~v1" kernel should diff their tree directly against the 0.1.0 baseline manifest
in the maintainer's immutability baseline (re-baselined per release) rather than rely on a narrative
that does not exist.
