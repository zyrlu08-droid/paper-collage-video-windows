$ErrorActionPreference = 'SilentlyContinue'

function Test-Tool {
    param([string]$Name, [string[]]$Arguments)
    $command = Get-Command $Name
    if (-not $command) {
        Write-Host "[MISSING] $Name"
        return
    }
    $output = & $Name @Arguments 2>&1 | Select-Object -First 1
    Write-Host "[OK] $Name - $output"
}

Write-Host '=== Paper Collage Video: Windows Gate 0 ==='
Test-Tool 'node' @('--version')
Test-Tool 'npm.cmd' @('--version')
Test-Tool 'python' @('--version')
Test-Tool 'ffmpeg' @('-version')
Test-Tool 'ffprobe' @('-version')

$edgeTts = & python -c "import importlib.metadata; print(importlib.metadata.version('edge-tts'))" 2>&1 | Select-Object -First 1
if ($edgeTts -match '^\d+\.\d+') {
    Write-Host "[OK] edge-tts - $edgeTts"
} else {
    Write-Host '[MISSING] edge-tts (install with: python -m pip install edge-tts)'
}

if ($env:ARK_API_KEY) {
    Write-Host '[OK] ARK_API_KEY is set (value hidden)'
} else {
    Write-Host '[OPTIONAL] ARK_API_KEY is not set'
}

Write-Host '=== Gate 0 finished ==='
