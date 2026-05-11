$ErrorActionPreference = "Stop"
$REPO = "https://github.com/sami812/my-dot-file.git"
$NVIM_CONFIG = "$env:LOCALAPPDATA\nvim"

Write-Host "→ installing Git..." -ForegroundColor Cyan
winget install Git.Git -e --silent

Write-Host "→ installing Neovim..." -ForegroundColor Cyan
winget install Neovim.Neovim -e --silent

Write-Host "→ installing LLVM (C compiler for Treesitter)..." -ForegroundColor Cyan
winget install LLVM.LLVM -e --silent

Write-Host "→ installing Node.js (for LSPs)..." -ForegroundColor Cyan
winget install OpenJS.NodeJS -e --silent

# reload PATH so git/nvim are available immediately
$env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "→ cloning config from GitHub..." -ForegroundColor Cyan
$tmp = "$env:TEMP\my-dot-file"
if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
git clone $REPO $tmp

if (Test-Path $NVIM_CONFIG) {
    Write-Host "  backing up existing config to nvim.bak..." -ForegroundColor Yellow
    Rename-Item $NVIM_CONFIG "$NVIM_CONFIG.bak"
}

Copy-Item "$tmp\nvim" $NVIM_CONFIG -Recurse
Remove-Item $tmp -Recurse -Force

Write-Host ""
Write-Host "✓ all done! open a terminal and run 'nvim'" -ForegroundColor Green
Write-Host "  plugins will auto-install on first launch" -ForegroundColor Gray
