# Contributing to Frontend AI Skills

Thanks for helping improve this skill library. Contributions are welcome — **only via pull requests**. Direct pushes to `main` are blocked.

## Rules

1. **Use a pull request** for every change (skills, docs, installers, scripts).
2. **Do not push to `main`.** Branch from `main`, open a PR, wait for review/merge.
3. Keep changes focused: one skill, one fix, or one coherent docs update per PR when possible.
4. Run validation before you open a skill-related PR.

## Setup

```bash
git clone https://github.com/JustineBijuPaul/frontend-ai-skills.git
cd frontend-ai-skills
```

If you are not a collaborator with write access, fork the repo on GitHub first, then clone your fork and add the upstream remote:

```bash
git remote add upstream https://github.com/JustineBijuPaul/frontend-ai-skills.git
git fetch upstream
git checkout -b your-branch-name upstream/main
```

## Workflow (required)

```bash
# 1. Start from an up-to-date main
git checkout main
git pull origin main   # or: git pull upstream main

# 2. Create a feature branch
git checkout -b feat/short-description

# 3. Make your changes, then validate if skills changed
./scripts/validate.sh

# 4. Commit on your branch
git add -A
git commit -m "feat(skill): improve 22-gsap guidance"

# 5. Push the branch (never main)
git push -u origin HEAD

# 6. Open a PR targeting main
gh pr create --base main --title "Your title" --body "## Summary
- What changed and why

## Checklist
- [ ] validate.sh passes (if skills changed)
- [ ] manifest.json updated (if skills added/renamed/removed)
"
```

Or open the PR in the GitHub UI: **Compare & pull request** → base branch **`main`**.

## What you can contribute

| Type | Examples |
|------|----------|
| Skill content | Clearer guidance, better contracts, fixes in `skills/*/SKILL.md` |
| New skill | New folder + `SKILL.md`, update `manifest.json`, bump `skill_count` if needed |
| Installers | `install/install.sh`, `install/install.ps1`, category lists |
| Docs | `README.md`, `CONTRIBUTING.md`, `install/README.md` |
| Tooling | `scripts/validate.sh` improvements |

## Skill file conventions

Each skill must live at:

```text
skills/<nn-kebab-name>/SKILL.md
```

Minimum structure:

```markdown
---
name: nn-kebab-name
description: One-line description of when to use this skill.
---

# Human Title

## Purpose

…

## AI implementation contract

…
```

When adding a skill:

1. Create `skills/<name>/SKILL.md` with front matter and a `#` heading.
2. Add an entry to `manifest.json` (`name`, `path`, `title`).
3. Update `skill_count` in `manifest.json` if the total changed.
4. If it belongs in an installer category, update `SKILL_GROUPS` in `install/install.sh` (and the PowerShell equivalent if present).
5. Run `./scripts/validate.sh`.

## Commit messages

Prefer short, conventional messages:

- `feat(skill): add …` / `feat(skill): improve …`
- `fix(install): …`
- `docs: …`
- `chore: …`

## Pull request expectations

- Target **`main`**
- Fill out the PR template
- Describe *why*, not only *what*
- Link related issues when applicable
- Do not force-push to `main` or rewrite shared history in a PR unless maintainers ask

## Review and merge

Maintainers review PRs and merge into `main`. After merge, delete your feature branch.

If you have write access but cannot push to `main`, that is intentional — open a PR instead.

## Questions

Open a GitHub issue for discussion before large redesigns (new category schemes, mass renames, installer behavior changes).
