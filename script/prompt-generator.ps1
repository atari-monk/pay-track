# --- Import utility functions
$utilsPath = "/home/atari-monk/atari-monk/project/pay-track/script/utils.ps1"
if (Test-Path $utilsPath) {
    . $utilsPath  # dot-source the script to load functions
} else {
    Write-Error "Utils script not found at $utilsPath"
}

# --- Paths
$proj = "/home/atari-monk/atari-monk/project/pay-track"

$prompt = 
"""
1. Check my code base and file 2026-01-13-monorepo-structure-proposal.md. Is implemented structure same as in doc ?
"""

snippet clear

#snippet -f "/home/atari-monk/atari-monk/project/pay-track/docs/story-architecture.md" -t context
snippet -f "/home/atari-monk/atari-monk/project/pay-track/docs/2026-01-13-monorepo-structure-proposal.md" -t context

Set-Location /home/atari-monk/atari-monk/project/pay-track
fstree . -c
snippet -d "Project Structure" -t context

# --- Project files
snippet -c 'Project Code Base:' -t context
$files = Get-PyProjFiles $proj
foreach ($file in $files) {
    snippet -f $file -t context
}

snippet pop $prompt
Set-Location /home/atari-monk/atari-monk/project/pay-track/script
