#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Run this script from the repository root."
  exit 1
fi

git config user.name "${GIT_AUTHOR_NAME:-Frontend AI Skills Bot}"
git config user.email "${GIT_AUTHOR_EMAIL:-frontend-ai-skills@example.invalid}"

# Commit base files first.
git add README.md manifest.json install/ scripts/ .gitignore
git commit -m "chore: initialize frontend AI skills repository" || true

find skills -mindepth 2 -maxdepth 2 -name SKILL.md | sort | while read -r file; do
  skill="$(basename "$(dirname "$file")")"
  git add "$file"
  git commit -m "feat(skill): add $skill"
done

echo "Created one commit per skill."
