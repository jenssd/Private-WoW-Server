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

Write-Host "Lese Itemdaten aus '$Database'..."
Write-Host "MySQL fragt gleich nach dem root-Passwort."

$query = "SELECT entry, name FROM item_template WHERE name IS NOT NULL AND name <> '' ORDER BY entry;"
$rows = & $MySqlExe -u root -p --batch --raw --skip-column-names $Database -e $query

if ($LASTEXITCODE -ne 0) {
    throw "Der MySQL-Export ist fehlgeschlagen."
}

$builder = [System.Text.StringBuilder]::new()
[void]$builder.AppendLine("PrivateWoWAdminItems = PrivateWoWAdminItems or {}")
[void]$builder.AppendLine("PrivateWoWAdminItems.data = {")

$count = 0
foreach ($row in $rows) {
    if ([string]::IsNullOrWhiteSpace($row)) {
        continue
    }

    $parts = $row -split "`t", 2
    if ($parts.Count -ne 2) {
        continue
    }

    $itemId = 0
    if (-not [int]::TryParse($parts[0], [ref]$itemId)) {
        continue
    }

    $itemName = Escape-LuaString $parts[1]
    [void]$builder.AppendLine("    [$itemId] = `"$itemName`",")
    $count++
}

[void]$builder.AppendLine("}")

[System.IO.File]::WriteAllText(
    $OutputFile,
    $builder.ToString(),
    [System.Text.UTF8Encoding]::new($false)
)

Write-Host "Fertig: $count Items geschrieben."
Write-Host "Datei: $OutputFile"
Write-Host "Danach den Addon-Installer erneut starten und WoW neu laden."
