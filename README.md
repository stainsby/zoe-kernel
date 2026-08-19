<p align="center">
  <img src="docs/images/zoe_logo.svg" alt="ZOE — Zero Organisation Enterprises" width="480">
</p>

# ZOE — Zero Organisation Enterprises

**A tiny kernel that grows into a whole operation.**

ZOE is a minimal set of agentic instructions and ten skills — the *kernel*. You
bring the vision: a business, a project, a portfolio, a life goal. ZOE turns it
into a **charter**, then builds, runs, and continuously improves the processes
needed to realise it — with you holding the controls that matter.

A running instance is called **a ZOE**, and the goal it pursues is its
**enterprise**. "Enterprise" here isn't corporate-speak; it's shorthand for any
high-level goal, from running a corner store to running your reading list.

Nothing else ships, and that's the point. The kernel assumes the AI is capable
enough to provision everything else — state, logs, tools, its own new skills —
as the enterprise demands it. Zero organisation in, a working organisation out.

## How a ZOE works

Once set up, a ZOE runs itself. You own the charter and approve the big calls;
it does the rest. Here's the lifecycle.

### Getting started

One conversation. The setup skill interviews you, drafts your charter — vision,
scope, success criteria, hard rules, resource constraints — and stands up the
**index**: the ZOE's own map of where everything lives and the settings it runs
by. The charter is yours: the agent never edits it, ever. It also can't run
unattended until it has a confirmed route to reach you, because without that,
nothing can be approved.

The charter is the whole input. Everything a ZOE does afterwards is traceable
back to it, so it is worth seeing one. Abbreviated, for a small shop:

```markdown
## Vision and Goals
Keep the shop trading profitably without me working weekends.

## Success
- Weekly gross margin at or above 28%, measured from the till export.
- No stockout of a top-20 line lasting more than 48 hours.
- I work no more than one weekend in four.

## Scope
In scope: ordering, rostering, supplier chasing, price reviews.
Out of scope: hiring and firing, anything involving the lease.

## Hard rules
- Ask first: any spend over $200; any change to supplier terms;
  any message sent to a supplier or customer in my name.
- Never discount below cost, even to clear stock.

## Constraints
- Money: $2,000 a month of stock spend, no more.
- My attention: one batched check-in a day, not a stream of questions.
```

That is enough for a ZOE to start. Note what the hard rules do: they name the
actions that stop and wait for a human. Everything not named there, the ZOE
decides for itself — so a charter is as much about what you are happy to
delegate as what you want done.

### The cycle — how work gets done

A ZOE runs a continuous loop:

```mermaid
flowchart LR
    R[1 Redesign] --> G{2 Gate}
    G -- ungated, or approved --> S[3 Reskill]
    G -- gated, not yet approved --> W([that item waits;<br/>the rest carries on])
    S --> N[4 Run]
    N --> A[5 Assess]
    A -- report --> R
```

1. **Redesign** — decide what to change in its own skill set, based on the
   charter and the last cycle's results.
2. **Gate** — anything the charter marks as needing your approval stops here
   until you say go. No exceptions: not for urgency, not for a clever shortcut.
3. **Reskill** — carry out the approved changes, one at a time.
4. **Run** — execute the skills and tasks that are due.
5. **Assess** — judge the results against the charter's definition of success,
   honestly, as a separate agent from the one that did the work.

Then back to step 1. Deciding, doing, and judging are deliberately kept apart —
the thing that does the work never gets to be the thing that certifies it.

### Self-improvement

Improvement isn't a feature bolted on; it's step 1 of every cycle. Each pass,
the ZOE redesigns its own skill set — creating skills it's missing, sharpening
ones that underperform, and deleting as readily as it adds, because a skill set
that only grows loses coherence. Every change is verified before it goes live,
and anything the charter gates waits for you.

### Staying current — upgrades

The kernel itself is read-only inside a ZOE — it never edits its own operating
system. Instead, the upgrade skill checks upstream (the ZOE project, or a parent
enterprise) for new kernel releases on a schedule you choose, and adopts one
only with your approval. A companion skill then mechanically reconciles the
ZOE's structure to the new version — never touching your charter.

### The feedback network

ZOEs talk. When a ZOE finds something the kernel — or a parent enterprise —
should do better, it writes the feedback up and sends it upstream. Feedback
arriving from downstream gets triaged and serviced. Improvements flow up;
releases flow back down. Every ZOE makes the next one better.

### Scaling out — sub-enterprises

When a sub-goal grows its own definition of success and its own rules, a ZOE
can propose spinning it off as a dependent enterprise — a peer or child ZOE
with its own charter, still human-directed at the top. Trees of enterprises
can evolve this way.

### Template ZOEs

Some ZOEs are abstract and not meant to be run as-is. They act as a blueprint:
a parent whose sub-ZOEs inherit instructions and skills the kernel cannot give
them — how to run a software project, keep books, do research, and so on. We
call these **template ZOEs**; *zoe-sdlc*, a template for software projects, is
one. To its sub-ZOEs, a template ZOE works the way the kernel works for every
ZOE: a versioned, read-only layer to build on without editing, send feedback
up to, and take new releases from. By convention a template ZOE ships that
layer in a folder called `base/` — deliberately not `kernel/`, which always
means the ZOE kernel itself — with its own VERSION and CHANGELOG files, like
the kernel's. A sub-ZOE built on a template then watches two places for
updates: the ZOE project and its parent template.

