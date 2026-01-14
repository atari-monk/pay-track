# --- Get blog files (skip index.md)
function Get-BlogFiles {
    param (
        [Parameter(Mandatory=$true)]
        [string]$BlogPath
    )

    if (-not (Test-Path $BlogPath)) {
        Write-Error "Blog path does not exist: $BlogPath"
        return @()
    }

    $posts = Get-ChildItem -Path $BlogPath -Recurse -File -Filter "*.md" |
             Where-Object { $_.Name -ne "index.md" } |
             ForEach-Object { $_.FullName }

    return $posts
}

# --- Get project files
function Get-PyProjFiles {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        Write-Error "Path does not exist: $Path"
        return @()
    }

    # Directories to ignore
    $ignoredDirs = @(
        'node_modules'
        '.git'
        '.venv'
        'dist'
        'build',
        'docs',
        'script'
    )

    # Files to ignore (name or wildcard)
    $ignoredFiles = @(
        'package-lock.json',
        'pnpm-lock.yaml',
        '*.log'
        '*.tmp'
        '*.pyc'
    )

    # Build regex once
    $ignoredDirRegex  = ($ignoredDirs  | ForEach-Object { [regex]::Escape($_) }) -join '|'
    $ignoredFileRegex = ($ignoredFiles | ForEach-Object { $_.Replace('.', '\.').Replace('*', '.*') }) -join '|'

    Get-ChildItem -Path $Path -Recurse -File |
        Where-Object {
            # Ignore directories
            if ($ignoredDirRegex -and $_.FullName -match "[\\/](?:$ignoredDirRegex)[\\/]") {
                return $false
            }

            # Ignore files
            if ($ignoredFileRegex -and $_.Name -match "^($ignoredFileRegex)$") {
                return $false
            }

            return $true
        } |
        ForEach-Object { $_.FullName }
}
