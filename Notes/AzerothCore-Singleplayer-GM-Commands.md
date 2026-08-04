# AzerothCore – nützliche GM-Commands für ein lokales Singleplayer-Spiel

> Kuratierte Befehlsreferenz für einen privaten AzerothCore-WotLK-3.3.5a-Server.  
> Stand: 4. August 2026  
> Schwerpunkt: Questen, Erkunden, Solo-Dungeons/Raids, Ausrüstung, Charakterpflege und Fehlersuche.

## Grundregeln

- **Im Spielchat** beginnen Befehle mit einem Punkt: `.gm on`
- **In der Worldserver-Konsole** kann der führende Punkt weggelassen werden.
- Viele Befehle wirken auf das **ausgewählte Ziel**. Vor Befehlen für den eigenen Charakter daher im Zweifel:

```text
/cleartarget
```

- Syntax prüfen:

```text
.help <Befehl>
```

Beispiele:

```text
.help cheat
.help modify speed
.help quest complete
```

- Verfügbare Befehle für die eigene GM-Stufe anzeigen:

```text
.commands
```

- Empfohlene GM-Stufe für den eigenen lokalen Account: **3 (Administrator)**. Das Setzen erfolgt in der Worldserver-Konsole:

```text
account set gmlevel <ACCOUNTNAME> 3 -1
```

Danach aus- und wieder einloggen.

---

# 1. GM-Modus und allgemeine Hilfe

## GM-Modus aktivieren

```text
.gm on
.gm off
```

Aktiviert beziehungsweise deaktiviert den GM-Status. Einige Debug-Anzeigen und Funktionen setzen aktiven GM-Modus voraus.

## GM-Sichtbarkeit

```text
.gm visible on
.gm visible off
```

Bei `off` wirst du für normale Kreaturen und Spieler unsichtbar. Für normales Spielen meistens eingeschaltet lassen.

## GM-Flugmodus

```text
.gm fly on
.gm fly off
```

Erlaubt freies Fliegen, auch dort, wo normales Fliegen nicht vorgesehen ist.

## Aktive Cheats anzeigen

```text
.cheat status
```

Zeigt an, welche Cheat-Schalter aktuell aktiv sind.

## Charakter sofort speichern

```text
.save
```

Speichert den eigenen Charakter sofort. Praktisch vor riskanten Tests oder vor dem Beenden des Servers.

## Alle Charaktere speichern

```text
.saveall
```

Speichert alle eingeloggten Charaktere.

---

# 2. Komfort-Cheats für Singleplayer

## Unverwundbarkeit

```text
.cheat god on
.cheat god off
```

Bei aktiviertem God Mode nimmt dein Charakter keinen normalen Schaden. Sehr hilfreich für Solo-Raids, Tests oder festgefahrene Kämpfe.

## Zauber ohne Zauberzeit

```text
.cheat casttime on
.cheat casttime off
```

Entfernt die Zauberzeit aller eigenen Zauber. Wirkt nicht nur auf einen bestimmten Zauber.

## Keine Zauberkosten

```text
.cheat power on
.cheat power off
```

Zauber verbrauchen keine Ressource wie Mana, Energie oder Wut.

## Keine Abklingzeiten

```text
.cheat cooldown on
.cheat cooldown off
```

Deaktiviert die regulären Abklingzeiten des Charakters.

## Einzelne oder alle Cooldowns zurücksetzen

```text
.cooldown
.cooldown <SPELL-ID>
```

Ohne Spell-ID werden alle aktuellen Cooldowns entfernt. Mit ID wird nur der angegebene Zauber zurückgesetzt.

## Auf Wasser laufen

```text
.cheat waterwalk on
.cheat waterwalk off
```

Aktiviert oder deaktiviert Wasserlaufen.

## Karte vollständig aufdecken

```text
.cheat explore 1
.cheat explore 0
```

`1` deckt die gesamte Karte auf, `0` verbirgt sie wieder. Ohne ausgewählten Spieler wirkt der Befehl auf dich.

## Alle Flugpunkte temporär freischalten

```text
.cheat taxi on
.cheat taxi off
```

Schaltet alle Taxirouten temporär frei. Bereits regulär entdeckte Flugpunkte bleiben nach dem Abschalten erhalten.

