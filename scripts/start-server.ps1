$installPath = "D:\Private\WoW\AzerothCore\Install"

if (-not (Test-Path "$installPath\authserver.exe")) {
    throw "authserver.exe wurde nicht gefunden: $installPath"
}

if (-not (Test-Path "$installPath\worldserver.exe")) {
    throw "worldserver.exe wurde nicht gefunden: $installPath"
}

$mysqlService = Get-Service -Name "MySQL*" -ErrorAction SilentlyContinue |
    Select-Object -First 1

if ($null -eq $mysqlService) {
    throw "Es wurde kein MySQL-Windows-Dienst gefunden."
}

if ($mysqlService.Status -ne "Running") {
    Write-Host "Starte MySQL-Dienst $($mysqlService.Name)..."
    Start-Service $mysqlService.Name
    $mysqlService.WaitForStatus("Running", [TimeSpan]::FromSeconds(20))
}

Write-Host "Starte AzerothCore Authserver..."
Start-Process powershell.exe `
    -WorkingDirectory $installPath `
    -ArgumentList "-NoExit", "-Command", "& '.\authserver.exe'"

Start-Sleep -Seconds 2

Write-Host "Starte AzerothCore Worldserver..."
Start-Process powershell.exe `
    -WorkingDirectory $installPath `
    -ArgumentList "-NoExit", "-Command", "& '.\worldserver.exe'"