# Addons – Installation, Aktualisierung und Nutzung

Dieses Dokument beschreibt die aktuell verwendeten Addons und die dazugehörigen Skripte für den lokalen WoW-3.3.5a-Client.

## Grundregel

Addon-Dateien liegen im Projekt unter:

```text
D:\Private\WoW\Addons\
```

Der aktive WoW-Client lädt Addons aus:

```text
D:\Private\WoW\Client\WoW 3.3.5a\Interface\AddOns\
```

Nach Änderungen an Addon-Dateien gilt deshalb normalerweise:

1. Änderungen mit `git pull` holen.
2. Das passende Installationsskript ausführen.
3. WoW vollständig beenden und neu starten.

Ein einfaches `/reload` reicht bei geänderten `.toc`-Dateien oder neu hinzugefügten Lua-Dateien nicht immer zuverlässig aus.

---

## PrivateWoWAdmin

`PrivateWoWAdmin` ist das eigene Admin-Addon für GM-, NPCBot- und Item-Funktionen.

### Installation oder Aktualisierung

```powershell
cd D:\Private\WoW
git pull
```

Danach:

```text
D:\Private\WoW\scripts\install-privatewowadmin-addon.bat
```

Anschließend WoW vollständig neu starten.

### Öffnen

Über das Zahnrad-Symbol an der Minimap oder mit:

```text
/pwa
```

Die Item-Datenbank kann zusätzlich direkt geöffnet werden mit:

```text
/pwai
```

Eine Suche kann direkt übergeben werden:

```text
/pwai ruhestein
/pwai hearthstone
/pwai 6948
```

### Enthaltene Bereiche

- NPCBots verwalten
- GM-Modus, God-Modus und Fliegen
- Teleports
- beliebige Serverbefehle
- zweisprachige Item-Suche
- Items direkt ins Inventar legen

### Item-Datenbank neu erzeugen

Die Item-Datenbank wird aus `acore_npcbots_world` erzeugt und enthält englische und deutsche Namen.

Das ist nötig:

- nach Änderungen oder Updates der AzerothCore-Weltdatenbank
- wenn die Item-Datendatei fehlt
- wenn neue oder geänderte Übersetzungen übernommen werden sollen

Ausführen:

```powershell
cd D:\Private\WoW
powershell -ExecutionPolicy Bypass -File .\scripts\generate-item-database.ps1
```

MySQL fragt dabei nach dem Root-Passwort.

Danach das Admin-Addon erneut installieren:

```text
D:\Private\WoW\scripts\install-privatewowadmin-addon.bat
```

Dann WoW neu starten.

### Items ohne Addon geben

Item suchen:

```text
.lookup item <Suchtext>
```

Beispiel:

```text
.lookup item hearthstone
```

Item über ID und Anzahl geben:

```text
.additem <Item-ID> <Anzahl>
```

Beispiel:

```text
.additem 6948 1
```

---

## Questie-335

Questie zeigt verfügbare Quests, Questgeber, Abgabeorte und Questziele auf Karte und Minimap an. Zusätzlich bietet es einen erweiterten Questtracker und eine Suche.

### Installation oder Neuinstallation

```powershell
cd D:\Private\WoW
git pull
powershell -ExecutionPolicy Bypass -File .\scripts\install-questie-335.ps1
```

Das Skript lädt Questie aus dem öffentlichen Repository und installiert es nach:

```text
D:\Private\WoW\Client\WoW 3.3.5a\Interface\AddOns\Questie-335
```

Danach WoW vollständig neu starten.

### Im Spiel prüfen

In der Charakterauswahl unten links auf `AddOns` klicken und prüfen, ob `Questie-335` aktiviert ist.

Im Spiel:

```text
/questie
```

Questie besitzt außerdem ein eigenes Minimap-Symbol.

### Wann das Installationsskript erneut ausführen?

- bei einer Erstinstallation
- wenn Questie beschädigt oder unvollständig ist
- wenn eine neue Version bewusst erneut heruntergeladen werden soll
- wenn der komplette WoW-Clientordner ersetzt wurde

Für den normalen täglichen Serverstart ist das Skript nicht erforderlich.

---

## Server und Client starten

Für den NPCBots-Server wird verwendet:

```text
D:\Private\WoW\scripts\start-npcbots-server.bat
```

Das Skript startet nacheinander:

1. NPCBots-Authserver
2. NPCBots-Worldserver
3. WoW-Client

Das Addon- oder Questie-Installationsskript muss nicht vor jedem Spielstart ausgeführt werden.

---

## Typischer Ablauf nach GitHub-Änderungen

Wenn nur Dokumentation oder Server-Skripte geändert wurden:

```powershell
cd D:\Private\WoW
git pull
```

Wenn `PrivateWoWAdmin` geändert wurde:

```powershell
cd D:\Private\WoW
git pull
.\scripts\install-privatewowadmin-addon.bat
```

Wenn das Item-Datenformat oder die Weltdatenbank geändert wurde:

```powershell
cd D:\Private\WoW
git pull
powershell -ExecutionPolicy Bypass -File .\scripts\generate-item-database.ps1
.\scripts\install-privatewowadmin-addon.bat
```

Wenn Questie installiert oder neu geladen werden soll:

```powershell
cd D:\Private\WoW
git pull
powershell -ExecutionPolicy Bypass -File .\scripts\install-questie-335.ps1
```

Danach WoW jeweils vollständig neu starten.

---

## Fehlerdiagnose bei Addons

Lua-Fehler im Spiel aktivieren:

```text
/console scriptErrors 1
```

Später wieder deaktivieren:

```text
/console scriptErrors 0
```

Weitere Prüfungen:

- Addon in der Charakterauswahl aktiviert?
- richtiger Unterordner unter `Interface\AddOns`?
- liegt die `.toc` direkt im Addon-Hauptordner?
- WoW nach der Installation wirklich komplett neu gestartet?
- bei alten Addons gegebenenfalls `Veraltete Addons laden` aktivieren?

## Geplanter nächster Addon-Schritt

Questie zunächst praktisch testen. Falls eine automatische Abarbeitungsreihenfolge oder ein Navigationspfeil fehlt, anschließend TomTom oder ein kompatibler QuestHelper für 3.3.5a prüfen. Nicht mehrere vollständige Quest-Addons gleichzeitig installieren, bevor Konflikte ausgeschlossen sind.