---

# 3. Bewegung und Geschwindigkeit

## Gesamte Bewegungsgeschwindigkeit

```text
.modify speed <FAKTOR>
```

Beispiele:

```text
.modify speed 1
.modify speed 2
.modify speed 3
```

`1` ist normal, `2` doppelte und `3` dreifache Geschwindigkeit. Vorher `/cleartarget` verwenden, damit nicht versehentlich ein anderer Spieler oder Bot verändert wird.

## Fluggeschwindigkeit

```text
.modify speed fly <FAKTOR>
```

Beispiel:

```text
.modify speed fly 3
```

## Schwimmgeschwindigkeit

```text
.modify speed swim <FAKTOR>
```

## Rückwärtslaufgeschwindigkeit

```text
.modify speed backwalk <FAKTOR>
```

## Reiten beenden

```text
.dismount
```

Steigt sofort vom Reittier ab.

## Größe verändern

```text
.modify scale <FAKTOR>
```

Erlaubter Bereich laut AzerothCore: ungefähr `0.1` bis `10`.

Beispiele:

```text
.modify scale 1
.modify scale 0.5
.modify scale 2
```

`1` stellt die normale Größe wieder her.

---

# 4. Teleportieren und Positionen

## Gespeicherten Teleport suchen

```text
.lookup teleport <SUCHTEXT>
```

Beispiel:

```text
.lookup teleport stormwind
```

Je nach Build funktioniert häufig auch die Kurzform:

```text
.lookup tele stormwind
```

## Zu gespeichertem Teleport springen

```text
.teleport <NAME>
```

Auf eurem Server beziehungsweise in eurem Addon wird auch verwendet:

```text
.tele <NAME>
```

Beispiel:

```text
.tele Stormwind
```

Der Name muss dem in `game_tele` gespeicherten Teleportnamen entsprechen.

## Aktuelle Koordinaten anzeigen

```text
.gps
```

Zeigt unter anderem:

- Map-ID
- Zonen-ID
- Area-ID
- X-, Y- und Z-Koordinaten
- Blickrichtung

Mit ausgewählter Kreatur zeigt der Befehl deren Daten.

## Zu Weltkoordinaten springen

```text
.go xyz <X> <Y> [Z] [MAP-ID] [ORIENTIERUNG]
```

Wenn `Z` fehlt, versucht der Server Boden- oder Wasserhöhe zu bestimmen.

Beispiel:

```text
.go xyz -8833 628 95 0
```

## Zu einer Position innerhalb einer Zone springen

```text
.go zonexy <X-PROZENT> <Y-PROZENT> [ZONEN-ID]
```

Beispiel:

```text
.go zonexy 50 50 12
```

Springt ungefähr in die Mitte der angegebenen Zone. Eine Zonen-ID kann mit `.lookup area` gesucht werden.

## Zu Questgeber oder Questabgabe springen

```text
.go quest starter <QUEST-ID>
.go quest ender <QUEST-ID>
```

Sehr hilfreich, wenn ein Questgeber nicht auffindbar ist.

## Zu einem Flugpunkt springen

```text
.lookup taxinode <SUCHTEXT>
.go taxinode <TAXINODE-ID>
```

## Zu einem Friedhof springen

```text
.go graveyard <FRIEDHOF-ID>
```

## Entfernung zum Ziel anzeigen

```text
.distance
```

Zeigt die Entfernung zur ausgewählten Kreatur.

---

# 5. Tod, Kampf und Feststecken

## Sich selbst wiederbeleben

```text
.revive
```

Ohne ausgewählten Spieler wirst du selbst wiederbelebt.

## Gruppe wiederbeleben

```text
.group revive
```

Belebt Gruppenmitglieder wieder. Je nach Build kann ein Charaktername angegeben werden.

## Kampf sofort beenden

```text
.combatstop
```

Beendet den Kampfzustand für dich beziehungsweise den ausgewählten Spieler.

## Ausgewähltes Ziel sofort töten

```text
.die
```

**Vorsicht:** Ohne geeignetes Ziel kann der Befehl den eigenen Charakter töten.

## Direkten Schaden verursachen

```text
.damage <SCHADEN>
```

