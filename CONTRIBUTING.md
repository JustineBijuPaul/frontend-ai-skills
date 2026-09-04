# Contributing to Frontend AI Skills

Thanks for helping improve this skill library.

**New skills and expanded skill docs are welcome.** Improve an existing `SKILL.md`, add a brand-new skill, or improve project documentation — all through a pull request. Direct pushes to `main` are blocked.

## Rules

1. **Use a pull request** for every change (skills, docs, installers, scripts).
2. **Do not push to `main`.** Branch from `main`, open a PR, wait for review/merge.
3. Keep changes focused when you can (one new skill or one coherent docs update per PR is ideal).
4. Run `./scripts/validate.sh` before opening a skill-related PR.

## What you can contribute

| Type | Encouraged? | Examples |
|------|-------------|----------|
| **New skills** | Yes | Add `skills/71-your-topic/SKILL.md` and register it in `manifest.json` |
| **Expand skill docs** | Yes | Deeper guidance, clearer contracts, examples, edge cases in any `SKILL.md` |
| **Project docs** | Yes | README, CONTRIBUTING, install docs, PR/issue templates |
| Installers | Yes | Categories, Windows/Unix install behavior |
| Tooling | Yes | `scripts/validate.sh` and related helpers |

There is **no fixed cap** on the number of skills. The library started at 70; contributors may add `71+` (or deepen existing ones) whenever it helps agents do better frontend work.

## Setup

```bash
git clone https://github.com/JustineBijuPaul/frontend-ai-skills.git
cd frontend-ai-skills
```

If you do not have write access, fork on GitHub first, clone your fork, then:

```bash
git remote add upstream https://github.com/JustineBijuPaul/frontend-ai-skills.git
git fetch upstream
git checkout -b your-branch-name upstream/main
```

## Workflow (required)

```bash
git checkout main
git pull origin main   # or: git pull upstream main

git checkout -b feat/add-71-css-container-queries

# edit skills / docs …
./scripts/validate.sh

git add -A
git commit -m "feat(skill): add 71-css-container-queries"
git push -u origin HEAD
```

Then open a PR against **`main`** (GitHub UI or `gh pr create --base main`).

## Adding a new skill

1. Pick the next free number and a kebab-case name, e.g. `71-css-container-queries`.
2. Create the file:

   ```text
   skills/71-css-container-queries/SKILL.md
   ```

3. Use this minimum shape:

   ```markdown
   ---
   name: 71-css-container-queries
   description: When and how to use CSS container queries in production UIs.
   ---

   # CSS Container Queries

   ## Purpose

   …

   ## AI implementation contract

   Act as a senior frontend engineer specializing in **CSS Container Queries**.

   Before implementation:
   - …

   During implementation:
   - …

   After implementation:
   - …
   ```

4. Register it in [`manifest.json`](manifest.json):
   - Append `{ "name", "path", "title" }` under `skills`
   - Set `"skill_count"` to the new total
5. Optionally add the skill id to a category in `install/install.sh` (`SKILL_GROUPS`) if it fits `core`, `animation`, `cinematic`, `3d`, or `quality`. (`--all` already installs every folder under `skills/`.)
6. Optionally mention it in the README catalog.
7. Run `./scripts/validate.sh` — it must pass.

## Expanding existing skill docs

You can freely improve any `skills/*/SKILL.md`:

- Stronger purpose / when-to-use guidance  
- Clearer AI implementation contract  
- Patterns, anti-patterns, accessibility, performance notes  
- Links to related skills in this repo  

No need to open an issue first for normal doc expansions — just open a PR.

## Expanding project documentation

Docs PRs are welcome for:

- [`README.md`](README.md) — catalog, install, stacks  
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — this guide  
- [`install/README.md`](install/README.md) — installer details  
- `.github/` templates  

## Commit messages

- `feat(skill): add 71-…`
- `docs(skill): expand 22-gsap`
- `docs: …`
- `fix(install): …`
- `chore: …`

## Pull request expectations

- Target **`main`**
- Fill out the PR template
- Explain *why* the skill or doc helps contributors/agents
- Run `./scripts/validate.sh` when skills or `manifest.json` change
- Do not push or force-push to `main`

## Review and merge

Maintainers review and merge into `main`. After merge, delete your feature branch.

## Questions

Open a GitHub issue for large redesigns (new category schemes, mass renames, breaking installer changes). For a single new skill or doc improvement, a PR is enough.
