# WoW 3.3.5a Raid-Gear-Workflow
## HowTo für neue Klassen / Skillungen

Dieses Dokument beschreibt den bewährten Workflow für zukünftige Gear-Optimierungen auf dem privaten **AzerothCore 3.3.5a**-Server.

Ziel: Für eine neue Klasse oder Skillung schnell und reproduzierbar Raid-Gear-Sets für **Level 60, 70 und 80** erstellen.

Beispiele:

- Paladin Vergeltung / Retribution
- Magier Frost
- Krieger Fury
- Jäger
- Priester Schatten
- usw.

---

# 1. Grundprinzip

Nicht einfach historische Vanilla-/TBC-/WotLK-BiS-Listen übernehmen.

Stattdessen:

1. lokale `item_template`-Datenbank als technische Wahrheit für verfügbare Items nutzen
2. die tatsächlichen **WoW-3.3.5a-Mechaniken** der gewünschten Skillung berücksichtigen
3. Raidboss-Caps wie Hit, Expertise usw. auf dem jeweiligen Charakterlevel berechnen
4. starke historische BiS-Items nur als Kandidaten betrachten
5. Setboni bewusst bewerten
6. interne/Test-/Deprecated-Items ausschließen
7. ungewöhnliche Items mit niedrigem `RequiredLevel` kritisch prüfen
8. anschließend pro Level eine kompakte Markdown-Referenz erstellen

Ziel ist ein:

```text
robustes Raid-Killer-Set
```

und nicht zwingend ein historisch authentisches Progression-Set.

---

# 2. Server / Datenbank

World-Datenbank:

```text
acore_npcbots_world
```

Wichtige Tabelle:

```text
item_template
```

MySQL-Aufruf:

```powershell
mysql.exe -u root -p acore_npcbots_world
```

oder für einen SQL-Export:

```powershell
mysql.exe -u root -p acore_npcbots_world -e "SOURCE C:/Temp/<datei>.sql" > C:\Temp\<datei>.txt
```

Passwort manuell eingeben.

---

# 3. Arbeitsablauf für eine neue Klasse / Skillung

Dem Chat reichen zu Beginn ungefähr:

```text
Klasse: Paladin
Skillung: Retribution
Ziel: Raid-DPS
Level: 60, 70, 80
```

Zusätzliche Einschränkungen nur nennen, wenn gewünscht, z. B.:

```text
nur Plate
keine PvP-Items
keine ungewöhnlichen Expansion-Items
historisch möglichst authentisch
kein Spellhance / keine exotischen Builds
```

Wenn nichts anderes gesagt wird, gilt:

```text
maximal sinnvoller Boss-DPS unter 3.3.5a-Regeln
```

---

# 4. Der Chat liefert zuerst SQL-Dumps

Für jede neue Klasse/Skillung sollte der Chat nicht sofort eine endgültige BiS-Liste erfinden.

Stattdessen liefert er passende SQL-Abfragen für:

```text
Level 60
Level 70
Level 80
```

Die Abfrage wird auf die Skillung zugeschnitten.

Beispiele für relevante Stats:

## Melee

```text
Agility
Strength
Intellect
Hit
Crit
Haste
Expertise
Attack Power
Armor Penetration
Weapon Speed
```

## Caster

```text
Intellect
Hit
Crit
Haste
Spell Power
Spirit, falls relevant
MP5, falls relevant
```

## Tanks

```text
Stamina
Defense
Dodge
Parry
Block
Hit
Expertise
Armor
```

Die SQL sollte außerdem enthalten:

```text
entry
name
class
subclass
InventoryType
Quality
ItemLevel
RequiredLevel
AllowableClass
AllowableRace
RequiredSkill
RequiredSkillRank
spellid_1 ... spellid_5
socketColor_1 ... socketColor_3
delay
```

---

# 5. Wichtige 3.3.5a-stat_type-Werte

Häufig relevant:

```text
3  = Agility
4  = Strength
5  = Intellect
7  = Stamina

12 = Defense Rating
13 = Dodge Rating
14 = Parry Rating
15 = Block Rating

16 = Melee Hit Rating
18 = Spell Hit Rating

19 = Melee Crit Rating
21 = Spell Crit Rating

31 = Hit Rating
32 = Crit Rating

35 = Resilience
36 = Haste Rating
37 = Expertise Rating
38 = Attack Power
43 = MP5
44 = Armor Penetration
45 = Spell Power
47 = Spell Penetration
48 = Block Value
```

Bei älteren Classic-/TBC-Items können wichtige Stats zusätzlich über:

```text
spellid_1 ... spellid_5
```

als passive Equip-Auren hinterlegt sein.

Deshalb niemals nur die direkten `stat_type`-Spalten betrachten.