Beispiel:

```text
.damage 10000
```

Fügt dem ausgewählten Ziel direkten Schaden zu. Für normales Spielen selten nötig, aber nützlich bei verbuggten Gegnern.

## Alle eigenen Cooldowns entfernen

```text
.cooldown
```

Hilfreich, wenn ein Bossversuch direkt wiederholt werden soll.

## Nahe Kreaturen und Objekte respawnen

```text
.respawn
```

Ohne Ziel werden nahe Kreaturen beziehungsweise Objekte respawnt.

## Größeren Bereich respawnen

```text
.respawn all
```

Erzwingt nahe und ausstehende Respawns auf der aktuellen Karte. Nicht unnötig oft verwenden.

---

# 6. Level, Erfahrung, Werte und Talente

## Um Level erhöhen oder senken

```text
.levelup [ANZAHL]
```

Beispiele:

```text
.levelup
.levelup 5
.levelup -1
```

Ohne Zahl wird um ein Level erhöht.

## Bestimmtes Level setzen

```text
.character level <CHARAKTERNAME> <LEVEL>
```

Je nach Zielauswahl kann der Name entfallen. Beim Herabsetzen können Talente zurückgesetzt und zu hochstufige Ausrüstungsgegenstände problematisch werden.

## Lebenspunkte setzen

```text
.modify hp <WERT>
```

Setzt den aktuellen beziehungsweise maximalen HP-Wert entsprechend der Serverimplementierung. Für dauerhaft korrekte Werte besser normale Level- und Ausrüstungsmechaniken verwenden.

## Mana setzen

```text
.modify mana <WERT>
```

## Zusätzliche freie Talentpunkte

```text
.modify talentpoints <ANZAHL>
```

Die zusätzlichen Punkte können beim nächsten Login, Levelaufstieg oder durch andere Neuberechnungen wieder auf den erwarteten Wert gesetzt werden.

## Talente zurücksetzen

```text
.reset talents
```

Setzt die Talente des ausgewählten Charakters oder ohne Ziel die eigenen zurück.

## Werte neu berechnen

```text
.reset stats
```

Berechnet die Charakterwerte für das aktuelle Level neu. Nützlich nach ungewöhnlichen Level- oder Datenbankänderungen.

## Zauberbuch auf regulären Stand zurücksetzen

```text
.reset spells
```

Entfernt nicht ursprüngliche beziehungsweise zusätzlich gelernte Zauber. **Vorher speichern oder Backup anlegen**, wenn viele Zauber per GM-Befehl gelernt wurden.

## Auf Level 1 zurücksetzen

```text
.reset level
```

**Gefährlich:** Setzt Level, Werte und Talente zurück. Hochstufige Ausrüstung kann verloren gehen oder entfernt werden.

---

# 7. Geld, Ruf, Ehre und Titel

## Geld hinzufügen oder entfernen

```text
.modify money <KUPFER>
```

AzerothCore erwartet den Wert in der kleinsten Währungseinheit.

Umrechnung:

```text
1 Gold = 10.000 Kupfer
1 Silber = 100 Kupfer
```

Beispiele:

```text
.modify money 100000
.modify money -10000
```

Das erste Beispiel fügt 10 Gold hinzu, das zweite entfernt 1 Gold.

## Fraktion suchen

```text
.lookup faction <SUCHTEXT>
```

## Ruf setzen

```text
.modify reputation <FRAKTIONS-ID> <WERT>
```

Alternativ kann je nach Build ein Rangname wie `Exalted` mit optionalem Delta verwendet werden.

## Aktuellen Ruf anzeigen

```text
.character reputation
```

## Ehre hinzufügen

```text
.modify honor <ANZAHL>
```

## Erfolg hinzufügen

```text
.achievement add <ERFOLGS-ID>
```

Alternativ kann häufig ein verlinkter Erfolg verwendet werden.

## Titel suchen

```text
.lookup title <SUCHTEXT>
```

## Titel freischalten

```text
.titles add <TITEL-ID>
```

## Titel aktiv setzen

```text
.titles current <TITEL-ID>
```

## Titel entfernen

```text
.titles remove <TITEL-ID>
```

---

# 8. Gegenstände und Inventar

