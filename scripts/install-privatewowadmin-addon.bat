@echo off
setlocal

title PrivateWoWAdmin Addon Installer

set "PROJECT_DIR=D:\Private\WoW"
set "SOURCE_DIR=%PROJECT_DIR%\Addons\PrivateWoWAdmin"
set "TARGET_DIR=%PROJECT_DIR%\Client\WoW 3.3.5a\Interface\AddOns\PrivateWoWAdmin"

echo ==============================================
echo   PrivateWoWAdmin Addon installieren

echo ==============================================
echo.

if not exist "%SOURCE_DIR%\PrivateWoWAdmin.toc" (
    echo FEHLER: Addon-Quelldateien wurden nicht gefunden:
    echo %SOURCE_DIR%
    echo.
    echo Bitte zuerst im Projektordner "git pull" ausfuehren.
    pause
    exit /b 1
)

if not exist "%PROJECT_DIR%\Client\WoW 3.3.5a\Wow.exe" (
    echo FEHLER: Der WoW-Client wurde nicht gefunden.
    pause
    exit /b 1
)

if not exist "%PROJECT_DIR%\Client\WoW 3.3.5a\Interface\AddOns" (
    mkdir "%PROJECT_DIR%\Client\WoW 3.3.5a\Interface\AddOns"
)

if exist "%TARGET_DIR%" (
    echo Entferne vorhandene Addon-Version...
    rmdir /S /Q "%TARGET_DIR%"
)

echo Kopiere Addon...
xcopy "%SOURCE_DIR%" "%TARGET_DIR%\" /E /I /Y >NUL

if not exist "%TARGET_DIR%\PrivateWoWAdmin.toc" (
    echo FEHLER: Die Installation ist fehlgeschlagen.
    pause
    exit /b 1
)

echo.
echo Addon erfolgreich installiert:
echo %TARGET_DIR%
echo.
echo Starte WoW anschliessend neu und oeffne das Fenster mit:
echo /pwa
echo.
pause

endlocal
exit /b 0