---

# 6. SQL-Filter

Bewährte Grundfilter:

```sql
Quality >= 3
```

oder bei sehr großen Datenmengen:

```sql
Quality >= 4
```

Aber Vorsicht:

Einige sehr starke Classic-Items sind nur `Rare`.

Darum bei Level 60 im Zweifel lieber:

```text
Quality >= 3
```

verwenden.

Typische Ausschlüsse:

```sql
name NOT LIKE '%TEST%'
name NOT LIKE '%DEPRECATED%'
name NOT LIKE 'Tom''s %'
name NOT LIKE '%PH%'
```

Zusätzlich ungewöhnliche Items später manuell prüfen.

---

# 7. RequiredLevel nicht zu eng filtern

Nicht nur:

```text
RequiredLevel 58-60
```

oder:

```text
RequiredLevel 68-70
```

verwenden.

Besser:

```text
RequiredLevel <= Ziellevel
```

plus sinnvolles `ItemLevel`-Minimum.

Grund:

Unter 3.3.5a existieren Items aus späteren Erweiterungen oder Sonderquellen mit ungewöhnlich niedrigem `RequiredLevel`.

Diese können technisch tragbar sein und müssen zumindest gesehen und anschließend fachlich bewertet werden.

---

# 8. Kandidaten kritisch prüfen

Nicht jedes technisch tragbare Item soll automatisch verwendet werden.

Ausschließen oder zumindest hinterfragen:

```text
TEST-Items
PH / Placeholder
Developer-Items
Arena-/PvP-Items, falls PvE deutlich sinnvoller ist
ICC-Rufitems mit absurdem niedrigem RequiredLevel
Items mit falscher Klassen-/Skill-Anforderung
offensichtliche DB-Anomalien
```

Beispiel aus der Schamanen-Analyse:

Ein Ashen-Band-Ring mit sehr niedrigem `RequiredLevel` darf nicht automatisch zum Level-60-BiS erklärt werden.

---

# 9. Caps zuerst bestimmen

Vor der eigentlichen Item-Auswahl immer zuerst die wichtigen Caps bestimmen.

Beispiele:

## Caster

```text
Spell Hit gegen Raidboss
Talent-Hit
Racial-Hit
Raid-Debuffs
```

## Melee

```text
Special Hit
Spell Hit bei Hybridklassen
Expertise / Dodge-Cap
ggf. Armor Penetration
```

## Tank

```text
Defense-Cap
Hit
Expertise
Block/Dodge/Parry
```

Dabei immer auf das jeweilige Level achten:

```text
Level 60
Level 70
Level 80
```

Rating-Konvertierungen unterscheiden sich deutlich.

---

# 10. Keine Raid-Unterstützung voraussetzen

Standardmäßig robuste Sets bauen.

Also nicht automatisch voraussetzen:

```text
Draenei Heroic Presence
Misery
Improved Faerie Fire
bestimmte Raid-Auren
perfekte Debuff-Abdeckung
```

Solche Varianten können als optionale Alternative dokumentiert werden.

Das Hauptset soll aber auch ohne perfekte Raid-Komposition funktionieren.

---

# 11. Setboni bewusst bewerten

Nicht nur einzelne Items vergleichen.

Gerade bei:

```text
T3
T4
T5
T6
T7
T8
T9
T10
```

kann ein Setbonus stärker sein als ein nominell besseres Offpiece.

Darum immer prüfen:

```text
2er Bonus
4er Bonus
ggf. 5er/8er bei alten Sets
```

und dann das Gesamtset optimieren.

---

# 12. Waffen separat bewerten

Bei Melee niemals nur ItemLevel vergleichen.

Berücksichtigen:

```text
Weapon Speed
Top-End Damage
Mainhand / Offhand
Dual-Wield-Mechanik
Proc
Hit
Expertise
AP
Spell Power bei Hybridklassen
```

Bei Castern:

```text
Mainhand + Offhand
Staff
Shield
Spell Power
Hit
Haste
Crit
```

Bei ungewöhnlichen Specs ausdrücklich prüfen, ob z. B. eine Caster-Waffe fachlich sinnvoll sein kann.

---

# 13. Gems und Enchants erst nach dem Grundset

Workflow:

```text
1. starkes Grundset wählen
2. Caps ausrechnen
3. fehlendes Hit / Expertise usw. über Gems und Enchants ergänzen
4. Overcap möglichst klein halten
5. restliche Sockel auf reine DPS-Stats optimieren
```

Nicht andersherum.

Starke Items sollten nicht unnötig gegen deutlich schwächere Hit-Items getauscht werden, wenn Gems/Enchants das Cap sauber lösen können.

---

# 14. WotLK-Gems / Enchants auf niedrigeren Levels

