# The ZOE plugin for Claude

This folder packages ZOE as a plugin for Anthropic's Claude products, so that installing it is
two steps instead of the manual wiring in `hosts/claude-code/README.md`. It sits beside
`kernel/`, not inside it: packaging is not part of the kernel, and the kernel's rules bind
whichever way ZOE arrives.

**Everything here is specific to one provider, and the paths say so.** `plugins/claude/` holds
the packaging and `dist/claude/` holds what it builds. `plugin.json`, `marketplace.json` and
the `.claude-plugin/` directory are Anthropic's formats, not an open standard, and another
provider's plugin system would get its own `plugins/<provider>/` beside this one rather than
changing anything here. Only the skills themselves are portable: the Agent Skills format is an
open standard, so `kernel/skills/` stays host-neutral where it lives and this folder merely
copies it into the package at build time.

The repository is the catalogue; the plugin is a package built from it.
`.claude-plugin/marketplace.json` at the root lists one plugin, `zoe`, and points at
`dist/claude/plugin.zip` at the tag of a released version, pinned by SHA-256.

**The package is assembled, not declared.** `plugin.json` can name where components live, and
pointing `skills` at `kernel/skills/` does work in Claude Code — but it does not travel. Cowork
rejected that manifest with *"No agent files found in specified directories"*, having read the
file paths as directories, while `claude plugin validate` rejects a directory outright with
`agents: Invalid input`. No value satisfies both. So the build declares no component paths at
all and instead places everything where every surface looks by default: `skills/` and `agents/`
at the plugin's own root. The cost is that the kernel's skills are copied into the package
rather than served in place — regenerated every build, never edited, and the build is
reproducible, so a drifted copy would show up as a changed file.

Only the zip is committed. The assembled tree is staging, built in a temporary directory and
thrown away, so nothing may depend on it existing.

The agent stubs here are **not** the ones in `hosts/claude-code/agents/`, and the difference is
deliberate rather than duplication to be tidied away. Those name a `CLAUDE.md` and a workspace
path for the instructions, which is right for someone installing by hand on Claude Code and
wrong on Claude's other surfaces. `hosts/` serves people who are not using a plugin at all, and
is untouched by any of this. The stubs in `plugins/claude/agents/` name both routes and let the
enterprise's index say which one it uses.

## Installing

```
/plugin marketplace add stainsby/zoe-kernel
/plugin install zoe@zoe-kernel
```

Then, in the workspace that is to become the enterprise, ask Claude to set ZOE up. That runs
the `zoe-claude-init` skill, which is the other half of the install and is described below.

Where a surface offers no command line, the same two steps are in its own interface: add the
marketplace by its repository address, install the plugin, then ask Claude to set ZOE up. A
package at `dist/claude/plugin.zip` can also be uploaded directly, on the surfaces that accept a
plugin as a file — which is how to try ZOE in Cowork without registering anything.

## What arrives, and what actually works where

| | Claude Code | Cowork | Chat |
|---|---|---|---|
| The kernel's ten skills | yes | yes | unclear |
| `zoe-claude-init`, the one skill added | yes | yes | unclear |
| The three agents | yes | yes | no |
| Standing per-project instructions | yes, `CLAUDE.md` | yes, a project's **Instructions** field | no |

Skills are the only part every surface loads, so ZOE is built to stand on skills alone. The
rest changes how well it runs, not whether it runs.

**Chat is marked unclear because Anthropic's own documentation disagrees with itself**, and
guessing which half is right would be worse than saying so. The Cowork guide states that
plugins "are available in Cowork and Code" and "aren't used in Chat"; the support article
describes skills working in chat with hooks and sub-agents greyed out. Nobody here has tried
it. Treat Claude Code and Cowork as the supported pair until someone does.

**The instructions are the part that needs care.** They carry the gates, so they have to be in
front of the model before it decides anything — and a plugin cannot make that happen by itself,
because a `CLAUDE.md` at a plugin's root is not read as project context. The one added skill,
`zoe-claude-init`, closes that gap, and it is a one-off: run once when the ZOE is started, and
never again.

