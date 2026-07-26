# Private WoW Server – Projektnotizen

Dieses Verzeichnis dokumentiert den Aufbau und die spätere Pflege des lokalen World-of-Warcraft-Servers auf Basis von AzerothCore 3.3.5a.

## Ziel

- WoW 3.3.5a lokal und offline spielen
- alten Quest-, Dungeon- und Raid-Content nachholen
- keine simulierten Spieler in der Welt
- NPCBots später gezielt als Gruppenhelfer einsetzen
- alle Änderungen nachvollziehbar dokumentieren

## Aktueller Stand

- AzerothCore aus dem offiziellen Repository gebaut
- Visual Studio 2026, CMake 4.4, Boost 1.81, OpenSSL 3.6.3 und MySQL 8.4 eingerichtet
- `authserver.exe` und `worldserver.exe` erfolgreich erstellt
- Datenbanken `acore_auth`, `acore_characters` und `acore_world` eingerichtet
- DBC, Maps, VMaps und MMaps aus dem WoW-Client extrahiert
- Worldserver läuft auf Port `8086`
- lokaler Login funktioniert
- erster Charakter wurde erstellt und betreten
- GM-Level 3 wurde für den Account gesetzt
- sauberer Ausgangsstand im AzerothCore-Repository mit dem Tag `clean-server-first-login` markiert
- Branch `feature-npcbots` für die spätere NPCBots-Integration angelegt

## Wichtige Pfade

```text
D:\Private\WoW\
├── AzerothCore\
│   ├── Source\
│   ├── Build\
│   └── Install\
├── Backup\
├── Client\
│   └── WoW 3.3.5a\
├── Database\
├── Notes\
└── scripts\
```

## Wichtige Serverdaten

```text
Authserver-Port: 3724
Worldserver-Port: 8086
Realm-ID: 1
Realm-Adresse: 127.0.0.1
Client-Build: 12340
```

## Server starten

In zwei getrennten PowerShell-Fenstern:

```powershell
cd D:\Private\WoW\AzerothCore\Install
.\authserver.exe
```

```powershell
cd D:\Private\WoW\AzerothCore\Install
.\worldserver.exe
```

Beide Server sollten beim Spielen geöffnet bleiben.

## Server sauber beenden

Jeweils im Authserver- und Worldserver-Fenster:

```text
Ctrl+C
```

Den MySQL-Dienst dabei nicht stoppen.

## Nächste Schritte

1. Funktionierenden Stand sichern
2. Start- und Stop-Skripte erstellen
3. NPCBots auf dem Branch `feature-npcbots` integrieren
4. NPCBots zunächst mit einer kleinen Dungeon-Gruppe testen
5. Änderungen und Probleme hier dokumentieren
