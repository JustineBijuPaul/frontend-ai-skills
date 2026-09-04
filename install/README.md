# Installers

Install skills into AI coding editors with one command.

## Quick commands (macOS / Linux / WSL)

```bash
git clone https://github.com/JustineBijuPaul/frontend-ai-skills.git
cd frontend-ai-skills

./install/install.sh --cursor --all      # Cursor
./install/install.sh --claude --all      # Claude Code
./install/install.sh --opencode --all    # OpenCode
./install/install.sh --codex --all       # Codex CLI
./install/install.sh --agents --all      # ~/.agents/skills (shared)
./install/install.sh --editors --all     # all of the above
```

Project-only (current directory):

```bash
./install/install.sh --cursor-project --all
./install/install.sh --claude-project --all
./install/install.sh --opencode-project --all
./install/install.sh --agents-project --all
```

## Windows PowerShell

```powershell
git clone https://github.com/JustineBijuPaul/frontend-ai-skills.git
cd frontend-ai-skills

.\install\install.ps1 -Cursor -All
.\install\install.ps1 -Claude -All
.\install\install.ps1 -OpenCode -All
.\install\install.ps1 -Codex -All
.\install\install.ps1 -Agents -All
.\install\install.ps1 -Editors -All
```

## Other useful flags

```bash
./install/install.sh --cursor --category cinematic
./install/install.sh --claude --symlink --all
./install/install.sh --to ~/my-custom-skills --all
./install/install.sh --list
./install/install.sh --help
```

| Flag | Destination |
|------|-------------|
| `--cursor` | `~/.cursor/skills` |
| `--claude` | `~/.claude/skills` |
| `--opencode` | `~/.config/opencode/skills` |
| `--codex` | `~/.codex/skills` (or `$CODEX_HOME/skills`) |
| `--agents` | `~/.agents/skills` |
| `--editors` | all personal editor paths |
| `--project` | `./.ai-skills/frontend` |
| `--global` | `~/.ai-skills/frontend` |
| `--to PATH` | custom path |
| `--symlink` | symlink instead of copy |

See the root [README.md](../README.md) for the full setup guide and skill catalog.
