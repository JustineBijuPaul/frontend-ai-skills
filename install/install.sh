#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="project"
CATEGORY="all"
LIST_ONLY=0

usage() {
  cat <<'EOF'
Usage:
  ./install/install.sh --all
  ./install/install.sh --project --all
  ./install/install.sh --category cinematic
  ./install/install.sh --list

Options:
  --all                 install all skills
  --project             install into current project
  --global              install globally where supported
  --category NAME       install a category
  --list                list skills
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) CATEGORY="all"; shift;;
    --project) TARGET="project"; shift;;
    --global) TARGET="global"; shift;;
    --category) CATEGORY="$2"; shift 2;;
    --list) LIST_ONLY=1; shift;;
    -h|--help) usage; exit 0;;
    *) echo "Unknown option: $1"; usage; exit 1;;
  esac
done

if [[ "$LIST_ONLY" == "1" ]]; then
  find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
  exit 0
fi

case "$TARGET" in
  project)
    DEST="$PWD/.ai-skills/frontend"
    ;;
  global)
    if [[ -n "${CLAUDE_HOME:-}" ]]; then
      DEST="$CLAUDE_HOME/skills/frontend"
    else
      DEST="$HOME/.ai-skills/frontend"
    fi
    ;;
esac

mkdir -p "$DEST"

declare -A SKILL_GROUPS
SKILL_GROUPS[core]="01-frontend-architecture 02-react 03-nextjs 04-typescript 05-html 06-css 07-responsive-design 08-ui-ux-design 09-design-systems 10-component-engineering 11-accessibility 12-forms-validation 13-api-integration 14-state-management 15-data-fetching 16-frontend-security 17-frontend-performance 18-image-optimization 19-video-optimization 20-browser-apis"
SKILL_GROUPS[animation]="21-animation-fundamentals 22-gsap 23-gsap-scrolltrigger 24-lenis 25-framer-motion 26-motion-react 27-scroll-storytelling 28-image-sequence-scroll 29-video-scroll-scrubbing 30-canvas-animation 31-svg-animation 32-text-animation 33-parallax 34-horizontal-scroll 35-pinned-scroll 36-scroll-progress 37-micro-interactions 38-page-transitions 39-loading-experiences 40-cursor-effects"
SKILL_GROUPS[cinematic]="22-gsap 23-gsap-scrolltrigger 24-lenis 27-scroll-storytelling 28-image-sequence-scroll 29-video-scroll-scrubbing 30-canvas-animation 33-parallax 34-horizontal-scroll 35-pinned-scroll 36-scroll-progress 41-threejs 42-react-three-fiber 44-webgl 45-glsl-shaders 48-3d-scroll-storytelling 49-responsive-animation 50-motion-accessibility 51-animation-performance 52-mobile-animation"
SKILL_GROUPS[3d]="41-threejs 42-react-three-fiber 43-drei 44-webgl 45-glsl-shaders 48-3d-scroll-storytelling 51-animation-performance"
SKILL_GROUPS[quality]="11-accessibility 16-frontend-security 17-frontend-performance 49-responsive-animation 50-motion-accessibility 51-animation-performance 52-mobile-animation 54-visual-regression 55-frontend-testing 56-browser-debugging 57-web-vitals 63-frontend-code-review 64-frontend-debugging"

if [[ "$CATEGORY" == "all" ]]; then
  SKILLS=$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
elif [[ -n "${SKILL_GROUPS[$CATEGORY]:-}" ]]; then
  SKILLS="${SKILL_GROUPS[$CATEGORY]}"
else
  SKILLS="$CATEGORY"
fi

for skill in $SKILLS; do
  if [[ -f "$ROOT/skills/$skill/SKILL.md" ]]; then
    mkdir -p "$DEST/$skill"
    cp "$ROOT/skills/$skill/SKILL.md" "$DEST/$skill/SKILL.md"
    echo "✓ $skill"
  else
    echo "⚠ skipped: $skill"
  fi
done

echo
echo "Installed into: $DEST"
