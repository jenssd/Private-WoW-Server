param(
    [string]$Database = "acore_npcbots_world",
    [string]$MySqlExe = "mysql.exe",
    [string]$OutputFile = "D:\Private\WoW\Addons\PrivateWoWAdmin\PrivateWoWAdminItemData.lua"
)

$ErrorActionPreference = "Stop"

function Escape-LuaString {
    param([string]$Value)

    if ($null -eq $Value) {
        return ""
    }

    return $Value.Replace("\", "\\").Replace('"', '\"').Replace("`r", " ").Replace("`n", " ")
}

if (-not (Get-Command $MySqlExe -ErrorAction SilentlyContinue)) {
    throw "mysql.exe wurde nicht gefunden. Bitte MySQL zum PATH hinzufuegen oder -MySqlExe angeben."
}

$outputDirectory = Split-Path -Parent $OutputFile
New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

Write-Host "Lese englische und deutsche Itemdaten aus '$Database'..."
Write-Host "MySQL fragt gleich nach dem root-Passwort."

$query = @"
SELECT
    i.entry,
    i.name AS name_en,
    COALESCE(NULLIF(l.Name, ''), i.name) AS name_de
FROM item_template i
LEFT JOIN item_template_locale l
    ON l.ID = i.entry
   AND l.locale = 'deDE'
WHERE i.name IS NOT NULL
  AND i.name <> ''
ORDER BY i.entry;
"@

$rows = & $MySqlExe -u root -p --default-character-set=utf8mb4 --batch --raw --skip-column-names $Database -e $query

if ($LASTEXITCODE -ne 0) {
    throw "Der MySQL-Export ist fehlgeschlagen."
}

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("PrivateWoWAdminItems = PrivateWoWAdminItems or {}")
[void]$builder.AppendLine("PrivateWoWAdminItems.data = {")

$count = 0
$germanCount = 0
foreach ($row in $rows) {
    if ([string]::IsNullOrWhiteSpace($row)) {
        continue
    }

    $parts = $row -split "`t", 3
    if ($parts.Count -ne 3) {
        continue
    }

    $itemId = 0
    if (-not [int]::TryParse($parts[0], [ref]$itemId)) {
        continue
    }

    $nameEn = Escape-LuaString $parts[1]
    $nameDe = Escape-LuaString $parts[2]

    if ($nameDe -ne $nameEn) {
        $germanCount++
    }

    [void]$builder.AppendLine("    [$itemId] = { en = `"$nameEn`", de = `"$nameDe`" },")
    $count++
}

[void]$builder.AppendLine("}")

[System.IO.File]::WriteAllText(
    $OutputFile,
    $builder.ToString(),
    [System.Text.UTF8Encoding]::new($false)
)

Write-Host "Fertig: $count Items geschrieben."
Write-Host "Davon mit eigener deutscher Uebersetzung: $germanCount"
Write-Host "Datei: $OutputFile"
Write-Host "Danach den Addon-Installer erneut starten und WoW neu starten."
