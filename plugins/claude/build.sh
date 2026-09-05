#!/usr/bin/env bash
#
# Build and check the ZOE plugin for Anthropic's Claude products. From the
# repository root:
#
#   plugins/claude/build.sh
#
# It assembles a plugin at dist/claude/plugin/ and packages it as
# dist/claude/plugin.zip — fixed paths naming the provider whose plugin format
# they hold, with no version in either, so anything pointing at the package keeps
# pointing at it release after release.
#
# WHERE THE CATALOGUE IS, AND WHY THIS BUILD NEVER TOUCHES IT. The marketplace
# listing this plugin lives in a separate repository, stainsby/zoe-plugins, and
# its entry is STATIC: a url and nothing else, pointing at this file through the
# moving `latest-release` tag. It needs no digest, because sha256 is optional and
# has no role in update detection once plugin.json carries a version; and it needs
# no version, because a version on the entry is silently overridden by the one in
# plugin.json. So nothing here changes release to release, and the build has
# nothing to tell the catalogue. Publishing is moving the tag.
#
# WHY IT ASSEMBLES rather than serving the repository as the plugin. plugin.json
# can name where components live, and pointing "skills" at kernel/skills/ works
# in Claude Code. It does not travel: Cowork rejected the same manifest with "No
# agent files found in specified directories", having read the file paths as
# directories, while `claude plugin validate` rejects a directory outright with
# "agents: Invalid input". No value satisfies both. So nothing is declared and
# everything is placed where every surface looks by default — skills/ and
# agents/ at the plugin's own root.
#
# Re-running on unchanged inputs changes nothing, the zip included: it is built
# with fixed timestamps so its bytes depend on content alone. A release step can
# therefore run this and treat any unexpected modified path as a fault.
set -euo pipefail

cd "$(dirname "$0")/../.."
[ $# -eq 0 ] || { echo "usage: plugins/claude/build.sh (no arguments)" >&2; exit 2; }

src="plugins/claude"
zip_out="dist/claude/plugin.zip"

# The assembled tree is staging, not an artifact: only the zip is committed, so
# nothing may depend on these files being present afterwards.
out="$(mktemp -d)"
trap 'rm -rf "$out"' EXIT

fail=0
note() { printf '  %s\n' "$*"; }
bad()  { printf '  FAIL %s\n' "$*"; fail=1; }

version="$(cat kernel/VERSION)"
echo "ZOE plugin for Claude — kernel $version"

mkdir -p "$out/.claude-plugin" "$out/skills" "$out/agents" "$(dirname "$zip_out")"

# Leftovers from earlier shapes, removed by the build rather than by hand so a
# tree that has been through any of them converges. .claude-plugin/ held this
# repository's own catalogue until the marketplace moved to its own repository;
# two catalogues that can disagree are worse than the one that is authoritative.
rm -rf "dist/claude/plugin" ".claude-plugin" "$src/skills"

# --------------------------------------------------------------- manifests --
# The version is the update signal: an adopter receives a new kernel only when it
# changes, so it is read from kernel/VERSION and never typed by hand. It must not
# also appear in the marketplace entry — plugin.json's value wins there silently,
# so a value in both is a trap rather than a redundancy.
#
# defaultEnabled is false deliberately. The field
# defaults to true, which would load ZOE's skills in every project on the machine,
# including ones that are not enterprises. A ZOE is something you start on purpose.
# Note the marketplace entry's defaultEnabled would override this one, so the
# catalogue must not carry the field either.
echo "manifests"
python3 - "$version" "$out" <<'PY'
import json, sys, pathlib
version, out = sys.argv[1], pathlib.Path(sys.argv[2])

manifest = {
    "name": "zoe-kernel",
    "description": "ZOE — Zero Organisation Enterprises. The kernel an AI uses to run an "
                   "enterprise from a charter: a cycle of orient, redesign, reskill, run and "
                   "assess, with the decisions a human must make held at gates.",
    "version": version,
    "author": {"name": "Sam Stainsby"},
    "homepage": "https://github.com/stainsby/zoe-kernel",
    "repository": "https://github.com/stainsby/zoe-kernel",
    "license": "MIT",
    "keywords": ["zoe", "enterprise", "charter", "agent", "kernel"],
    "defaultEnabled": False,
}
(out / ".claude-plugin" / "plugin.json").write_text(
    json.dumps(manifest, indent=2, ensure_ascii=False) + "\n")
PY
note "plugin.json version -> $version   (no component paths declared)"

# ---------------------------------------------------------------- skills --
# The kernel's skills are copied rather than referenced. That is the cost of the
# portability above, and it is why the copy is regenerated from kernel/skills/
# every build and never edited in place.
echo "skills"
n=0
for d in kernel/skills/*/; do
  [ -f "$d/SKILL.md" ] || { bad "no SKILL.md in $d"; continue; }
  cp -R "${d%/}" "$out/skills/$(basename "$d")"; n=$((n+1))
done
note "ok   $n kernel skills copied"
[ "$n" -eq "$(ls -d kernel/skills/*/ | wc -l)" ] || bad "not every kernel skill was copied"