## Gegenstand suchen

```text
.lookup item <SUCHTEXT>
```

Beispiele:

```text
.lookup item hearthstone
.lookup item frostweave bag
```

## Gegenstand hinzufügen

```text
.additem <ITEM-ID> [ANZAHL]
```

Beispiele:

```text
.additem 6948 1
.additem 41599 4
```

Mit negativer Anzahl können Gegenstände entfernt werden:

```text
.additem 6948 -1
```

## Gegenstand per Name oder Chatlink hinzufügen

Je nach Build akzeptiert `.additem` auch einen Namen in eckigen Klammern oder einen Shift-Klick-Itemlink:

```text
.additem [Hearthstone] 1
```

Die Item-ID ist normalerweise zuverlässiger.

## Freie Taschenplätze zählen

```text
.inventory count <CHARAKTERNAME>
```

Je nach Build kann alternativ GUID verwendet werden.

## Gesamte Ausrüstung reparieren

```text
.gear repair
```

Repariert alle Gegenstände des ausgewählten Spielers beziehungsweise des eigenen Charakters.

## Durchschnittliches Itemlevel anzeigen

```text
.gear stats
```

## Gelöschte Gegenstände auflisten

```text
.item restore list
```

## Gelöschten Gegenstand wiederherstellen

```text
.item restore <RECOVERY-ID>
```

Die Recovery-ID stammt aus `.item restore list`.

## Gegenstände per Post senden

```text
.send items <CHARAKTERNAME> "Betreff" "Text" <ITEM-ID>:<ANZAHL>
```

Beispiel:

```text
.send items Jens "Ausrüstung" "Dein neues Set" 41599:4
```

Praktisch, wenn die Taschen des Zielcharakters voll sind.

---

# 9. Zauber und Fähigkeiten

## Zauber suchen

```text
.lookup spell <SUCHTEXT>
```

Beispiel:

```text
.lookup spell chain lightning
```

## Zauber-ID prüfen

```text
.lookup spell id <SPELL-ID>
```

## Einzelnen Zauber lernen

```text
.learn <SPELL-ID>
```

Alle Ränge lernen:

```text
.learn <SPELL-ID> all
```

## Zauber wieder entfernen

```text
.unlearn <SPELL-ID>
```

Alle Ränge entfernen:

```text
.unlearn <SPELL-ID> all
```

## Alle Trainerzauber der eigenen Klasse lernen

```text
.learn all my trainer
```

Das ist meist die sinnvollste Komfortvariante, wenn Trainerbesuche übersprungen werden sollen.

## Alle normalen Klassensprüche lernen

```text
.learn all my spells
```

Lernt alle für die Klasse verfügbaren Zauber, ausgenommen bestimmte Talentzauber.

## Alle Klassentalente lernen

```text
.learn all my talents
```

**Sehr mächtig:** Lernt Talente und Talentzauber weit über die regulär verfügbaren Talentpunkte hinaus.

## Alle Klassenzauber und Talente lernen

```text
.learn all my class
```

Für normales Leveln nicht empfohlen, weil Progression und Talentwahl praktisch entfallen.

## Alle questgebundenen Klassensprüche lernen

```text
.learn all my quest
```

## Alle Sprachen lernen

```text
.learn all lang
```

## Aura entfernen

```text
.unaura <SPELL-ID>
```

Entfernt die durch den angegebenen Zauber verursachte Aura vom Ziel.

---

# 10. Berufe und Skills

## Skill suchen

```text
.lookup skill <SUCHTEXT>
```

## Skillwert setzen

```text
.setskill <SKILL-ID> <AKTUELLER-WERT> [MAXIMALWERT]
```

Beispiel:

```text
.setskill 171 300 300
```

Die ID `171` steht in WotLK üblicherweise für Alchemie; vor Verwendung mit `.lookup skill` prüfen.

## Alle Rezepte eines Berufs lernen

```text
.learn all recipes <BERUF>
```

Beispiel:

```text
.learn all recipes enchanting
```

Lernt alle Rezepte des Berufs und setzt den Skill laut AzerothCore auf Maximum.

## Alle Berufe und Rezepte lernen

```text
.learn crafts
```

