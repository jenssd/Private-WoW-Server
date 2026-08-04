param(
    [string]$Database = "acore_npcbots_world",
    [string]$MySqlExe = "mysql.exe",
    [string]$DbcDirectory = "D:\Private\WoW\AzerothCore\Install-NPCBots\Data\dbc",
    [string]$OutputFile = "D:\Private\WoW\Addons\PrivateWoWAdmin\PrivateWoWAdminMapTeleportData.lua"
)

$ErrorActionPreference = "Stop"

function Escape-LuaString {
    param([string]$Value)
    if ($null -eq $Value) { return "" }
    return $Value.Replace("\", "\\").Replace('"', '\"').Replace("`r", " ").Replace("`n", " ")
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

if (-not (Get-Command $MySqlExe -ErrorAction SilentlyContinue)) {
    throw "mysql.exe wurde nicht gefunden. Bitte MySQL zum PATH hinzufuegen oder -MySqlExe angeben."
}

$worldMapAreaPath = Join-Path $DbcDirectory "WorldMapArea.dbc"
$dbc = Read-DbcFile $worldMapAreaPath
if ($dbc.FieldCount -ne 11 -or $dbc.RecordSize -ne 44) {
    throw "WorldMapArea.dbc hat eine unerwartete Struktur: $($dbc.FieldCount) Felder, $($dbc.RecordSize) Bytes."
}

$areas = @()
for ($index = 0; $index -lt $dbc.RecordCount; $index++) {
    $mapId = Get-DbcInt32 $dbc $index 1
    $areaId = Get-DbcInt32 $dbc $index 2
    $left = Get-DbcSingle $dbc $index 4
    $right = Get-DbcSingle $dbc $index 5
    $top = Get-DbcSingle $dbc $index 6
    $bottom = Get-DbcSingle $dbc $index 7

    if ($areaId -gt 0 -and $mapId -in @(0, 1, 530, 571)) {
        $areas += [pscustomobject]@{
            AreaId = $areaId
            MapId = $mapId
            Left = $left
            Right = $right
            Top = $top
            Bottom = $bottom
        }
    }
}

$query = @"
SELECT id, map, position_x, position_y, name
FROM game_tele
WHERE name IS NOT NULL
  AND name <> ''
  AND map IN (0, 1, 530, 571)
ORDER BY map, name;
"@

Write-Host "Lese Teleportziele aus '$Database.game_tele'..."
Write-Host "MySQL fragt gleich nach dem root-Passwort."
$rows = & $MySqlExe -u root -p --default-character-set=utf8mb4 --batch --raw --skip-column-names $Database -e $query
if ($LASTEXITCODE -ne 0) {
    throw "Der MySQL-Export ist fehlgeschlagen."
}

$points = @()
foreach ($row in $rows) {
    if ([string]::IsNullOrWhiteSpace($row)) { continue }
    $parts = $row -split "`t", 5
    if ($parts.Count -ne 5) { continue }

    $id = 0
    $mapId = 0
    $x = 0.0
    $y = 0.0
    if (-not [int]::TryParse($parts[0], [ref]$id)) { continue }
    if (-not [int]::TryParse($parts[1], [ref]$mapId)) { continue }
    if (-not [double]::TryParse($parts[2], [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$x)) { continue }
    if (-not [double]::TryParse($parts[3], [Globalization.NumberStyles]::Float, [Globalization.CultureInfo]::InvariantCulture, [ref]$y)) { continue }

    $points += [pscustomobject]@{
        Id = $id
        MapId = $mapId
        X = $x
        Y = $y
        Name = $parts[4]
    }
}

$outputDirectory = Split-Path -Parent $OutputFile
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

$invariant = [Globalization.CultureInfo]::InvariantCulture
$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("PrivateWoWAdminMapTeleports = {")
[void]$builder.AppendLine("    areas = {")
foreach ($area in ($areas | Sort-Object AreaId)) {
    $left = $area.Left.ToString("R", $invariant)
    $right = $area.Right.ToString("R", $invariant)
    $top = $area.Top.ToString("R", $invariant)
    $bottom = $area.Bottom.ToString("R", $invariant)
    [void]$builder.AppendLine("        [$($area.AreaId)] = { map = $($area.MapId), left = $left, right = $right, top = $top, bottom = $bottom },")
}
[void]$builder.AppendLine("    },")
[void]$builder.AppendLine("    pointsByMap = {")
foreach ($group in ($points | Group-Object MapId | Sort-Object { [int]$_.Name })) {
    [void]$builder.AppendLine("        [$($group.Name)] = {")
    foreach ($point in ($group.Group | Sort-Object Name, Id)) {
        $name = Escape-LuaString $point.Name
        $x = $point.X.ToString("R", $invariant)
        $y = $point.Y.ToString("R", $invariant)
        [void]$builder.AppendLine("            { id = $($point.Id), name = `"$name`", x = $x, y = $y },")
    }
    [void]$builder.AppendLine("        },")
}
[void]$builder.AppendLine("    }")
[void]$builder.AppendLine("}")

[System.IO.File]::WriteAllText($OutputFile, $builder.ToString(), [System.Text.UTF8Encoding]::new($false))
Write-Host "Fertig: $($areas.Count) Kartenbereiche und $($points.Count) Teleportziele geschrieben."
Write-Host "Datei: $OutputFile"
Write-Host "Danach den Addon-Installer erneut starten und WoW neu starten."
