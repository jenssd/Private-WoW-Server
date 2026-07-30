param(
    [string]$ProjectDir = "D:\Private\WoW",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

$clientDir = Join-Path $ProjectDir "Client\WoW 3.3.5a"
$clientAddons = Join-Path $clientDir "Interface\AddOns"
$tempRoot = Join-Path $env:TEMP "PrivateWoW-Bagnon"
$zipFile = Join-Path $tempRoot "Bagnon-3.3.5.zip"
$extractDir = Join-Path $tempRoot "extract"
$downloadUrl = "https://github.com/RichSteini/Bagnon-3.3.5/archive/refs/heads/$Branch.zip"

$addonFolders = @(
    "Bagnon",
    "Bagnon_Config",
    "Bagnon_Forever",
    "Bagnon_GuildBank",
    "Bagnon_Tooltips"
)

if (-not (Test-Path (Join-Path $clientDir "Wow.exe"))) {
    throw "Der WoW-Client wurde unter '$clientDir' nicht gefunden."
}

Write-Host "Installiere Bagnon fuer WoW 3.3.5a..." -ForegroundColor Cyan
Write-Host "Quelle: $downloadUrl"

if (Test-Path $tempRoot) {
    Remove-Item $tempRoot -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
New-Item -ItemType Directory -Force -Path $extractDir | Out-Null
New-Item -ItemType Directory -Force -Path $clientAddons | Out-Null

Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile -UseBasicParsing
Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

$repositoryRoot = Get-ChildItem -Path $extractDir -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName "Bagnon") } |
    Select-Object -First 1

if (-not $repositoryRoot) {
    throw "Das heruntergeladene Archiv enthaelt keinen Bagnon-Ordner."
}

foreach ($addonFolder in $addonFolders) {
    $source = Join-Path $repositoryRoot.FullName $addonFolder
    $target = Join-Path $clientAddons $addonFolder

    if (-not (Test-Path $source)) {
        throw "Erwarteter Addon-Ordner fehlt im Archiv: $addonFolder"
    }

    if (Test-Path $target) {
        Write-Host "Entferne vorhandene Installation: $addonFolder"
        Remove-Item $target -Recurse -Force
    }

    Copy-Item $source $target -Recurse -Force

    $toc = Get-ChildItem -Path $target -Filter "*.toc" -File | Select-Object -First 1
    if (-not $toc) {
        throw "Der installierte Ordner '$addonFolder' enthaelt keine TOC-Datei."
    }
}

Write-Host ""
Write-Host "Bagnon wurde installiert:" -ForegroundColor Green
foreach ($addonFolder in $addonFolders) {
    Write-Host "  $(Join-Path $clientAddons $addonFolder)"
}
Write-Host ""
Write-Host "WoW jetzt vollstaendig neu starten."
Write-Host "In der Charakterauswahl unter AddOns pruefen, ob Bagnon aktiviert ist."
Write-Host "Im Spiel sollte B nun das gemeinsame Taschenfenster oeffnen."
Write-Host ""
Write-Host "Hinweis: Bagnon_VoidStorage wird absichtlich nicht installiert, da Void Storage nicht zu WoW 3.3.5a gehoert."