**Sehr umfassend:** Für einen normalen Singleplayer-Charakter meist zu viel. Besser gezielt einen Beruf verwenden.

---

# 11. Quests reparieren oder überspringen

## Quest suchen

```text
.lookup quest <SUCHTEXT>
```

## Quest zum Log hinzufügen

```text
.quest add <QUEST-ID>
```

Quests, die durch einen Gegenstand gestartet werden, können gegebenenfalls nicht direkt hinzugefügt werden; der Server nennt dann oft den passenden `.additem`-Befehl.

## Questziele als erfüllt markieren

```text
.quest complete <QUEST-ID>
```

Markiert die Ziele als abgeschlossen. Die Quest muss normalerweise anschließend noch regulär abgegeben werden.

## Quest direkt belohnen

```text
.quest reward <QUEST-ID>
```

Gewährt die Questbelohnung und entfernt die Quest aus dem Log. Die Quest muss zuvor als abgeschlossen gelten.

## Quest entfernen und zurücksetzen

```text
.quest remove <QUEST-ID>
```

Entfernt die Quest aus dem Log und setzt sie auf nicht aktiv/nicht abgeschlossen.

## Queststatus prüfen

```text
.quest status <QUEST-ID>
```

## Zum Queststarter springen

```text
.go quest starter <QUEST-ID>
```

## Zur Questabgabe springen

```text
.go quest ender <QUEST-ID>
```

### Bewährter Ablauf bei einer verbuggten Quest

```text
.lookup quest <Name>
.quest status <ID>
.quest complete <ID>
.go quest ender <ID>
```

Falls die normale Abgabe ebenfalls nicht funktioniert:

```text
.quest reward <ID>
```

---

# 12. Karte und Gebiete

## Gebiet suchen

```text
.lookup area <SUCHTEXT>
```

## Gebiet aufdecken

```text
.showarea <AREA-ID>
```

## Gebiet wieder verbergen

```text
.hidearea <AREA-ID>
```

## Gesamte Weltkarte aufdecken

```text
.cheat explore 1
```

## Karten-Teleport aus eurem PrivateWoWAdmin-Addon

Nach Installation des entsprechenden Features:

```text
M öffnen
Strg + Linksklick auf die Gebietskarte
```

Das Addon sucht den nächstgelegenen bekannten Eintrag aus `game_tele` und führt `.tele <Name>` aus.

Status prüfen:

```text
/pwamaptele
```

---

# 13. NPCs untersuchen und verwalten

> Viele NPC-Befehle verändern dauerhaft die Welt-Datenbank. Vor dauerhaften Änderungen ein Datenbank-Backup anlegen.

## NPC-Informationen anzeigen

NPC auswählen und:

```text
.npc info
```

Zeigt unter anderem Entry-ID, GUID, Modell, Fraktion, Level, Lebenspunkte und Position.

## NPC-GUID anzeigen

```text
.npc guid
```

## Nahe NPC-Spawns suchen

```text
.npc near <DISTANZ>
```

Beispiel:

```text
.npc near 50
```

## NPC zu dir holen

```text
.cometome
```

Verschiebt die ausgewählte Kreatur temporär zu deiner Position. Die neue Position wird nicht dauerhaft gespeichert.

## NPC dauerhaft zu deiner Position verschieben

```text
.npc move
```

Verschiebt den Spawnpunkt der ausgewählten Kreatur auf deine Position.

## NPC folgen lassen

```text
.npc follow
```

## Folgen beenden

```text
.npc follow stop
```

## NPC temporär erzeugen

```text
.npc add temp <CREATURE-ID>
```

Die genaue Syntax kann je nach Build variieren; vorher verwenden:

```text
.help npc add temp
```

## NPC dauerhaft erzeugen

```text
.npc add <CREATURE-ID>
```

Erzeugt einen dauerhaften Spawn in der Datenbank.

## NPC dauerhaft löschen

```text
.npc delete
```

**Gefährlich:** Löscht die ausgewählte Kreatur beziehungsweise deren Spawn aus der Datenbank.

## NPC respawnen

```text
.respawn
```

Mit ausgewähltem NPC wird dieser ohne normale Wartezeit respawnt.

---

# 14. GameObjects untersuchen

