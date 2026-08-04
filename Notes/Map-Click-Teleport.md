# Teleportieren per Strg + Linksklick auf der Weltkarte

`PrivateWoWAdmin` kann einen Klick auf der Weltkarte in das naechstgelegene bekannte Ziel aus `game_tele` umsetzen.

## Daten erzeugen

```powershell
cd D:\Private\WoW
powershell -ExecutionPolicy Bypass -File .\scripts\generate-map-teleport-data.ps1
.\scripts\install-privatewowadmin-addon.bat
```

MySQL fragt beim Generator nach dem Root-Passwort. Danach WoW vollstaendig beenden und neu starten.

## Nutzung

1. Weltkarte mit `M` oeffnen.
2. In das gewuenschte Gebiet hineinzoomen.
3. `Strg` gedrueckt halten.
4. Mit der linken Maustaste auf den Zielbereich klicken.

Das Addon berechnet aus der Kartenposition Weltkoordinaten, sucht auf derselben WoW-Weltkarte den raeumlich naechsten Eintrag aus `game_tele` und fuehrt aus:

```text
.tele <Name>
```

Im Chat wird der ausgewaehlte Teleportname angezeigt.

## Status pruefen

```text
/pwamaptele
```

Der Befehl zeigt an, wie viele Kartenbereiche und Teleportziele geladen wurden.

## Einschraenkungen

- Die Funktion arbeitet nur auf Kartenansichten mit eindeutiger Gebiets-ID.
- Auf einer Kontinent- oder Weltuebersicht gegebenenfalls zuerst in ein Gebiet hineinzoomen.
- Das Ziel ist der naechste bekannte `game_tele`-Punkt, nicht exakt die angeklickte Stelle.
- Es werden nur die offenen Weltkarten Azeroth, Kalimdor, Scherbenwelt und Nordend beruecksichtigt.
- Fuer den Teleport werden ausreichende GM-Rechte benoetigt.

## Datenquellen

- `acore_npcbots_world.game_tele`
- `WorldMapArea.dbc`

Die erzeugte Addon-Datei lautet:

```text
D:\Private\WoW\Addons\PrivateWoWAdmin\PrivateWoWAdminMapTeleportData.lua
```