### Guardrails — gates and verification

Two things keep all this honest:

- **Gates.** The charter's hard rules name the actions that need a human first
  — spending money, publishing, changing key files, whatever you decide. A
  gated action that isn't approved simply doesn't happen; the ZOE stops and
  asks.
- **Verification.** ZOE treats "I can't verify this" as a problem to fix, not a
  condition to accept. Success is measured by checks, metrics, and logged
  outcomes — not by the agent's feeling that things went well — and independent
  audits run on their own schedule, separate from the work they inspect. What
  genuinely can't be measured gets flagged to you as a known blind spot rather
  than papered over.

## Design: one skill, one axis

The kernel's skills are built to work like an **orthonormal basis** — a concept
borrowed from linear algebra. In geometry, an orthonormal basis is the smallest
set of directions that lets you describe any point in a space: each direction
is unit-length (no bigger than it needs to be), the directions don't overlap
(each is at right angles to the others), and together they cover the whole
space.

The kernel's skills aim for the same three properties:

- **Minimal** — each skill is minimal: one job, done completely, nothing extra.
- **Independent** — no two skills overlap; each covers ground no other touches.
- **Complete** — together they span everything the cycle needs, so any behaviour
  a ZOE requires is a *combination* of skills, never a near-duplicate of one.

This is why the kernel can stay tiny without being incomplete — and the same
bar applies to the skills a ZOE builds for itself as it grows.

## The skills

The kernel is one instruction file plus these ten skills. Eight act; two
(`zoe-tasks`, and the reconcile helper called by upgrade) exist mainly to be
read or invoked by others.

| Skill | What it does |
| --- | --- |
| `zoe-setup` | First setup, with you present: writes the charter and index and makes a blank enterprise runnable. Also helps when you revise the charter later. |
| `zoe-redesign` | Decides what to change in the ZOE's own skill set — create, improve, delete — at the start of each cycle, as a separate agent from the ones that carry changes out. |
| `zoe-reskill` | Carries out one change from the plan: create, improve, or delete one of the ZOE's own skills. Never touches a kernel file. |
| `zoe-orient` | Orients a cold or resumed session — clock, index, gate states, task-store sweep, log tail — then names the live trigger and hands off. Never runs the work itself. |
| `zoe-run` | Executes the skills and tasks that are due, on schedule or on an event; acquires a tool where a skill needs one and lacks it. |
| `zoe-assess` | Judges each cycle's results against the charter's success criteria and issues an append-only report — as a separate agent from the ones whose work it judges. |
| `zoe-tasks` | An *understanding* skill: the canonical statement of what a task is, what any task store must provide, and how long work is decomposed. Read, not run. |
| `zoe-upgrade` | Checks whether a newer kernel is available upstream and, with your approval, adopts it. Optional — runs only if the index schedules it. |
| `zoe-reconcile` | Mechanically reconciles the ZOE's structure — index fields, state stores — to a new kernel version. Called by `zoe-upgrade`; never touches charter content. |
| `zoe-feedback` | The feedback loop, both directions: sends identified feedback upstream, and triages and services feedback arriving on the ZOE's intake. |

## How to use

Point your AI host at the kernel — the instruction file and the skills under
`kernel/` — and ask it how to proceed. ZOE opens the conversation itself: it
knows it has no goal yet, and it guides you through the first draft of your
charter. From there, the cycle takes over.

## Host capabilities

### What the host must provide

- At the top level, the most process-capable model available.
- A long-running loop, triggerable on a schedule and on events — though a human
  driving it through chat works too.
- Correct presentation of both core and dynamically created skills and
  instructions to the AI.
- A human-gate primitive: pause, ask a person, block until approved.
- Skill management and editing.

### What the host might provide

- Native tools.
- Tool access with dynamic acquisition (e.g. MCP).
- Sub-agents.
- Various forms of durable storage.
- Any other tools the enterprise might need and has decided not to build itself.

### Host adapters

The kernel is host-neutral and is the only thing ZOE prescribes. `hosts/`
carries adapters for specific hosts: agent files that enforce the decide / do /
judge separation by mechanism, plus install notes covering each host's strengths
and gaps. A *host* here is the assistant that runs the cycle, not the editor it
sits in — both adapters below can run inside VS Code, and they differ by which
assistant executes.

- `hosts/claude-code/` — **Claude Code**, as CLI or VS Code extension. This is
  the tested host: the ZOE project runs its own cycles on it.
- `hosts/github-copilot/` — **GitHub Copilot** custom agents, in VS Code.
  Best-effort and not yet exercised end to end; treat it as a starting point.

Treat them as workable examples, not part of the kernel proper — adapt them
freely to your setup, or write your own for another host. They may move to a
separate ZOE-related project in time.