**It always writes the same file into the workspace**, `kernel/instructions/zoe.instructions.md`,
whatever the surface. That file is what the enterprise reads, what its index points at, and what
its upgrade comparison is made against. It deliberately does not live only in the plugin: a
plugin is replaced when it updates, and an enterprise must never have the rules it runs under
changed underneath it.

What differs is only whether the surface will load that file for you:

- **Claude Code** reads a project `CLAUDE.md` every session, so the skill adds the one-line
  import and the instructions become unconditional — the same property the manual install has.
- **Cowork** has no `CLAUDE.md`, but a Cowork *project* has an **Instructions** field —
  standing guidance applied to every session in that project — which does the same job. The
  skill cannot write that field, so it hands the person the exact line and asks them to paste it
  into the project's settings, and says in its report that the check rests on their
  confirmation.
- **Anywhere with neither**, the instruction file still goes into the workspace and the
  enterprise's index records that every session reads it first. That is the weakest of the
  three, and the enterprise is told to record it as a known weakness of its host: nothing but
  discipline puts the rules in context before the model acts.

The skill carries the instruction text in its own body as well, so it can write the file out
even where nothing can be copied from disk. That is a fallback for the writing, not a second
home for the instructions.

## Upgrades

An adopter's kernel should never change without their director agreeing to it — that is the
kernel's own rule, and adopting a new kernel replaces the rules the enterprise runs under.

Two things keep that true here. The marketplace points at a release tag rather than at a
branch, so what installs is a released kernel and never whatever `main` happens to hold. And
this is a third-party marketplace, for which automatic updates are off unless the adopter turns
them on. An update is therefore something they ask for; when they do, the kernel's upgrade
skill shows the changelog for the versions being crossed and asks the director before anything
is replaced.

## Building

`build.sh` is the release step. From the repository root:

```sh
plugins/claude/build.sh
```

It reads the version from `kernel/VERSION` and writes it into the package's `plugin.json`,
copies the kernel's skills in, generates `zoe-claude-init` from
`zoe-claude-init.template.md` and the kernel's instruction files, copies the agent stubs and the
licence, checks the counts add up, validates both manifests, writes the package, and finally
points the catalogue at it with the digest of the bytes it just wrote.

**The package always lands at `dist/claude/plugin.zip`** — one fixed path, naming the provider
whose plugin format it holds, with no version in the name or the path, so anything pointing at
the package keeps pointing at it release after release. It is built with a sorted file list and
fixed timestamps, which makes its bytes depend on content alone: rebuilding unchanged content
gives a byte-identical archive. That is what lets a release run the build and treat any
unexpected modified path as a fault.

**The digest is free here and worth having.** The usual argument against pinning `sha256` is
that it means editing the catalogue every release — but this build rewrites that entry every
time anyway. Without the pin, a stale copy served from a cache installs silently; with it, the
install fails loudly instead.

**Release ordering.** The catalogue names the zip at `v<version>`, a tag that does not exist
until it is made. So the zip is committed, then the tag is made and published, and only then is
the plugin installable from the marketplace. Until then the catalogue names a tag nobody can
fetch.

**Two limits of an archive source**, recorded so they are not rediscovered: it needs Claude Code
v2.1.224 or later, and it is not an accepted source for distribution through claude.ai
organisation settings, which take only `github`, `url`, `git-subdir` or a relative path.

Things worth knowing if you change it:

- **The skill and the package are generated.** Edit `zoe-claude-init.template.md`, or the
  kernel's instructions, and build again. The instruction text is inserted by a literal
  replacement, never by `sed` or `awk`: both interpret `&` and backslash escapes in the
  *replacement*, so prose containing either is corrupted silently.
- **The manifests need two validation runs, not one.** A tree holding a `marketplace.json` is
  validated as a catalogue and the plugin is never looked at, so the script validates the
  assembled plugin separately.
- **Do not declare component paths in `plugin.json`.** See above: the two surfaces disagree
  about what such a path means, and the disagreement is not resolvable.
