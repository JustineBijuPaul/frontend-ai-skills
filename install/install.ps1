param(
  [switch]$All,
  [switch]$Project,
  [switch]$Global,
  [string]$Category,
  [switch]$List
)

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if ($List) {
  Get-ChildItem "$Root\skills" -Directory | Sort-Object Name | Select-Object -ExpandProperty Name
  exit 0
}
if ($Project) { $Dest = Join-Path (Get-Location) ".ai-skills\frontend" }
elseif ($Global) { $Dest = Join-Path $HOME ".ai-skills\frontend" }
else { $Dest = Join-Path (Get-Location) ".ai-skills\frontend" }

New-Item -ItemType Directory -Force $Dest | Out-Null
$dirs = Get-ChildItem "$Root\skills" -Directory | Sort-Object Name
if ($Category) {
  $dirs = $dirs | Where-Object { $_.Name -eq $Category }
}
foreach ($d in $dirs) {
  $out = Join-Path $Dest $d.Name
  New-Item -ItemType Directory -Force $out | Out-Null
  Copy-Item (Join-Path $d.FullName "SKILL.md") (Join-Path $out "SKILL.md") -Force
  Write-Host "✓ $($d.Name)"
}
Write-Host "Installed into $Dest"
