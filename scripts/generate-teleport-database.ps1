param(
    [string]$Database = "acore_npcbots_world",
    [string]$MySqlExe = "mysql.exe",
    [string]$DbcDirectory = "D:\Private\WoW\AzerothCore\Install-NPCBots\Data\dbc",
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
        530 { return "Burning Crusade" }
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

function Read-DbcFile {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        throw "DBC-Datei nicht gefunden: $Path"
    }

    $stream = [System.IO.File]::OpenRead($Path)
    $reader = [System.IO.BinaryReader]::new($stream)

    try {
        $magic = [System.Text.Encoding]::ASCII.GetString($reader.ReadBytes(4))
        if ($magic -ne "WDBC") {
            throw "Unerwartetes DBC-Format in '$Path': $magic"
        }

        $recordCount = $reader.ReadUInt32()
        $fieldCount = $reader.ReadUInt32()
        $recordSize = $reader.ReadUInt32()
        $stringBlockSize = $reader.ReadUInt32()
        $records = $reader.ReadBytes([int]($recordCount * $recordSize))
        $strings = $reader.ReadBytes([int]$stringBlockSize)

        return [pscustomobject]@{
            RecordCount = [int]$recordCount
            FieldCount = [int]$fieldCount
            RecordSize = [int]$recordSize
            Records = $records
            Strings = $strings
        }
    }
    finally {
        $reader.Dispose()
        $stream.Dispose()
    }
}

function Get-DbcInt32 {
    param($Dbc, [int]$RecordIndex, [int]$FieldIndex)

    $offset = ($RecordIndex * $Dbc.RecordSize) + ($FieldIndex * 4)
    return [BitConverter]::ToInt32($Dbc.Records, $offset)
}

function Get-DbcSingle {
    param($Dbc, [int]$RecordIndex, [int]$FieldIndex)

    $offset = ($RecordIndex * $Dbc.RecordSize) + ($FieldIndex * 4)
    return [BitConverter]::ToSingle($Dbc.Records, $offset)
}

function Get-DbcString {
    param($Dbc, [int]$RecordIndex, [int]$FieldIndex)

    $stringOffset = Get-DbcInt32 $Dbc $RecordIndex $FieldIndex
    if ($stringOffset -lt 0 -or $stringOffset -ge $Dbc.Strings.Length) {
        return ""
    }

    $end = $stringOffset
    while ($end -lt $Dbc.Strings.Length -and $Dbc.Strings[$end] -ne 0) {
        $end++
    }

    if ($end -le $stringOffset) {
        return ""
    }

    return [System.Text.Encoding]::UTF8.GetString($Dbc.Strings, $stringOffset, $end - $stringOffset)
}

function Read-AreaNames {
    param([string]$Path)

    $dbc = Read-DbcFile $Path
    if ($dbc.FieldCount -ne 36 -or $dbc.RecordSize -ne 144) {
        throw "AreaTable.dbc hat eine unerwartete Struktur: $($dbc.FieldCount) Felder, $($dbc.RecordSize) Bytes."
    }

    $areas = @{}
    for ($index = 0; $index -lt $dbc.RecordCount; $index++) {
        $id = Get-DbcInt32 $dbc $index 0
        $en = Get-DbcString $dbc $index 11
        $de = Get-DbcString $dbc $index 15
        $name = if (-not [string]::IsNullOrWhiteSpace($de)) { $de } elseif (-not [string]::IsNullOrWhiteSpace($en)) { $en } else { "Area $id" }

        $areas[$id] = [pscustomobject]@{
            Id = $id
            English = $en
            German = $de
            DisplayName = $name
        }
    }

    return $areas
}

function Read-WorldMapAreas {
    param([string]$Path, [hashtable]$AreaNames)

    $dbc = Read-DbcFile $Path
    if ($dbc.FieldCount -ne 11 -or $dbc.RecordSize -ne 44) {
        throw "WorldMapArea.dbc hat eine unerwartete Struktur: $($dbc.FieldCount) Felder, $($dbc.RecordSize) Bytes."
    }

    $result = @()
    for ($index = 0; $index -lt $dbc.RecordCount; $index++) {
        $mapId = Get-DbcInt32 $dbc $index 1
        $areaId = Get-DbcInt32 $dbc $index 2
        $areaName = Get-DbcString $dbc $index 3
        $left = Get-DbcSingle $dbc $index 4
        $right = Get-DbcSingle $dbc $index 5
        $top = Get-DbcSingle $dbc $index 6
        $bottom = Get-DbcSingle $dbc $index 7

        $displayName = $areaName
        if ($AreaNames.ContainsKey($areaId)) {
            $displayName = $AreaNames[$areaId].DisplayName
        }
        if ([string]::IsNullOrWhiteSpace($displayName)) {
            $displayName = "Area $areaId"
        }

        $result += [pscustomobject]@{
            MapId = $mapId
            AreaId = $areaId
            DisplayName = $displayName
            Left = $left
            Right = $right
            Top = $top
            Bottom = $bottom
            Size = [math]::Abs(($left - $right) * ($top - $bottom))
        }
    }

    return $result
}

