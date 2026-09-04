# Frontend AI Skills

A Git-ready, modular frontend skill library for AI coding agents.

**70 specialized skills** covering production frontend engineering, cinematic scroll experiences, image-sequence animation, video scrubbing, Canvas, Three.js, WebGL/GLSL, accessibility, performance, testing, and design-to-code.

## Installation

### Clone

```bash
git clone https://github.com/YOUR_USERNAME/frontend-ai-skills.git
cd frontend-ai-skills
```

### Install globally

```bash
./install/install.sh --all
```

### Install into the current project

```bash
./install/install.sh --project --all
```

### Install a category

```bash
./install/install.sh --category cinematic
```

### List skills

```bash
./install/install.sh --list
```

See `install/README.md` for supported targets and options.

## Cinematic scroll stack

For scroll-controlled image frames:

`GSAP → ScrollTrigger → image-sequence-scroll → Canvas → image optimization → animation performance → responsive animation → motion accessibility`

For scroll-controlled video:

`GSAP → ScrollTrigger → video-scroll-scrubbing → video optimization → mobile animation → motion accessibility`

For 3D:

`Three.js/R3F → 3D scroll storytelling → WebGL/GLSL → animation performance`

## Repository design

Every skill is independent and lives at:

`skills/<skill-name>/SKILL.md`

The skills are intentionally modular so an AI agent can load only what is relevant.
