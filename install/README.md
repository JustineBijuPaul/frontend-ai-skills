# Installers

`install.sh` supports macOS/Linux/WSL-style environments.

Examples:

```bash
./install/install.sh --all
./install/install.sh --project --all
./install/install.sh --category cinematic
./install/install.sh --list
```

`install.ps1` provides a Windows PowerShell installer.

The installer intentionally uses a neutral `.ai-skills/frontend` destination because different AI coding tools can expose different skill/instruction directories across versions. Copy or symlink the resulting skill folders into the agent-specific directory required by your current tool.
