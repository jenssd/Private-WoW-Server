@echo off
setlocal

title Private WoW Server - NPCBots Starter

set "SERVER_DIR=D:\Private\WoW\AzerothCore\Install-NPCBots"
set "CLIENT_DIR=D:\Private\WoW\Client\WoW 3.3.5a"
set "AUTH_EXE=%SERVER_DIR%\authserver.exe"
set "WORLD_EXE=%SERVER_DIR%\worldserver.exe"
set "WOW_EXE=%CLIENT_DIR%\Wow.exe"

echo ==============================================
echo   AzerothCore NPCBots Server wird gestartet
echo ==============================================
echo.

if not exist "%AUTH_EXE%" (
    echo FEHLER: authserver.exe wurde nicht gefunden:
    echo %AUTH_EXE%
    pause
    exit /b 1
)

if not exist "%WORLD_EXE%" (
    echo FEHLER: worldserver.exe wurde nicht gefunden:
    echo %WORLD_EXE%
    pause
    exit /b 1
)

if not exist "%WOW_EXE%" (
    echo FEHLER: Wow.exe wurde nicht gefunden:
    echo %WOW_EXE%
    pause
    exit /b 1
)

tasklist /FI "IMAGENAME eq authserver.exe" 2>NUL | find /I "authserver.exe" >NUL
if not errorlevel 1 (
    echo FEHLER: authserver.exe laeuft bereits.
    echo Bitte vorhandenen Server zuerst sauber beenden.
    pause
    exit /b 1
)

tasklist /FI "IMAGENAME eq worldserver.exe" 2>NUL | find /I "worldserver.exe" >NUL
if not errorlevel 1 (
    echo FEHLER: worldserver.exe laeuft bereits.
    echo Bitte vorhandenen Server zuerst sauber beenden.
    pause
    exit /b 1
)

echo Starte Authserver...
start "AzerothCore NPCBots - Authserver" cmd /k "cd /d "%SERVER_DIR%" && authserver.exe"

timeout /t 3 /nobreak >NUL

echo Starte Worldserver...
start "AzerothCore NPCBots - Worldserver" cmd /k "cd /d "%SERVER_DIR%" && worldserver.exe"

echo Warte auf die Serverinitialisierung...
timeout /t 25 /nobreak >NUL

echo Starte WoW-Client...
start "" /D "%CLIENT_DIR%" "%WOW_EXE%"

echo.
echo Server und Client wurden gestartet.
echo Die beiden Serverfenster beim Spielen geoeffnet lassen.
echo Zum sauberen Beenden jeweils Ctrl+C im Serverfenster verwenden.
echo.

endlocal
exit /b 0
