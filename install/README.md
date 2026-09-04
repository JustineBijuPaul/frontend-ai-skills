# Installers

Copy skills from this repo into a neutral destination so AI coding tools can pick them up.

## `install.sh` (macOS / Linux / WSL)

```bash
./install/install.sh --all
./install/install.sh --project --all
./install/install.sh --global --all
./install/install.sh --category cinematic
./install/install.sh --list
./install/install.sh --help
```

| Flag | Effect |
|------|--------|
| `--all` | Install every skill under `skills/` |
| `--project` | Write to `$PWD/.ai-skills/frontend` (default target) |
| `--global` | Write to `$CLAUDE_HOME/skills/frontend` or `~/.ai-skills/frontend` |
| `--category NAME` | Install a named group (`core`, `animation`, `cinematic`, `3d`, `quality`) or a single skill folder name |
| `--list` | Print skill folder names |

## `install.ps1` (Windows PowerShell)

```powershell
.\install\install.ps1 -All
.\install\install.ps1 -Project -All
.\install\install.ps1 -Global -All
.\install\install.ps1 -Category cinematic
.\install\install.ps1 -List
```

## Destination notes

The installer uses `.ai-skills/frontend` on purpose: different agents expose different skill directories across versions. After install, copy or symlink those folders into the path your current tool expects.

See the root [README.md](../README.md) for the full catalog, categories, and contribution guide.
