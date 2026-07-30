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

`PrivateWoWAdmin` ist das eigene Admin-Addon für GM-, NPCBot-, Item- und Level-Set-Funktionen.

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

Die Level-Sets können direkt geöffnet werden mit:

```text
/pwaset
```

### Enthaltene Bereiche

- NPCBots verwalten
- GM-Modus, God-Modus und Fliegen
- Teleports
- beliebige Serverbefehle
- zweisprachige Item-Suche
- Items direkt ins Inventar legen
- vorbereitete Level-Sets für Klassen und Skillungen

---

## Level-Sets

Die Level-Set-Funktion stellt kuratierte Ausrüstungspakete für bestimmte Klassen, Skillungen und Levelbereiche bereit. Ziel ist nicht zwingend mathematisches Endgame-BiS, sondern angenehm starke Ausrüstung für mehr Spielspaß beim Leveln.

### Aktuell verfügbar

```text
Klasse: Schamane
Skillung: Verstärkung / Melee
```

Levelbereiche:

```text
Level 1-9
Level 10-19
```

Set-Stärken:

- `Ausgewogen`: gutes Niveau für normales Questen
- `Stark`: deutlich bessere, teilweise twink-nahe Ausrüstung
- `Erbstücke`: skalierende Komfortausrüstung für mehrere Levelbereiche

Weitere Klassen, Skillungen und Levelbereiche können später in `PrivateWoWAdminGearSets.lua` ergänzt werden.

### Level-Sets öffnen

Über das Adminfenster:

```text
/pwa
```

Dann auf den Button `Level-Sets` klicken.

Direkt per Slash-Befehl:

```text
/pwaset
```

Beim Öffnen wird anhand des aktuellen Charakterlevels automatisch zunächst `Level 1-9` oder `Level 10-19` ausgewählt.

### Bedienung

1. Gewünschten Levelbereich auswählen.
2. `Ausgewogen`, `Stark` oder `Erbstücke` wählen.
3. Die angezeigte Itemliste prüfen.
4. Auf `Komplettes Set geben` klicken.

Die Items werden nacheinander über `.additem` ins Inventar gelegt. Zwischen den Befehlen liegt eine kurze Pause, damit der Server alle Befehle zuverlässig verarbeitet.

### Wichtige Hinweise

- Das Set wird nur ins Inventar gelegt und nicht automatisch angezogen.
- Es müssen ausreichend freie Inventarplätze vorhanden sein.
- Level-, Klassen- und Rüstungsanforderungen gelten weiterhin.
- Doppelte Items, etwa zwei gleiche Schmuckstücke, werden auch doppelt hinzugefügt.
- Vor der Ausgabe wird das aktuelle Ziel entfernt, damit die Items sicher an den eigenen Charakter gehen.
- Fehlende Item-IDs werden übersprungen und im Chat gemeldet.

### Bedeutung von `vorhanden` und `fehlt`

Die Level-Set-Ansicht prüft jede Item-ID gegen die lokal erzeugte Item-Datenbank:

```text
vorhanden
```

Die Item-ID wurde in `PrivateWoWAdminItemData.lua` gefunden und kann ausgegeben werden.

```text
fehlt
```

Die Item-ID ist nicht in der lokalen Item-Datenbank vorhanden. In diesem Fall sollte die Item-Datenbank neu erzeugt werden.

### Item-Datenbank bei fehlenden Set-Items neu erzeugen

```powershell
cd D:\Private\WoW
powershell -ExecutionPolicy Bypass -File .\scripts\generate-item-database.ps1
.\scripts\install-privatewowadmin-addon.bat
```

Danach WoW vollständig neu starten.

### Einzelne Set-Items prüfen

Über die Item-Datenbank:

```text
/pwai
```

Oder direkt nach einer Item-ID suchen:

```text
/pwai 48716
```

Alternativ per Serverbefehl:

```text
.lookup item <Suchtext>
```