GameObjects sind beispielsweise Türen, Truhen, Hebel und andere Weltobjekte.

## Informationen anzeigen

```text
.gobject info
```

Mit ausgewähltem Objekt werden Entry- und Spawninformationen angezeigt.

## Objekt aktivieren

```text
.gobject activate <GUID>
```

Betätigt beispielsweise eine Tür oder einen Schalter.

## Objekt dauerhaft erzeugen

```text
.gobject add <ENTRY-ID>
```

## Objekt verschieben

```text
.gobject move <GUID>
```

Ohne Koordinaten wird das Objekt üblicherweise an deine Position verschoben.

## Objekt dauerhaft löschen

```text
.gobject delete <GUID>
```

**Gefährlich:** Löscht den Spawn aus der Datenbank.

---

# 15. Gruppe und NPCBots

Die folgenden Standardbefehle helfen auch bei Gruppen mit Bots. Zusätzliche NPCBot-Befehle hängen vom installierten NPCBots-Modul ab und sind nicht Teil der allgemeinen AzerothCore-GM-Liste.

## Gruppe anzeigen

```text
.group list
```

## Charakter einer Gruppe hinzufügen

```text
.group join <NAME-EINES-GRUPPENMITGLIEDS> [CHARAKTERNAME]
```

## Gruppenleiter setzen

```text
.group leader <CHARAKTERNAME>
```

## Charakter aus der Gruppe entfernen

```text
.group remove <CHARAKTERNAME>
```

## Gruppe auflösen

```text
.group disband
```

## Gruppe zu dir teleportieren

```text
.groupsummon
```

Je nach Build kann ein Charaktername angegeben werden.

## Gruppe wiederbeleben

```text
.group revive
```

Für die eigentliche NPCBot-Verwaltung besser die Buttons und Befehle des installierten `mod-npcbots` beziehungsweise eures `PrivateWoWAdmin`-Addons verwenden.

---

# 16. Reittiere, Haustiere und Optik

## Ausgewählte Kreatur als Jägerpet übernehmen

```text
.pet create
```

Erstellt aus der ausgewählten geeigneten Kreatur ein Pet.

## Gespeicherte Pets auflisten

```text
.pet list <CHARAKTERNAME>
```

## Pet einen Zauber lernen lassen

```text
.pet learn <SPELL-ID>
```

Die offizielle Befehlsseite enthält bei einigen Pet-Befehlen verkürzte oder uneinheitliche Syntax. Vor Verwendung immer prüfen:

```text
.help pet learn
```

## Modell des eigenen Charakters ändern

```text
.morph <DISPLAY-ID>
```

## Modell des Ziels ändern

```text
.morph target <DISPLAY-ID>
```

## Ursprüngliches Modell wiederherstellen

```text
.morph reset
```

Optische Morphs können nach Relog oder bestimmten Zustandsänderungen verschwinden.

## Geschlecht ändern

```text
.modify gender male
.modify gender female
```

---

# 17. Events und Weltzustände

## Aktive Events anzeigen

```text
.event activelist
```

## Event suchen beziehungsweise Informationen anzeigen

```text
.event <EVENT-ID>
.event info <EVENT-ID>
```

## Event temporär starten

```text
.event start <EVENT-ID>
```

## Event temporär stoppen

```text
.event stop <EVENT-ID>
```

Diese Änderungen werden laut AzerothCore nicht zwingend dauerhaft in der Datenbank gespeichert.

---

# 18. Charakter- und Serverpflege

## Charakterinformationen anzeigen

```text
.pinfo
```

Zeigt Informationen zum ausgewählten Charakter beziehungsweise Account.

## Charakter-GUID anzeigen

```text
.guid
```

## Charakter umbenennen lassen

```text
.character rename <CHARAKTERNAME>
```

Markiert den Charakter zur Umbenennung beim nächsten Login.

## Charakter-Dump sichern

In der Worldserver-Konsole:

```text
pdump write <DATEINAME> <CHARAKTERNAME-ODER-GUID>
```

Beispiel:

```text
pdump write Jens_Backup Jens
```

Der genaue Ablageort hängt von der Worldserver-Arbeitsumgebung ab.

## Charakter-Dump laden