# One skill is generated: surfaces differ in what they load. Claude Code reads a
# project CLAUDE.md, so the instructions can be made unconditional there; Cowork
# has no such file. The skill covers both, and carries the instruction text so it
# can write the file out where nothing can be copied from disk.
#
# The text is inserted by a literal replacement, never sed or awk: both read
# escapes and & in the REPLACEMENT, so prose containing either is corrupted.
python3 - "$src" "$out" <<'PY'
import pathlib, sys
src, out = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])

template = src / "zoe-claude-init.template.md"
sources = sorted(pathlib.Path("kernel/instructions").glob("*.md"))
if not sources:
    raise SystemExit("no instruction files found under kernel/instructions/")

text = template.read_text()

banner = (
    "<!-- GENERATED by plugins/claude/build.sh from\n"
    "     plugins/claude/zoe-claude-init.template.md. Do not edit: edit the template and build\n"
    "     again. The release check regenerates this and treats any difference as a fault.\n"
    "     The instruction files in assets/ are copies of kernel/instructions/. -->\n"
)

head, sep, rest = text.partition("---\n")
fm, sep2, tail = rest.partition("---\n")
skill = out / "skills" / "zoe-claude-init"
(skill / "assets").mkdir(parents=True, exist_ok=True)
(skill / "SKILL.md").write_text(head + sep + fm + sep2 + "\n" + banner + tail)

# The instructions ship as assets, not inlined in the body. A skill's body is
# loaded whole when the skill activates, and most of that text is not needed at
# that moment; an asset is read only when it is used. It also makes what lands in
# the workspace a byte-for-byte copy rather than something written out of context.
for f in sources:
    (skill / "assets" / f.name).write_bytes(f.read_bytes())
print(f"  ok   zoe-claude-init generated, {len(sources)} instruction file(s) as assets")
PY

# ---------------------------------------------------------------- agents --
echo "agents"
a=0
for f in "$src"/agents/*.md; do cp "$f" "$out/agents/"; a=$((a+1)); done
note "ok   $a agent stubs copied"
[ "$a" -eq "$(ls "$src"/agents/*.md | wc -l)" ] || bad "not every agent stub was copied"

# The licence travels with the package: it is distributed on its own, away from
# the repository that explains it.
cp LICENSE "$out/LICENSE"
note "ok   LICENSE included"

# -------------------------------------------------------------- the gates --
# Both of these are absence-shaped, so each reports what it counted rather than
# staying silent when it has stopped looking at the right thing.
echo "gates"
[ -d "$out/bin" ] && bad "top-level bin/ in the plugin" || note "ok   no top-level bin/"
links=$(find "$out" -type l | wc -l)
[ "$links" -eq 0 ] && note "ok   no symlinks (counted $links)" || bad "$links symlink(s)"
skills_built=$(ls -d "$out"/skills/*/ | wc -l)
note "ok   $skills_built skills in the plugin ($n from the kernel, 1 generated)"
[ "$skills_built" -eq $((n + 1)) ] || bad "skill count does not add up"

# ------------------------------------------------------------- validation --
# Only the plugin is validated here. The catalogue is another repository's file
# and is validated there; a tree holding a marketplace.json would be validated as
# a catalogue and the plugin never looked at, which is why the two are separate
# subjects and no longer share a tree.
echo "validation"
if command -v claude >/dev/null 2>&1; then
  claude plugin validate --strict "$out" >/dev/null 2>&1 \
    && note "ok   plugin manifest, skills and agents" || bad "plugin manifest, skills and agents"
else
  bad "claude is not available, so the plugin manifest was not validated"
fi

# -------------------------------------------------------------- packaging --
# For the surfaces that install a plugin from an uploaded file, and for trying a
# build without installing it: claude --plugin-dir accepts the zip directly.
#
# Built with python rather than zip(1) so it is reproducible: entries sorted and
# every timestamp fixed. Without that the bytes change on every run and nothing
# downstream can tell a rebuild from a real change.
echo "package"
python3 - "$out" "$zip_out" <<'PY'
import pathlib, sys, zipfile

tree, out = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
FIXED = (1980, 1, 1, 0, 0, 0)

files = sorted(p for p in tree.rglob("*") if p.is_file())
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
    for f in files:
        info = zipfile.ZipInfo("zoe-kernel/" + str(f.relative_to(tree)), date_time=FIXED)
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = (0o755 if f.stat().st_mode & 0o100 else 0o644) << 16
        z.writestr(info, f.read_bytes())
print(f"  ok   {out} ({out.stat().st_size} bytes, {len(files)} files)")
PY

echo
if [ "$fail" -eq 0 ]; then echo "PASS"; else echo "FAIL"; fi
exit "$fail"
