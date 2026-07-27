# PrivateWoWAdmin

`PrivateWoWAdmin` ist ein kleines WoW-3.3.5a-Addon fuer den lokalen AzerothCore-NPCBots-Server.

Es bietet anklickbare Schaltflaechen fuer haeufig verwendete:

- NPCBot-Befehle
- GM-Befehle
- Teleports
- frei eingegebene Serverbefehle

## Installation

1. Projekt aktualisieren:

```powershell
cd D:\Private\WoW
git pull
```

2. Installer per Doppelklick starten:

```text
D:\Private\WoW\scripts\install-privatewowadmin-addon.bat
```

Das Addon wird nach folgendem Ordner kopiert:

```text
D:\Private\WoW\Client\WoW 3.3.5a\Interface\AddOns\PrivateWoWAdmin
```

3. WoW vollstaendig neu starten.

4. Im Spiel eingeben:

```text
/pwa
```

Alternativ:

```text
/privatewowadmin
```

## Funktionen der ersten Version

### NPCBots

- NPCBot-Hilfe anzeigen
- freie Bots auflisten
- Bots nach Klassen-ID suchen
- Bots ueber Bot-ID erzeugen
- ausgewaehlten Bot uebernehmen
- ausgewaehlten Bot entfernen
- Bots folgen lassen
- Bots warten lassen
- Bots zum Spieler teleportieren

### GM

- GM-Modus an/aus
- God-Modus an/aus
- Fliegen an/aus
- Sichtbarkeit an/aus
- Level erhoehen
- wiederbeleben
- Position anzeigen
- Recall
- Klassenzauber lernen
- Reittiere lernen
- Respawn
- Instanzbindungen zuruecksetzen
- Goldbetrag eingeben
- Lauf- und Fluggeschwindigkeit setzen
- Befehlsliste und Hilfe anzeigen

### Teleport

Direktbuttons fuer:

- Sturmwind
- Eisenschmiede
- Darnassus
- Exodar
- Orgrimmar
- Unterstadt
- Donnerfels
- Silbermond
- Dalaran
- Shattrath

Ausserdem kann ein eigener Teleportname eingegeben oder gesucht werden.

### Eigener Befehl

Beliebige GM- oder NPCBot-Befehle koennen eingegeben und per Klick ausgefuehrt werden. Der fuehrende Punkt wird automatisch ergaenzt.

Beispiele:

```text
.npcbot help spawn
.lookup item Frostmourne
.additem 6948 1
.quest complete 12345
```

## Bedienung

- Das Fenster kann mit der linken Maustaste verschoben werden.
- Die Position wird gespeichert.
- Das Fenster wird mit `/pwa` ein- und ausgeblendet.
- Fuer `Bot uebernehmen` und `Bot entfernen` muss vorher ein Bot als Ziel ausgewaehlt sein.

## Wichtiger Hinweis

Einzelne Serverbefehle koennen sich zwischen AzerothCore- oder NPCBots-Versionen unterscheiden. Bei Problemen zuerst die eingebaute Hilfe verwenden:

```text
.commands
.help <Befehl>
.npcbot
.npcbot help
```

## Geplante Erweiterungen

- Favoriten
- konfigurierbare Schnellbefehle
- Item- und Quest-Helfer
- Bot-Gruppenvorlagen
- Minimap-Schaltflaeche
- bessere Rueckmeldungen aus Serverantworten
