#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CATEGORY="all"
LIST_ONLY=0
USE_SYMLINK=0
# Collect one or more install destinations
DESTS=()

usage() {
  cat <<'EOF'
Usage:
  ./install/install.sh --cursor --all
  ./install/install.sh --claude --all
  ./install/install.sh --opencode --all
  ./install/install.sh --codex --all
  ./install/install.sh --agents --all
  ./install/install.sh --editors --all
  ./install/install.sh --cursor --category cinematic
  ./install/install.sh --claude-project --all
  ./install/install.sh --project --all
  ./install/install.sh --list

Editor targets (personal — all projects):
  --cursor              ~/.cursor/skills
  --claude              ~/.claude/skills
  --opencode            ~/.config/opencode/skills
  --codex               ~/.codex/skills
  --agents              ~/.agents/skills
  --editors             all personal editor paths above

Editor targets (project-only — current directory):
  --cursor-project      ./.cursor/skills
  --claude-project      ./.claude/skills
  --opencode-project    ./.opencode/skills
  --codex-project       ./.agents/skills
  --agents-project      ./.agents/skills

Generic targets:
  --project             ./.ai-skills/frontend (default if no target given)
  --global              ~/.ai-skills/frontend (or $CLAUDE_HOME/skills/frontend)
  --to PATH             custom destination directory

Options:
  --all                 install all skills (default category)
  --category NAME       core | animation | cinematic | 3d | quality | or a skill folder name
  --symlink             symlink skill folders instead of copying
  --list                list skill folders
  -h, --help            show this help
EOF
}

add_dest() {
  local d="$1"
  local seen=0
  local existing
  for existing in "${DESTS[@]+"${DESTS[@]}"}"; do
    if [[ "$existing" == "$d" ]]; then
      seen=1
      break
    fi
  done
  if [[ "$seen" -eq 0 ]]; then
    DESTS+=("$d")
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --all) CATEGORY="all"; shift;;
    --project) add_dest "$PWD/.ai-skills/frontend"; shift;;
    --global)
      if [[ -n "${CLAUDE_HOME:-}" ]]; then
        add_dest "$CLAUDE_HOME/skills/frontend"
      else
        add_dest "$HOME/.ai-skills/frontend"
      fi
      shift
      ;;
    --to)
      [[ $# -ge 2 ]] || { echo "error: --to requires a path" >&2; exit 1; }
      add_dest "$2"
      shift 2
      ;;
    --cursor) add_dest "$HOME/.cursor/skills"; shift;;
    --claude) add_dest "$HOME/.claude/skills"; shift;;
    --opencode) add_dest "$HOME/.config/opencode/skills"; shift;;
    --codex) add_dest "${CODEX_HOME:-$HOME/.codex}/skills"; shift;;
    --agents) add_dest "$HOME/.agents/skills"; shift;;
    --editors)
      add_dest "$HOME/.cursor/skills"
      add_dest "$HOME/.claude/skills"
      add_dest "$HOME/.config/opencode/skills"
      add_dest "${CODEX_HOME:-$HOME/.codex}/skills"
      add_dest "$HOME/.agents/skills"
      shift
      ;;
    --cursor-project) add_dest "$PWD/.cursor/skills"; shift;;
    --claude-project) add_dest "$PWD/.claude/skills"; shift;;
    --opencode-project) add_dest "$PWD/.opencode/skills"; shift;;
    --codex-project|--agents-project) add_dest "$PWD/.agents/skills"; shift;;
    --category)
      [[ $# -ge 2 ]] || { echo "error: --category requires a name" >&2; exit 1; }
      CATEGORY="$2"
      shift 2
      ;;
    --symlink) USE_SYMLINK=1; shift;;
    --list) LIST_ONLY=1; shift;;
    -h|--help) usage; exit 0;;
    *) echo "Unknown option: $1"; usage; exit 1;;
  esac
done

if [[ "$LIST_ONLY" == "1" ]]; then
  find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort
  exit 0
fi

# Default destination when none specified
if [[ "${#DESTS[@]}" -eq 0 ]]; then
  add_dest "$PWD/.ai-skills/frontend"
fi

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

install_one() {
  local dest="$1"
  local skill="$2"
  local src="$ROOT/skills/$skill"
  local out="$dest/$skill"

  if [[ ! -f "$src/SKILL.md" ]]; then
    echo "⚠ skipped: $skill"
    return 1
  fi

  mkdir -p "$dest"
  rm -rf "$out"

  if [[ "$USE_SYMLINK" == "1" ]]; then
    ln -sfn "$src" "$out"
  else
    mkdir -p "$out"
    cp "$src/SKILL.md" "$out/SKILL.md"
  fi
  echo "✓ $skill"
  return 0
}

for DEST in "${DESTS[@]}"; do
  echo "→ Installing into: $DEST"
  installed=0
  for skill in $SKILLS; do
    if install_one "$DEST" "$skill"; then
      installed=$((installed + 1))
    fi
  done
  echo "  ($installed skill(s))"
  echo
done

echo "Done."
if [[ "$USE_SYMLINK" == "1" ]]; then
  echo "Mode: symlink (updates when you git pull this repo)"
else
  echo "Mode: copy"
fi
echo "Tip: restart or reload your editor/agent so new skills are discovered."
