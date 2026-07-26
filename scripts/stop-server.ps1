$processNames = @(
    "authserver",
    "worldserver"
)

foreach ($processName in $processNames) {
    $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue

    if ($processes) {
        Write-Host "Beende $processName..."
        $processes | Stop-Process
    }
    else {
        Write-Host "$processName läuft nicht."
    }
}