```text
pdump load <DATEINAME> <ACCOUNTNAME> [NEUER-NAME] [NEUE-GUID]
```

Vorher Datenbank sichern und `.help pdump load` prüfen.

## Server sauber herunterfahren

```text
.server shutdown <SEKUNDEN>
```

Beispiel:

```text
.server shutdown 10
```

## Geplantes Herunterfahren abbrechen

Je nach AzerothCore-Build:

```text
.server shutdown cancel
```

Vorher prüfen:

```text
.help server shutdown
```

---

# 19. Besonders gefährliche Befehle

Diese Befehle sind für normales Singleplayer-Spielen fast nie notwendig:

```text
.reset items all
.reset items allbags
.reset items bags
.reset items bank
.reset level
.character erase
.account delete
.npc delete
.gobject delete
```

Risiken:

- dauerhaft gelöschte Ausrüstung
- entfernte Taschen samt Inhalt
- verlorene Bankgegenstände
- gelöschte Charaktere
- gelöschte Welt-Spawns
- Inkonsistenzen nach manuellen Änderungen

Vor solchen Befehlen:

1. `.save`
2. Server sauber beenden
3. Charakter- oder Datenbank-Backup erstellen
4. Syntax mit `.help` prüfen
5. Zielauswahl kontrollieren

---

# 20. Praktische Singleplayer-Kombinationen

## Sicher erkunden

```text
/cleartarget
.gm on
.cheat god on
.gm fly on
.modify speed fly 3
.cheat explore 1
```

Zurücksetzen:

```text
.modify speed fly 1
.gm fly off
.cheat god off
```

## Schwierigen Boss allein testen

```text
/cleartarget
.cheat god on
.cheat power on
.cheat cooldown on
```

Optional:

```text
.cheat casttime on
```

Nach dem Kampf:

```text
.cheat casttime off
.cheat cooldown off
.cheat power off
.cheat god off
```

## Verbuggte Quest abschließen

```text
.lookup quest <QUESTNAME>
.quest status <QUEST-ID>
.quest complete <QUEST-ID>
.go quest ender <QUEST-ID>
```

Falls keine reguläre Abgabe möglich ist:

```text
.quest reward <QUEST-ID>
```

## Fehlendes Item beschaffen

```text
.lookup item <ITEMNAME>
.additem <ITEM-ID> <ANZAHL>
```

## Fehlenden Zauber lernen

```text
.lookup spell <ZAUBERNAME>
.learn <SPELL-ID>
```

## Nach Experimenten aufräumen

```text
/cleartarget
.modify speed 1
.modify speed fly 1
.modify scale 1
.gm fly off
.cheat casttime off
.cheat cooldown off
.cheat power off
.cheat god off
.cheat waterwalk off
.cheat status
.save
```

---

# 21. Eigene Makros

## Geschwindigkeit 1x → 2x → 3x

```text
#showtooltip
/cleartarget
/run pwaSpeed=(pwaSpeed or 1)%3+1;SendChatMessage(".modify speed "..pwaSpeed,"SAY");print("Laufspeed: "..pwaSpeed.."x")
```

## God Mode einschalten

```text
/cleartarget
/s .cheat god on
```

## Komfort-Cheats einschalten

```text
/cleartarget
/s .cheat god on
/s .cheat power on
/s .cheat cooldown on
```

WoW-Makros haben ein Zeichenlimit. Größere Umschaltlogik ist im `PrivateWoWAdmin`-Addon zuverlässiger aufgehoben.

---

# 22. Quellen und Verifikation

Primärquelle:

- AzerothCore GM Commands:  
  https://www.azerothcore.org/wiki/gm-commands

Account- und GM-Level-Einrichtung:

- AzerothCore – Creating Accounts:  
  https://www.azerothcore.org/wiki/creating-accounts

Wichtiger Hinweis:

AzerothCore, Module wie `mod-npcbots` und eure lokale Serverversion können unterschiedliche Befehle oder Syntaxvarianten enthalten. Die verbindliche Auskunft für **deinen laufenden Server** liefert immer:

```text
.commands
.help <Befehl>
```

Die Tabelle `world.command` kann außerdem Sicherheitsstufen und Hilfetexte überschreiben, erzeugt aber keine neuen Serverbefehle.
