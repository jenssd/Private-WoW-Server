param(
    [string]$ProjectDir = "D:\Private\WoW",
    [string]$Branch = "335"
)

$ErrorActionPreference = "Stop"

$clientAddons = Join-Path $ProjectDir "Client\WoW 3.3.5a\Interface\AddOns"
$targetDir = Join-Path $clientAddons "Questie-335"
$tempRoot = Join-Path $env:TEMP "PrivateWoW-Questie"
$zipFile = Join-Path $tempRoot "Questie-335.zip"
$extractDir = Join-Path $tempRoot "extract"
$downloadUrl = "https://github.com/divial28/Questie-335/archive/refs/heads/$Branch.zip"

if (-not (Test-Path (Join-Path $ProjectDir "Client\WoW 3.3.5a\Wow.exe"))) {
    throw "Der WoW-Client wurde unter '$ProjectDir\Client\WoW 3.3.5a' nicht gefunden."
}

Write-Host "Installiere Questie-335 fuer WoW 3.3.5a..." -ForegroundColor Cyan
Write-Host "Quelle: $downloadUrl"

if (Test-Path $tempRoot) {
    Remove-Item $tempRoot -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
New-Item -ItemType Directory -Force -Path $extractDir | Out-Null
New-Item -ItemType Directory -Force -Path $clientAddons | Out-Null

Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile -UseBasicParsing
Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

$sourceDir = Get-ChildItem -Path $extractDir -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "Questie-335.toc") } |
    Select-Object -First 1

if (-not $sourceDir) {
    throw "Das heruntergeladene Archiv enthaelt keine Questie-335.toc."
}

if (Test-Path $targetDir) {
    Write-Host "Entferne vorhandene Questie-Installation..."
    Remove-Item $targetDir -Recurse -Force
}

Copy-Item $sourceDir.FullName $targetDir -Recurse -Force

if (-not (Test-Path (Join-Path $targetDir "Questie-335.toc"))) {
    throw "Questie wurde nicht korrekt installiert."
}

Write-Host ""
Write-Host "Questie-335 wurde installiert:" -ForegroundColor Green
Write-Host $targetDir
Write-Host ""
Write-Host "WoW jetzt komplett neu starten."
Write-Host "Questie findest du danach am Minimap-Symbol oder ueber /questie."
Write-Host ""
Write-Host "Hinweis: Das Addon stammt aus dem oeffentlichen Repository divial28/Questie-335."
