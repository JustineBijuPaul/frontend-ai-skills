# Frontend AI Skills

A modular library of frontend skills for AI coding agents. It ships with **70 skills** today, and **contributors are encouraged to add more** (new skills and richer skill docs) via pull request.

Each skill is a focused `SKILL.md` file an agent can load when working on architecture, React/Next.js, animation, 3D, accessibility, performance, testing, design-to-code, and more. Skills are independent so you can install everything or only the categories you need.

**Repository:** [github.com/JustineBijuPaul/frontend-ai-skills](https://github.com/JustineBijuPaul/frontend-ai-skills)

---

## Table of contents

- [What this project is](#what-this-project-is)
- [Repository layout](#repository-layout)
- [How a skill works](#how-a-skill-works)
- [Installation](#installation)
- [Skill categories](#skill-categories)
- [Full skill catalog](#full-skill-catalog)
- [Recommended skill stacks](#recommended-skill-stacks)
- [Scripts](#scripts)
- [Manifest](#manifest)
- [Contributing](#contributing)
- [License](#license)

---

## What this project is

| Item | Detail |
|------|--------|
| Purpose | Give AI agents production-oriented frontend guidance as reusable skills |
| Format | One folder per skill, each with a `SKILL.md` |
| Count | 70+ skills (see `manifest.json`; new skills welcome) |
| Install | Copy skills into a project or a global skills directory via `install/` |
| Not included | This is not an app or npm package — it is a skill/content library |

Use it when you want agents to follow consistent patterns for frontend engineering, cinematic scroll experiences, WebGL/Three.js, quality, and AI-assisted UI workflows.

---

## Repository layout

```text
frontend-ai-skills/
├── README.md                 # This file
├── CONTRIBUTING.md           # How to contribute (PRs required)
├── manifest.json             # Machine-readable list of every skill
├── .gitignore
├── skills/                   # All skill definitions (add more anytime via PR)
│   ├── 01-frontend-architecture/
│   │   └── SKILL.md
│   ├── 02-react/
│   │   └── SKILL.md
│   └── … (numbered skill folders)
├── install/
│   ├── README.md             # Installer notes
│   ├── install.sh            # macOS / Linux / WSL
│   └── install.ps1           # Windows PowerShell
├── scripts/
│   ├── validate.sh           # Validates SKILL.md files and manifest sync
│   └── create-history.sh     # Maintainer helper (optional)
└── .github/
    └── PULL_REQUEST_TEMPLATE.md
```

| Path | Role |
|------|------|
| `skills/<nn-name>/SKILL.md` | The skill content agents load |
| `manifest.json` | Name, path, and title for every skill |
| `install/` | Scripts that copy skills into `.ai-skills/frontend` (project or global) |
| `scripts/validate.sh` | Sanity-check skill files before merging |
| `scripts/create-history.sh` | Optional maintainer script; not required for normal use |
| `CONTRIBUTING.md` | Fork → branch → PR workflow (direct pushes to `main` are not allowed) |

---

## How a skill works

Every skill lives at:

```text
skills/<skill-name>/SKILL.md
```

A typical file has:

1. **YAML front matter** — `name` and `description` for discovery  
2. **Title and purpose** — what the skill covers  
3. **AI implementation contract** — how the agent should behave before, during, and after work  
4. **Domain guidance** — patterns, constraints, and practices for that topic  

Skills are modular: install or load only what matches the task (for example cinematic scroll, not the full set).

---

## Installation

### Prerequisites

- **Unix-like:** bash (macOS, Linux, WSL) for `install/install.sh`
- **Windows:** PowerShell for `install/install.ps1`
- Git

### Clone

```bash
git clone https://github.com/JustineBijuPaul/frontend-ai-skills.git
cd frontend-ai-skills
```

### Install all skills (into the current project)

```bash
./install/install.sh --project --all
# or simply:
./install/install.sh --all
```

Default project destination: `./.ai-skills/frontend`

### Install globally

```bash
./install/install.sh --global --all
```

- If `CLAUDE_HOME` is set → `$CLAUDE_HOME/skills/frontend`
- Otherwise → `~/.ai-skills/frontend`

### Install one category

```bash
./install/install.sh --category cinematic
./install/install.sh --category core
./install/install.sh --category animation
./install/install.sh --category 3d
./install/install.sh --category quality
```

### Install a single skill by folder name

```bash
./install/install.sh --category 22-gsap
```

### List available skill folders

```bash
./install/install.sh --list
```

### Windows (PowerShell)

```powershell
.\install\install.ps1 -All
.\install\install.ps1 -Project -All
.\install\install.ps1 -Category cinematic
.\install\install.ps1 -List
```

### After install

The installer writes to a neutral `.ai-skills/frontend` tree so it stays tool-agnostic. Copy or symlink those folders into whatever skills/instructions directory your coding agent expects. Details: [`install/README.md`](install/README.md).

---

## Skill categories

Used by `--category` in the installer:

| Category | Focus | Skill range (approx.) |
|----------|--------|------------------------|
| `core` | Architecture, React/Next, HTML/CSS, a11y, APIs, state, security, performance, media, browser APIs | 01–20 |
| `animation` | Motion fundamentals through cursor effects and scroll patterns | 21–40 |
| `cinematic` | Scroll storytelling, sequences, video scrubbing, 3D scroll, motion quality | curated mix |
| `3d` | Three.js, R3F, Drei, WebGL, GLSL, 3D scroll | 41–45, 48, 51 |
| `quality` | A11y, security, performance, testing, debugging, web vitals, review | curated mix |
| `all` | Every skill under `skills/` | all folders (including any added later) |

---

## Full skill catalog

### Core frontend (01–20)

| # | Skill | Title |
|---|--------|--------|
| 01 | `01-frontend-architecture` | Frontend Architecture |
| 02 | `02-react` | React |
| 03 | `03-nextjs` | Next.js |
| 04 | `04-typescript` | TypeScript |
| 05 | `05-html` | HTML |
| 06 | `06-css` | CSS |
| 07 | `07-responsive-design` | Responsive Design |
| 08 | `08-ui-ux-design` | UI/UX Design |
| 09 | `09-design-systems` | Design Systems |
| 10 | `10-component-engineering` | Component Engineering |
| 11 | `11-accessibility` | Accessibility |
| 12 | `12-forms-validation` | Forms and Validation |
| 13 | `13-api-integration` | API Integration |
| 14 | `14-state-management` | State Management |
| 15 | `15-data-fetching` | Data Fetching |
| 16 | `16-frontend-security` | Frontend Security |
| 17 | `17-frontend-performance` | Frontend Performance |
| 18 | `18-image-optimization` | Image Optimization |
| 19 | `19-video-optimization` | Video Optimization |
| 20 | `20-browser-apis` | Browser APIs |

### Animation & interaction (21–40)

| # | Skill | Title |
|---|--------|--------|
| 21 | `21-animation-fundamentals` | Animation Fundamentals |
| 22 | `22-gsap` | GSAP |
| 23 | `23-gsap-scrolltrigger` | GSAP ScrollTrigger |
| 24 | `24-lenis` | Lenis Smooth Scroll |
| 25 | `25-framer-motion` | Framer Motion |
| 26 | `26-motion-react` | Motion for React |
| 27 | `27-scroll-storytelling` | Scroll Storytelling |
| 28 | `28-image-sequence-scroll` | Image Sequence Scroll |
| 29 | `29-video-scroll-scrubbing` | Video Scroll Scrubbing |
| 30 | `30-canvas-animation` | Canvas Animation |
| 31 | `31-svg-animation` | SVG Animation |
| 32 | `32-text-animation` | Text Animation |
| 33 | `33-parallax` | Parallax |
| 34 | `34-horizontal-scroll` | Horizontal Scroll |
| 35 | `35-pinned-scroll` | Pinned Scroll |
| 36 | `36-scroll-progress` | Scroll Progress |
| 37 | `37-micro-interactions` | Micro Interactions |
| 38 | `38-page-transitions` | Page Transitions |
| 39 | `39-loading-experiences` | Loading Experiences |
| 40 | `40-cursor-effects` | Cursor Effects |

### 3D, media extras & motion quality (41–53)

| # | Skill | Title |
|---|--------|--------|
| 41 | `41-threejs` | Three.js |
| 42 | `42-react-three-fiber` | React Three Fiber |
| 43 | `43-drei` | Drei |
| 44 | `44-webgl` | WebGL |
| 45 | `45-glsl-shaders` | GLSL Shaders |
| 46 | `46-lottie` | Lottie |
| 47 | `47-sprite-animation` | Sprite Animation |
| 48 | `48-3d-scroll-storytelling` | 3D Scroll Storytelling |
| 49 | `49-responsive-animation` | Responsive Animation |
| 50 | `50-motion-accessibility` | Motion Accessibility |
| 51 | `51-animation-performance` | Animation Performance |
| 52 | `52-mobile-animation` | Mobile Animation |
| 53 | `53-touch-interactions` | Touch Interactions |

### Quality, product & AI workflow (54–70)

| # | Skill | Title |
|---|--------|--------|
| 54 | `54-visual-regression` | Visual Regression |
| 55 | `55-frontend-testing` | Frontend Testing |
| 56 | `56-browser-debugging` | Browser Debugging |
| 57 | `57-web-vitals` | Web Vitals |
| 58 | `58-seo` | SEO |
| 59 | `59-pwa` | PWA |
| 60 | `60-internationalization` | Internationalization |
| 61 | `61-component-documentation` | Component Documentation |
| 62 | `62-frontend-refactoring` | Frontend Refactoring |
| 63 | `63-frontend-code-review` | Frontend Code Review |
| 64 | `64-frontend-debugging` | Frontend Debugging |
| 65 | `65-design-to-code` | Design to Code |
| 66 | `66-screenshot-to-code` | Screenshot to Code |
| 67 | `67-figma-to-code` | Figma to Code |
| 68 | `68-ai-ui-generation` | AI UI Generation |
| 69 | `69-ai-frontend-workflow` | AI Frontend Workflow |
| 70 | `70-frontend-skill-router` | Frontend Skill Router |

Open any skill at `skills/<name>/SKILL.md` for full guidance.

Want to add skill `71+` or expand an existing `SKILL.md`? See [Contributing](#contributing) and [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## Recommended skill stacks

**Scroll-controlled image frames**

`GSAP` → `ScrollTrigger` → `image-sequence-scroll` → `Canvas` → `image optimization` → `animation performance` → `responsive animation` → `motion accessibility`

**Scroll-controlled video**

`GSAP` → `ScrollTrigger` → `video-scroll-scrubbing` → `video optimization` → `mobile animation` → `motion accessibility`

**3D**

`Three.js` / `R3F` → `3D scroll storytelling` → `WebGL` / `GLSL` → `animation performance`

---

## Scripts

### `scripts/validate.sh`

Validates the library (count can grow beyond 70):

- At least one `SKILL.md` under `skills/`
- Each file has YAML front matter (`---`) and a markdown `#` heading
- `manifest.json` `skill_count` matches the number of skills on disk
- Every disk skill is listed in the manifest, and every manifest entry exists on disk

```bash
./scripts/validate.sh
```

Run this before opening a PR that adds or changes skills.

### `scripts/create-history.sh`

Optional maintainer helper. Most contributors can ignore it. It is not part of normal install or agent usage.

---

## Manifest

[`manifest.json`](manifest.json) lists every skill with:

- `name` — folder name  
- `path` — path to `SKILL.md`  
- `title` — human-readable title  
- top-level `skill_count` — must match the number of skills (update it when you add or remove one)

Keep `manifest.json` in sync when you add, rename, or remove a skill.

---

## Contributing

**New skills and richer skill docs are welcome.** All changes go through a pull request — do not push directly to `main`.

You can:

- Add a new skill (`skills/71-…/SKILL.md` and beyond)
- Expand any existing `skills/*/SKILL.md`
- Improve README / install / contributing docs

Quick path:

1. Fork the repo  
2. Create a branch from `main`  
3. Add or expand skills/docs and update `manifest.json` when needed  
4. Run `./scripts/validate.sh` if you touched skills  
5. Open a PR against `main`  

Step-by-step skill format and checklist: **[CONTRIBUTING.md](CONTRIBUTING.md)**

---

## License

This project is licensed under the [MIT License](LICENSE).

You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of this software, provided the copyright notice and permission notice are included in all copies or substantial portions of the Software.
