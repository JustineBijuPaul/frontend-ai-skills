#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

mapfile -t skill_files < <(find skills -mindepth 2 -maxdepth 2 -name SKILL.md | sort)
count="${#skill_files[@]}"

if [[ "$count" -lt 1 ]]; then
  echo "error: no SKILL.md files found under skills/" >&2
  exit 1
fi

for f in "${skill_files[@]}"; do
  if ! grep -q '^---$' "$f"; then
    echo "error: missing YAML front matter in $f" >&2
    exit 1
  fi
  if ! grep -q '^# ' "$f"; then
    echo "error: missing markdown H1 heading in $f" >&2
    exit 1
  fi
done

if [[ ! -f manifest.json ]]; then
  echo "error: manifest.json is missing" >&2
  exit 1
fi

manifest_count="$(python3 - <<'PY'
import json
from pathlib import Path
data = json.loads(Path("manifest.json").read_text())
print(int(data.get("skill_count", -1)))
PY
)"

if [[ "$manifest_count" -ne "$count" ]]; then
  echo "error: manifest.json skill_count ($manifest_count) does not match SKILL.md count ($count)" >&2
  echo "hint: when you add or remove a skill, update manifest.json (skills array + skill_count)" >&2
  exit 1
fi

python3 - <<'PY'
import json
import sys
from pathlib import Path

data = json.loads(Path("manifest.json").read_text())
skills = data.get("skills", [])
errors = []

names = set()
for entry in skills:
    name = entry.get("name")
    path = entry.get("path")
    title = entry.get("title")
    if not name or not path or not title:
        errors.append(f"manifest entry missing name/path/title: {entry!r}")
        continue
    if name in names:
        errors.append(f"duplicate manifest skill name: {name}")
    names.add(name)
    if not Path(path).is_file():
        errors.append(f"manifest path missing on disk: {path}")

disk_dirs = {p.parent.name for p in Path("skills").glob("*/SKILL.md")}
manifest_names = {e.get("name") for e in skills if e.get("name")}
for missing in sorted(disk_dirs - manifest_names):
    errors.append(f"skill on disk not listed in manifest.json: {missing}")
for extra in sorted(manifest_names - disk_dirs):
    errors.append(f"manifest lists skill with no skills/<name>/SKILL.md: {extra}")

if errors:
    for err in errors:
        print(f"error: {err}", file=sys.stderr)
    sys.exit(1)
PY

echo "Validated $count SKILL.md file(s). New skills are welcome — keep manifest.json in sync."
