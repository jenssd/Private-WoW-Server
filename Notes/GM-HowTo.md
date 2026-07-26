# GM-HowTo für AzerothCore 3.3.5a

Dieses Dokument enthält die wichtigsten GM-Funktionen für den lokalen Server.

## Voraussetzungen

Der Account benötigt GM-Level 3:

```text
account set gmlevel Jens 3 -1
```

Die Befehle können entweder direkt in der Worldserver-Konsole oder im Spiel eingegeben werden. Im Spiel beginnen GM-Befehle mit einem Punkt.

Beispiel:

```text
.tele stormwind
```

## GM-Modus aktivieren

```text
.gm on
```

GM-Modus wieder deaktivieren:

```text
.gm off
```

Status anzeigen:

```text
.gm
```

## Unsichtbar werden

```text
.gm visible off
```

Wieder sichtbar werden:

```text
.gm visible on
```

## Unverwundbar werden

```text
.gm god on
```

Wieder deaktivieren:

```text
.gm god off
```

## Fliegen aktivieren

```text
.gm fly on
```

Deaktivieren:

```text
.gm fly off
```

Die Fluggeschwindigkeit kann zusätzlich angepasst werden:

```text
.modify speed fly 3
```

## Teleportieren

Nach Sturmwind:

```text
.tele stormwind
```

Nach Orgrimmar:

```text
.tele orgrimmar
```

Nach Dalaran:

```text
.tele dalaran
```

Nach Shattrath:

```text
.tele shattrath
```

Teleport-Orte suchen:

```text
.lookup tele dalaran
```

Zum Ziel teleportieren:

```text
.tele <Name>
```

Zur aktuellen Position zurückspringen:

```text
.recall
```

## Level ändern

Eigenes Level setzen:

```text
.levelup 79
```

Bei einem neuen Charakter auf Level 1 führt das zu Level 80.

Alternativ Ziel auswählen und:

```text
.modify level 80
```

## Geld geben

Der Wert wird in Kupfer angegeben.

Beispiel für 100 Gold:

```text
.modify money 1000000
```

Um Geld abzuziehen, einen negativen Wert verwenden.

## Geschwindigkeit ändern

Laufgeschwindigkeit:

```text
.modify speed 2
```

Schwimmgeschwindigkeit:

```text
.modify speed swim 2
```

Fluggeschwindigkeit:

```text
.modify speed fly 3
```

Mit `1` wird normalerweise wieder der Standardwert gesetzt.

## Gegenstände finden und geben

Gegenstand suchen:

```text
.lookup item Frostmourne
```

Gegenstand über seine ID geben:

```text
.additem <Item-ID> 1
```

Beispiel:

```text
.additem 6948 1
```

## Zauber lernen

Zauber suchen:

```text
.lookup spell teleport
```

Zauber lernen:

```text
.learn <Spell-ID>
```

Zauber wieder entfernen:

```text
.unlearn <Spell-ID>
```

Alle Klassenzauber lernen:

```text
.learn all my class
```

Alle Reitfertigkeiten lernen:

```text
.learn all my mounts
```

## Ruf ändern

Fraktion suchen:

```text
.lookup faction Argent Crusade
```

Ruf setzen:

```text
.modify reputation <Fraktions-ID> 42999
```

## Quests

Quest suchen:

```text
.lookup quest <Suchtext>
```

Quest hinzufügen:

```text
.quest add <Quest-ID>
```

Quest abschließen:

```text
.quest complete <Quest-ID>
```

Quest entfernen:

```text
.quest remove <Quest-ID>
```

## NPCs und Kreaturen

NPC suchen:

```text
.lookup creature <Name>
```

NPC beschwören:

```text
.npc add <Creature-ID>
```

Ausgewählten NPC löschen:

```text
.npc delete
```

Informationen zum ausgewählten NPC anzeigen:

```text
.npc info
```

## Instanzen und Raids

Instanzbindungen anzeigen:

```text
.instance listbinds
```

Eigene Instanzbindungen zurücksetzen:

```text
.instance unbind all
```

Alle Kreaturen im Umkreis wiederbeleben:

```text
.respawn
```

## Charakter wiederbeleben

Eigenen Charakter wiederbeleben:

```text
.revive
```

Einen ausgewählten Spieler wiederbeleben:

```text
.reviveplayer
```

## Position anzeigen

```text
.gps
```

Das ist besonders hilfreich, wenn später eigene Teleports, NPCs oder Spawnpunkte angelegt werden sollen.

## Hilfe zu Befehlen

Alle verfügbaren Befehle anzeigen:

```text
.commands
```

Hilfe zu einem bestimmten Befehl:

```text
.help tele
```

## Sicherheitshinweis

GM-Befehle können Charaktere, Quests, Instanzen und Datenbankzustände dauerhaft verändern. Vor größeren Experimenten sollte ein Datenbank-Backup erstellt werden.