function Get-ZoneName {
    param(
        [int]$MapId,
        [double]$PositionX,
        [double]$PositionY,
        [object[]]$WorldMapAreas
    )

    $matches = $WorldMapAreas | Where-Object {
        $_.MapId -eq $MapId -and
        $PositionY -le [math]::Max($_.Left, $_.Right) -and
        $PositionY -ge [math]::Min($_.Left, $_.Right) -and
        $PositionX -le [math]::Max($_.Top, $_.Bottom) -and
        $PositionX -ge [math]::Min($_.Top, $_.Bottom)
    } | Sort-Object Size

    if ($matches) {
        return $matches[0].DisplayName
    }

    switch ($MapId) {
        30  { return "Alterac Valley" }
        489 { return "Warsong Gulch" }
        529 { return "Arathi Basin" }
        566 { return "Eye of the Storm" }
        default { return "Other / Unassigned" }
    }
}

if (-not (Get-Command $MySqlExe -ErrorAction SilentlyContinue)) {
    throw "mysql.exe wurde nicht gefunden. Bitte MySQL zum PATH hinzufuegen oder -MySqlExe angeben."
}

$areaTablePath = Join-Path $DbcDirectory "AreaTable.dbc"
$worldMapAreaPath = Join-Path $DbcDirectory "WorldMapArea.dbc"

Write-Host "Lese DBC-Gebietsdaten aus '$DbcDirectory'..."
$areaNames = Read-AreaNames $areaTablePath
$worldMapAreas = Read-WorldMapAreas $worldMapAreaPath $areaNames
Write-Host "Geladen: $($areaNames.Count) Gebietsbezeichnungen und $($worldMapAreas.Count) Kartenbereiche."

$outputDirectory = Split-Path -Parent $OutputFile
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

Write-Host "Lese Teleportziele aus '$Database.game_tele'..."
Write-Host "MySQL fragt gleich nach dem root-Passwort."

$query = @"
SELECT id, map, position_x, position_y, name
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

    $parts = $row -split "`t", 5
    if ($parts.Count -ne 5) {
        continue
    }

    $id = 0
    $mapId = 0
    $positionX = 0.0
    $positionY = 0.0
    if (-not [int]::TryParse($parts[0], [ref]$id)) { continue }
    if (-not [int]::TryParse($parts[1], [ref]$mapId)) { continue }
    if (-not [double]::TryParse($parts[2], [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$positionX)) { continue }
    if (-not [double]::TryParse($parts[3], [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$positionY)) { continue }

    $entries += [pscustomobject]@{
        Id = $id
        MapId = $mapId
        Name = $parts[4]
        Category = Get-TeleportCategory $mapId
        Zone = Get-ZoneName $mapId $positionX $positionY $worldMapAreas
    }
}

$categoryOrder = @(
    "Eastern Kingdoms",
    "Kalimdor",
    "Burning Crusade",
    "Northrend",
    "Battlegrounds",
    "Raids",
    "Dungeons and Other Maps"
)

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("PrivateWoWAdminTeleports = PrivateWoWAdminTeleports or {}")
[void]$builder.AppendLine("PrivateWoWAdminTeleports.categories = {")

foreach ($category in $categoryOrder) {
    $categoryEntries = $entries | Where-Object { $_.Category -eq $category }
    if (-not $categoryEntries) { continue }

    $escapedCategory = Escape-LuaString $category
    [void]$builder.AppendLine("    { name = `"$escapedCategory`", zones = {")

    $zones = $categoryEntries | Group-Object Zone | Sort-Object Name
    foreach ($zone in $zones) {
        $escapedZone = Escape-LuaString $zone.Name
        [void]$builder.AppendLine("        { name = `"$escapedZone`", items = {")

        foreach ($entry in ($zone.Group | Sort-Object Name, MapId, Id)) {
            $escapedName = Escape-LuaString $entry.Name
            [void]$builder.AppendLine("            { id = $($entry.Id), map = $($entry.MapId), name = `"$escapedName`" },")
        }

        [void]$builder.AppendLine("        } },")
    }

    [void]$builder.AppendLine("    } },")
}

[void]$builder.AppendLine("}")

[System.IO.File]::WriteAllText($OutputFile, $builder.ToString(), [System.Text.UTF8Encoding]::new($false))

$unassigned = ($entries | Where-Object { $_.Zone -eq "Other / Unassigned" }).Count
Write-Host "Fertig: $($entries.Count) Teleportziele geschrieben."
Write-Host "Nicht eindeutig zugeordnet: $unassigned"
Write-Host "Datei: $OutputFile"
Write-Host "Danach den Addon-Installer erneut starten und WoW neu starten."
