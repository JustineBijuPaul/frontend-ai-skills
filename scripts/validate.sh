#!/usr/bin/env bash
set -euo pipefail
count=$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md | wc -l | tr -d ' ')
test "$count" -eq 70
for f in $(find skills -mindepth 2 -maxdepth 2 -name SKILL.md); do
  grep -q '^---$' "$f"
  grep -q '^# ' "$f"
done
echo "Validated $count SKILL.md files."
