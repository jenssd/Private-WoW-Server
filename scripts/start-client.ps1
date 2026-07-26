$wowPath = "D:\Private\WoW\Client\WoW 3.3.5a\Wow.exe"

if (-not (Test-Path $wowPath)) {
    throw "Wow.exe wurde nicht gefunden: $wowPath"
}

Start-Process $wowPath -WorkingDirectory (Split-Path $wowPath)