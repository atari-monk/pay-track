# --- Import utility functions
$utilsPath = "/home/atari-monk/atari-monk/project/pay-track/script/utils.ps1"
if (Test-Path $utilsPath) {
    . $utilsPath  # dot-source the script to load functions
} else {
    Write-Error "Utils script not found at $utilsPath"
}

# --- Paths
$proj = ""

snippet clear

# --- Project structure
if (Test-Path $proj) {
    fstree $proj -c
    snippet -d 'Project Structure:' -t context
}

# --- Project files
snippet -c 'Project Code Base:' -t context
$files = Get-PyProjFiles $proj
foreach ($file in $files) {
    snippet -f $file -t context
}

# --- Prompt for Swagger
$prompt = "This us user-service code base."
snippet -c $prompt -t prompt

snippet pop
