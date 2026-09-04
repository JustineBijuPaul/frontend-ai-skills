param(
  [switch]$All,
  [switch]$Project,
  [switch]$Global,
  [string]$Category,
  [switch]$List,
  [switch]$Symlink,
  [switch]$Cursor,
  [switch]$Claude,
  [switch]$OpenCode,
  [switch]$Codex,
  [switch]$Agents,
  [switch]$Editors,
  [switch]$CursorProject,
  [switch]$ClaudeProject,
  [switch]$OpenCodeProject,
  [switch]$CodexProject,
  [switch]$AgentsProject,
  [string]$To
)

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

if ($List) {
  Get-ChildItem "$Root\skills" -Directory | Sort-Object Name | Select-Object -ExpandProperty Name
  exit 0
}

$Dests = New-Object System.Collections.Generic.List[string]
function Add-Dest([string]$Path) {
  if (-not $Dests.Contains($Path)) { [void]$Dests.Add($Path) }
}

if ($Project) { Add-Dest (Join-Path (Get-Location) ".ai-skills\frontend") }
if ($Global) { Add-Dest (Join-Path $HOME ".ai-skills\frontend") }
if ($To) { Add-Dest $To }
if ($Cursor) { Add-Dest (Join-Path $HOME ".cursor\skills") }
if ($Claude) { Add-Dest (Join-Path $HOME ".claude\skills") }
if ($OpenCode) { Add-Dest (Join-Path $HOME ".config\opencode\skills") }
if ($Codex) {
  $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
  Add-Dest (Join-Path $codexHome "skills")
}
if ($Agents) { Add-Dest (Join-Path $HOME ".agents\skills") }
if ($Editors) {
  Add-Dest (Join-Path $HOME ".cursor\skills")
  Add-Dest (Join-Path $HOME ".claude\skills")
  Add-Dest (Join-Path $HOME ".config\opencode\skills")
  $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
  Add-Dest (Join-Path $codexHome "skills")
  Add-Dest (Join-Path $HOME ".agents\skills")
}
if ($CursorProject) { Add-Dest (Join-Path (Get-Location) ".cursor\skills") }
if ($ClaudeProject) { Add-Dest (Join-Path (Get-Location) ".claude\skills") }
if ($OpenCodeProject) { Add-Dest (Join-Path (Get-Location) ".opencode\skills") }
if ($CodexProject -or $AgentsProject) { Add-Dest (Join-Path (Get-Location) ".agents\skills") }

if ($Dests.Count -eq 0) {
  Add-Dest (Join-Path (Get-Location) ".ai-skills\frontend")
}

$SkillGroups = @{
  core = @(
    "01-frontend-architecture","02-react","03-nextjs","04-typescript","05-html","06-css",
    "07-responsive-design","08-ui-ux-design","09-design-systems","10-component-engineering",
    "11-accessibility","12-forms-validation","13-api-integration","14-state-management",
    "15-data-fetching","16-frontend-security","17-frontend-performance","18-image-optimization",
    "19-video-optimization","20-browser-apis"
  )
  animation = @(
    "21-animation-fundamentals","22-gsap","23-gsap-scrolltrigger","24-lenis","25-framer-motion",
    "26-motion-react","27-scroll-storytelling","28-image-sequence-scroll","29-video-scroll-scrubbing",
    "30-canvas-animation","31-svg-animation","32-text-animation","33-parallax","34-horizontal-scroll",
    "35-pinned-scroll","36-scroll-progress","37-micro-interactions","38-page-transitions",
    "39-loading-experiences","40-cursor-effects"
  )
  cinematic = @(
    "22-gsap","23-gsap-scrolltrigger","24-lenis","27-scroll-storytelling","28-image-sequence-scroll",
    "29-video-scroll-scrubbing","30-canvas-animation","33-parallax","34-horizontal-scroll",
    "35-pinned-scroll","36-scroll-progress","41-threejs","42-react-three-fiber","44-webgl",
    "45-glsl-shaders","48-3d-scroll-storytelling","49-responsive-animation","50-motion-accessibility",
    "51-animation-performance","52-mobile-animation"
  )
  "3d" = @(
    "41-threejs","42-react-three-fiber","43-drei","44-webgl","45-glsl-shaders",
    "48-3d-scroll-storytelling","51-animation-performance"
  )
  quality = @(
    "11-accessibility","16-frontend-security","17-frontend-performance","49-responsive-animation",
    "50-motion-accessibility","51-animation-performance","52-mobile-animation","54-visual-regression",
    "55-frontend-testing","56-browser-debugging","57-web-vitals","63-frontend-code-review",
    "64-frontend-debugging"
  )
}

$dirs = Get-ChildItem "$Root\skills" -Directory | Sort-Object Name
if ($Category) {
  if ($SkillGroups.ContainsKey($Category)) {
    $wanted = $SkillGroups[$Category]
    $dirs = $dirs | Where-Object { $wanted -contains $_.Name }
  } else {
    $dirs = $dirs | Where-Object { $_.Name -eq $Category }
  }
} elseif (-not $All -and -not $Category) {
  # default: all skills when installing to an editor target or generic dest
  $null = $All
}

foreach ($Dest in $Dests) {
  Write-Host "→ Installing into: $Dest"
  New-Item -ItemType Directory -Force $Dest | Out-Null
  $count = 0
  foreach ($d in $dirs) {
    $srcSkill = Join-Path $d.FullName "SKILL.md"
    if (-not (Test-Path $srcSkill)) {
      Write-Host "⚠ skipped: $($d.Name)"
      continue
    }
    $out = Join-Path $Dest $d.Name
    if (Test-Path $out) { Remove-Item -Recurse -Force $out }
    if ($Symlink) {
      New-Item -ItemType SymbolicLink -Path $out -Target $d.FullName | Out-Null
    } else {
      New-Item -ItemType Directory -Force $out | Out-Null
      Copy-Item $srcSkill (Join-Path $out "SKILL.md") -Force
    }
    Write-Host "✓ $($d.Name)"
    $count++
  }
  Write-Host "  ($count skill(s))"
  Write-Host ""
}

Write-Host "Done."
if ($Symlink) { Write-Host "Mode: symlink" } else { Write-Host "Mode: copy" }
Write-Host "Tip: restart or reload your editor/agent so new skills are discovered."
