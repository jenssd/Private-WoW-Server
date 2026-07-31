param(
    [string]$Database = "acore_npcbots_world",
    [string]$MySqlExe = "mysql.exe",
    [string]$OutputFile = "D:\Private\WoW\Addons\PrivateWoWAdmin\PrivateWoWAdminTeleportData.lua"
)

$ErrorActionPreference = "Stop"

function Escape-LuaString {
    param([string]$Value)

    if ($null -eq $Value) {
        return ""
    }

    return $Value.Replace("\", "\\").Replace('"', '\"').Replace("`r", " ").Replace("`n", " ")
}

function Get-TeleportCategory {
    param([int]$MapId)

    switch ($MapId) {
        0   { return "Eastern Kingdoms" }
        1   { return "Kalimdor" }
        530 { return "Outland and Burning Crusade Zones" }
        571 { return "Northrend" }
        30  { return "Battlegrounds" }
        489 { return "Battlegrounds" }
        529 { return "Battlegrounds" }
        566 { return "Battlegrounds" }
        607 { return "Battlegrounds" }
        628 { return "Battlegrounds" }
        249 { return "Raids" }
        409 { return "Raids" }
        469 { return "Raids" }
        509 { return "Raids" }
        531 { return "Raids" }
        533 { return "Raids" }
        580 { return "Raids" }
        603 { return "Raids" }
        615 { return "Raids" }
        616 { return "Raids" }
        624 { return "Raids" }
        631 { return "Raids" }
        649 { return "Raids" }
        default { return "Dungeons and Other Maps" }
    }
}

if (-not (Get-Command $MySqlExe -ErrorAction SilentlyContinue)) {
    throw "mysql.exe wurde nicht gefunden. Bitte MySQL zum PATH hinzufuegen oder -MySqlExe angeben."
}

$outputDirectory = Split-Path -Parent $OutputFile
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

Write-Host "Lese Teleportziele aus '$Database.game_tele'..."
Write-Host "MySQL fragt gleich nach dem root-Passwort."

$query = @"
SELECT id, map, name
FROM game_tele
WHERE name IS NOT NULL
  AND name <> ''
ORDER BY map, name;
"@

$rows = & $MySqlExe -u root -p --default-character-set=utf8mb4 --batch --raw --skip-column-names $Database -e $query

if ($LASTEXITCODE -ne 0) {
    throw "Der MySQL-Export ist fehlgeschlagen."
}

$entries = @()
foreach ($row in $rows) {
    if ([string]::IsNullOrWhiteSpace($row)) {
        continue
    }

    $parts = $row -split "`t", 3
    if ($parts.Count -ne 3) {
        continue
    }

    $id = 0
    $mapId = 0
    if (-not [int]::TryParse($parts[0], [ref]$id)) {
        continue
    }
    if (-not [int]::TryParse($parts[1], [ref]$mapId)) {
        continue
    }

    $entries += [pscustomobject]@{
        Id = $id
        MapId = $mapId
        Name = $parts[2]
        Category = Get-TeleportCategory $mapId
    }
}

$categoryOrder = @(
    "Eastern Kingdoms",
    "Kalimdor",
    "Outland and Burning Crusade Zones",
    "Northrend",
    "Battlegrounds",
    "Raids",
    "Dungeons and Other Maps"
)

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("PrivateWoWAdminTeleports = PrivateWoWAdminTeleports or {}")
[void]$builder.AppendLine("PrivateWoWAdminTeleports.categories = {")

foreach ($category in $categoryOrder) {
    $categoryEntries = $entries |
        Where-Object { $_.Category -eq $category } |
        Sort-Object Name, MapId, Id

    if (-not $categoryEntries) {
        continue
    }

    $escapedCategory = Escape-LuaString $category
    [void]$builder.AppendLine("    { name = `"$escapedCategory`", items = {")

    foreach ($entry in $categoryEntries) {
        $escapedName = Escape-LuaString $entry.Name
        [void]$builder.AppendLine("        { id = $($entry.Id), map = $($entry.MapId), name = `"$escapedName`" },")
    }

    [void]$builder.AppendLine("    } },")
}

[void]$builder.AppendLine("}")

[System.IO.File]::WriteAllText(
    $OutputFile,
    $builder.ToString(),
    [System.Text.UTF8Encoding]::new($false)
)

Write-Host "Fertig: $($entries.Count) Teleportziele geschrieben."
Write-Host "Datei: $OutputFile"
Write-Host ""
Write-Host "Hinweis: areatable_dbc und worldmaparea_dbc sind in dieser Installation leer."
Write-Host "Darum erfolgt die erste Gruppierung nach Weltkarte bzw. Instanztyp, nicht nach exakter Zone."
Write-Host "Danach den Addon-Installer erneut starten und WoW neu starten."