Da der Server WoW 3.3.5a verwendet und Items per GM hinzugefügt werden, können je nach technischer Anforderung auch WotLK-Gems und -Enchants auf Level 60/70 interessant sein.

Vor Verwendung prüfen:

```text
Character-Level-Anforderung
Item-Level-Anforderung
Slot
```

Wenn technisch erlaubt, dürfen sie für dieses Projekt verwendet werden.

Falls historische Authentizität gewünscht ist, vorher ausdrücklich sagen:

```text
nur expansion-pure Gems/Enchants
```

---

# 15. Ausgabeformat

Für jede Klasse/Skillung bevorzugt **eine Datei pro Level**:

```text
<Klasse>-L60.md
<Klasse>-L70.md
<Klasse>-L80.md
```

Beispiel:

```text
Paladin-Retri-L60.md
Paladin-Retri-L70.md
Paladin-Retri-L80.md
```

Oder bei mehreren Skillungen derselben Klasse:

```text
Paladin-L60.md
Paladin-L70.md
Paladin-L80.md
```

und darin getrennte Kapitel.

---

# 16. Inhalt jeder Markdown-Datei

Jede Datei sollte enthalten:

```text
Ziel / Annahmen
wichtige Caps
empfohlenes Set als Tabelle
ItemIDs
Hit-/Expertise-/sonstige Cap-Rechnung
Waffenwahl
Gems
wichtige Enchants
Alternativen / Fallbacks
auffällige DB-Sonderfälle
GM-.additem-Block
Kurzfassung
```

---

# 17. GM-Block

Immer zusätzlich:

```text
.additem <ID>
```

für alle Items.

Beispiel:

```text
.additem 51242
.additem 50633
.additem 54583
...
```

Gems separat:

```text
.additem <GemID> <Anzahl>
```

---

# 18. Was der Nutzer zukünftig liefern muss

Minimaler Workflow:

### Schritt 1

Neue Klasse/Skillung nennen:

```text
Jetzt bitte Paladin Retribution für Level 60/70/80.
Nutze den WoW-Gear-Workflow aus der README.
```

### Schritt 2

Chat liefert SQL.

### Schritt 3

SQL lokal ausführen:

```powershell
mysql.exe -u root -p acore_npcbots_world -e "SOURCE C:/Temp/<sql>.sql" > C:\Temp\<dump>.txt
```

### Schritt 4

TXT-Datei hochladen.

### Schritt 5

Chat analysiert:

```text
lokale DB
3.3.5a-Klassenmechanik
Caps
Setboni
Waffen
Gems
Enchants
```

und erstellt die fertigen `.md`-Dateien.

---

# 19. Wann zusätzliche SQL-Abfragen nötig sind

Normalerweise sollte ein gut gebauter gemeinsamer Dump reichen.

Zusätzliche Abfragen nur, wenn:

```text
ein wichtiges Item im Dump fehlt
ein Spell-Effekt unklar ist
RequiredSkill/RequiredSpell geprüft werden muss
ein Item ungewöhnliche Einschränkungen besitzt
Setboni oder SpellIDs lokal verifiziert werden müssen
```

Dann nur eine kleine gezielte SQL-Nachabfrage statt erneut die ganze DB auszulesen.

---

# 20. Arbeitsregel für den Chat

Bei zukünftigen Klassen gilt:

```text
Nicht vorschnell "BiS" behaupten.
Erst lokale DB + Mechanik + Caps prüfen.
```

Wenn Daten fehlen:

```text
gezielte SQL-Abfrage liefern
```

statt zu raten.

Wenn ein historisches BiS-Item unter 3.3.5a nicht mehr optimal ist, darf davon abgewichen werden.

Das Hauptziel bleibt:

```text
maximal sinnvoller und zuverlässiger Raid-DPS
unter den tatsächlichen Regeln des privaten 3.3.5a-Servers.
```

---

# Kurzversion für einen neuen Chat

Folgender Startprompt reicht zusammen mit dieser README:

```text
Wir optimieren wieder Raid-Gear für meinen privaten AzerothCore-3.3.5a-Server.

Klasse: <Klasse>
Skillung: <Skillung>
Level: 60, 70 und 80
Ziel: möglichst hoher und robuster Boss-DPS.

Nutze den Workflow aus der beigefügten WoW-3.3.5a-Raid-Gear-README.

Gib mir zuerst die notwendigen SQL-Abfragen für meine lokale
acore_npcbots_world.item_template.

Ich führe sie aus und lade dir die TXT-Dumps hoch.
Danach erstellst du die finalen Markdown-Gear-Dateien mit ItemIDs,
Caps, Gems, Enchants, Waffenwahl und .additem-Blöcken.
```
