# NPCBots – How-to und Befehlsübersicht

Dieses Dokument beschreibt die praktische Nutzung der NPCBots im lokalen AzerothCore-Server.

> Wichtig: Die im Spiel verfügbare Hilfe ist immer die verlässlichste Quelle für die aktuell eingebaute Version. Verwende bei Unklarheiten zuerst `.npcbot`, `.npcbot help` oder die Hilfe eines Unterbefehls.

## Aktueller Stand

- NPCBots-Core läuft erfolgreich.
- NPCBots-Realm verwendet Realm-ID `2` und Port `8087`.
- Ein Krieger-Bot wurde erfolgreich erstellt.
- Der Bot wurde angeheuert und zur Gruppe hinzugefügt.
- GM-Befehle funktionieren.

## Grundprinzip

NPCBots sind keine simulierten Mitspieler, die selbstständig die Welt bevölkern. Sie sind gezielt anheuerbare Begleiter für:

- Elite-Quests
- Gruppenquests
- Dungeons
- ältere Raids
- Tank-, Heiler- und Schadensrollen

Die Bots folgen deinem Charakter, kämpfen mit dir und können über Dialoge und Befehle gesteuert werden.

## Hilfe anzeigen

Alle verfügbaren NPCBot-Befehle:

```text
.npcbot
```

Je nach Version funktioniert auch:

```text
.npcbot help
```

Hilfe für einen bestimmten Bereich:

```text
.npcbot help <Unterbefehl>
```

Beispiel:

```text
.npcbot help spawn
```

## Bot suchen und erzeugen

### Verfügbare Bots bzw. Klassen suchen

```text
.npcbot lookup
```

Nach einer bestimmten Klasse suchen:

```text
.npcbot lookup <Klassen-ID>
```

Übliche WoW-Klassen-IDs:

| ID | Klasse |
|---:|---|
| 1 | Krieger |
| 2 | Paladin |
| 3 | Jäger |
| 4 | Schurke |
| 5 | Priester |
| 6 | Todesritter |
| 7 | Schamane |
| 8 | Magier |
| 9 | Hexenmeister |
| 11 | Druide |

Beispiel für Krieger:

```text
.npcbot lookup 1
```

### Bot erzeugen

Aus der Ergebnisliste eine Bot-ID auswählen:

```text
.npcbot spawn <Bot-ID>
```

Beispiel:

```text
.npcbot spawn 70001
```

Der Bot erscheint normalerweise in deiner Nähe. Das Erzeugen sollte in der offenen Welt erfolgen, nicht innerhalb einer Instanz.

## Bot anheuern

### Über das Dialogmenü

1. Bot rechts anklicken.
2. Im Dialog die Option zum Anheuern auswählen.
3. Anschließend den Bot über sein Dialogmenü zur Gruppe hinzufügen.

### Als GM direkt übernehmen

Bot auswählen und eingeben:

```text
.npcbot add
```

Damit wird der ausgewählte freie Bot deinem Charakter zugeordnet.

## Bot zur Gruppe hinzufügen

Bot rechts anklicken und im NPCBot-Menü eine Option wie diese auswählen:

```text
Create Group
```

oder:

```text
Add to group
```

Die genaue Formulierung kann je nach NPCBots-Version leicht abweichen.

## Empfohlene erste Gruppe

Für einen normalen Fünfer-Dungeon:

| Rolle | Empfehlung |
|---|---|
| Spieler | beliebige eigene Klasse |
| Tank | Krieger, Paladin oder Druide |
| Heiler | Priester, Paladin, Schamane oder Druide |
| DD 1 | Magier, Jäger oder Hexenmeister |
| DD 2 | Schurke, Krieger oder andere DD-Klasse |

Zum Testen reicht zunächst:

- dein eigener Charakter
- ein Tank-Bot
- ein Heiler-Bot

So lässt sich einfacher erkennen, wie Bewegung, Aggro und Heilung funktionieren.

## Bewegung und Verhalten

Alle eigenen Bots stehen lassen:

```text
.npcbot command stay
```

Alle eigenen Bots wieder folgen lassen:

```text
.npcbot command follow
```

Bots zu dir zurückholen bzw. teleportieren:

```text
.npcbot recall teleport
```

Falls ein Befehl in der verwendeten Version anders heißt, mit folgendem Befehl prüfen:

```text
.npcbot help recall
```

## Bots auflisten

Gespawnte freie Bots anzeigen:

```text
.npcbot list spawned free
```

Weitere Listenvarianten über die Hilfe anzeigen:

```text
.npcbot help list
```

## Bot entfernen

Bot auswählen und aus deiner Kontrolle entfernen:

```text
.npcbot remove
```

Je nach Dialogmenü kann ein Bot auch über Rechtsklick entlassen oder aus der Gruppe entfernt werden.

## Rollen und Ausrüstung

Viele Einstellungen werden über das Rechtsklick-Menü des Bots vorgenommen. Typischerweise lassen sich dort unter anderem verwalten:

- Gruppenbeitritt
- Rolle oder Spezialisierung
- Ausrüstung
- Fähigkeiten
- Verhalten
- Folgen oder Warten
- Entlassen des Bots

Nicht jede Klasse kann jede Rolle sinnvoll erfüllen. Ein Magier ist beispielsweise kein Tank und ein Schurke kein Heiler.

## Erster Dungeon-Test

1. Tank und Heiler anheuern.
2. Beide zur Gruppe hinzufügen.
3. Prüfen, ob beide deinem Charakter folgen.
4. Einen einfachen Dungeon der passenden Stufe wählen.
5. Vor dem Eingang bei Bedarf verwenden:

```text
.npcbot recall teleport
```

6. Erst einzelne Gegnergruppen testen.
7. Beobachten, ob Tank Aggro übernimmt und Heiler zuverlässig heilt.
8. Danach die Gruppe um ein oder zwei DD-Bots ergänzen.

Für den ersten Test eignen sich eher einfache frühe Dungeons als ein Raid mit vielen Spezialmechaniken.

## Nützliche normale GM-Befehle zusammen mit NPCBots

Eigenes Level setzen:

```text
.levelup <Anzahl>
```

Geld geben:

```text
.modify money <Kupferbetrag>
```

Beispiel für 100 Gold:

```text
.modify money 1000000
```

Hinweis: `1 Gold = 10.000 Kupfer`, daher entsprechen `100 Gold = 1.000.000 Kupfer`.

Zu einem Ort teleportieren:

```text
.tele <Ort>
```

Teleport-Orte suchen:

```text
.lookup tele <Suchbegriff>
```

Beispiel:

```text
.lookup tele stormwind
.tele stormwind
```

Nach dem Teleport Bots bei Bedarf nachholen:

```text
.npcbot recall teleport
```

## Typische Probleme

### Bot folgt nicht

```text
.npcbot command follow
```

Wenn nötig:

```text
.npcbot recall teleport
```

### Bot bleibt an Gelände hängen

Die erzeugten MMaps müssen vorhanden sein. Danach den Bot mit `recall teleport` zurückholen.

### Bot erscheint nicht in der Gruppe

Bot rechts anklicken und über das Dialogmenü zur Gruppe hinzufügen. Prüfen, ob der Bot bereits einem anderen Besitzer zugeordnet ist.

### Befehl wird nicht erkannt

```text
.npcbot
```

oder:

```text
.npcbot help
```

Die genaue Syntax kann sich zwischen NPCBots-Versionen unterscheiden.

### Bot reagiert in einem Bosskampf schlecht

NPCBots können normale Kämpfe gut unterstützen, verstehen aber nicht zwangsläufig jede komplexe Bossmechanik. Hilfreich sind:

- Bots vor dem Kampf passend positionieren
- `stay` und `follow` gezielt verwenden
- problematische Mechaniken mit GM-Rechten vereinfachen
- zunächst ältere oder mechanisch einfachere Instanzen testen

## Sicherer Umgang

Vor größeren Änderungen an Bots, Datenbank oder Konfiguration:

1. Authserver und Worldserver mit `Ctrl+C` beenden.
2. Datenbanken sichern.
3. Konfigurationen sichern.
4. Erst danach Updates oder größere Experimente durchführen.

## Noch zu dokumentieren

Sobald praktisch getestet, ergänzen wir hier:

- die besten Tank- und Heilerklassen
- konkrete Spezialisierungsoptionen
- Ausrüstungsverwaltung
- Bot-Menüs mit deutscher Übersetzung
- bewährte Dungeon-Gruppen
- Raid-Erfahrungen
- besondere Befehle der aktuell installierten NPCBots-Version