### Set erneut geben

Ein Set kann jederzeit erneut ausgegeben werden. Dabei entstehen jedoch doppelte Items. Vorher sollte deshalb geprüft werden, welche Teile bereits im Inventar oder angelegt sind.

### Geplante Erweiterungen

Mögliche nächste Schritte:

- weitere Levelbereiche ab Level 20
- weitere Schamanen-Skillungen
- weitere Klassen
- automatische Auswahl nach Klasse und Skillung
- einzelne Set-Items per Button geben
- optionales automatisches Anlegen geeigneter Gegenstände

---

## Item-Datenbank neu erzeugen

Die Item-Datenbank wird aus `acore_npcbots_world` erzeugt und enthält englische und deutsche Namen.

Das ist nötig:

- nach Änderungen oder Updates der AzerothCore-Weltdatenbank
- wenn die Item-Datendatei fehlt
- wenn neue oder geänderte Übersetzungen übernommen werden sollen
- wenn Level-Set-Items als `fehlt` angezeigt werden

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

## Größere Taschen geben

Zum Vergrößern des Inventars muss der Charakter nicht Schneidern lernen. Als GM können Taschen direkt über die Itemdatenbank oder per Serverbefehl hinzugefügt werden.

### Über PrivateWoWAdmin suchen

```text
/pwai tasche
```

Alternativ mit dem englischen Suchbegriff:

```text
/pwai bag
```

Anschließend die gewünschte Tasche mit `+1` ins Inventar legen.

### Taschen per GM-Befehl suchen

```text
.lookup item bag
```

Für WotLK-Taschen kann auch gezielter gesucht werden:

```text
.lookup item frostweave
```

Eine gefundene Tasche wird über ihre Item-ID gegeben:

```text
.additem <Item-ID> <Anzahl>
```

### Vier 20-Platz-Taschen geben

Die Froststofftasche hat die Item-ID `41599`. Vier Exemplare werden so gegeben:

```text
.additem 41599 4
```

Danach die Taschen aus dem Inventar in die vier zusätzlichen Taschenplätze unten rechts ziehen.

### Häufig verwendete Taschen

```text
21841  Netherstofftasche / Netherweave Bag           16 Plätze
21843  Magieerfüllte Netherstofftasche                18 Plätze
41599  Froststofftasche / Frostweave Bag              20 Plätze
41600  Gletschertasche / Glacial Bag                  22 Plätze
51809  Tragbares Loch / Portable Hole                 24 Plätze
```

Für normales Leveln sind vier Froststofftaschen ein guter Kompromiss zwischen Komfort und Spielgefühl:

```text
.additem 41599 4
```

### Wichtige Hinweise zu Taschen

- Der ursprüngliche Rucksack ganz links kann nicht ersetzt werden.
- Die vier zusätzlichen Taschenplätze können jeweils mit einer normalen Tasche belegt werden.
- Banktaschenplätze müssen im Bankfenster gegebenenfalls zunächst gekauft werden.
- Spezialtaschen für Kräuter, Erze oder Verzaubermaterial nehmen nur bestimmte Gegenstandstypen auf.
- Normale Taschen sind für allgemeines Leveln am praktischsten.
- Die 24-Platz-Tasche stammt aus spätem WotLK-Content und ist deutlich komfortabler als für frühe Level vorgesehen.

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

Wenn `PrivateWoWAdmin`, die Item-Datenbank-Oberfläche oder die Level-Sets geändert wurden:

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
- bei fehlenden Set-Items die Item-Datenbank neu erzeugt?

## Geplanter nächster Addon-Schritt

Questie zunächst praktisch testen. Falls eine automatische Abarbeitungsreihenfolge oder ein Navigationspfeil fehlt, anschließend TomTom oder ein kompatibler QuestHelper für 3.3.5a prüfen. Die Level-Sets können parallel schrittweise um weitere Klassen, Skillungen und Levelbereiche erweitert werden.
