# Schamane Level 60 – Raid-DPS-Set
## WoW 3.3.5a / AzerothCore

Ziel: **möglichst zuverlässiger und hoher Schaden gegen Raidbosse** auf Charakterlevel 60.

Diese Liste ist absichtlich **keine historische Vanilla-BiS-Liste**. Die Items stammen überwiegend aus Classic-Endgame (BWL/AQ40/Naxxramas 60), bewertet werden sie aber unter **WoW-3.3.5a-Mechanik**.

Wichtige Annahmen:

- Skillung: **Elementar**
- 3/3 `Elemental Precision`
- keine Draenei-Hit-Aura vorausgesetzt
- kein `Misery` / `Improved Faerie Fire` vorausgesetzt
- Cloth/Leather/Mail sind erlaubt; in 3.3.5a gibt es noch keinen Cataclysm-Rüstungs-Spezialisierungsbonus
- Ziel ist Boss-DPS, nicht Vanilla-Authentizität
- WotLK-Enchants auf Level-60-Gegenständen sind für dieses private GM-Setup erlaubt

---

# Elementar

## 1. Hit-Ziel

Gegen einen Raidboss (+3 Level) gilt:

```text
17 % Spell Hit insgesamt
-3 % Elemental Precision
-------------------------
14 % aus Ausrüstung / Enchants
```

Auf Level 60 entspricht 1 % Spell Hit ungefähr **8 Hit Rating**.

Damit lautet unser Ziel:

```text
14 x 8 = 112 Hit Rating
```

Die unten gewählte Ausrüstung liefert unter 3.3.5a insgesamt ungefähr:

```text
88 Hit Rating aus Gear
```

Mit den beiden WotLK-Enchants:

```text
Gloves: Precision   +20 Hit
Boots:  Icewalker   +12 Hit
```

ergibt sich:

```text
88 Gear
+20 Precision
+12 Icewalker
--------------
120 Hit Rating
```

Wir liegen damit **8 Rating / etwa 1 % über dem benötigten Gear-Cap**.

Das ist für einen robusten Raid-Killer völlig in Ordnung. Vor allem vermeiden wir dadurch, starke Spell-Power-Items nur für ein mathematisch perfektes Hit-Cap auszutauschen.

---

# 2. Empfohlenes Raid-Set

| Slot | Item | ItemID | Hit | Bewertung |
|---|---|---:|---:|---|
| Kopf | Mish'undare, Circlet of the Mind Flayer | `19375` | 0 | sehr viel Spell Power + Crit |
| Hals | Amulet of Vek'nilash | `21608` | 0 | starker Caster-Hals |
| Schultern | Pauldrons of Elemental Fury | `23664` | 8 | speziell sehr stark für Elementar |
| Rücken | Cloak of the Necropolis | `23050` | 8 | Spell Power + Crit + Hit |
| Brust | Garb of Royal Ascension | `21838` | 16 | hoher Spell Power und viel Hit |
| Handgelenke | Rockfury Bracers | `21186` | 8 | +27 SP und Hit; Rare statt Epic |
| Hände | Dark Storm Gauntlets | `21585` | 8 | sehr hoher Spell Power + Hit |
| Gürtel | Eyestalk Waist Cord | `22730` | 0 | extrem hoher Spell Power |
| Beine | Leggings of Polarity | `23070` | 0 | sehr viel Spell Power + Crit |
| Füße | Boots of Epiphany | `21600` | 0 | hoher Spell Power |
| Ring 1 | Ring of the Fallen God | `21709` | 8 | Spell Power + Hit |
| Ring 2 | Band of the Inevitable | `23031` | 8 | Spell Power + Hit |
| Trinket 1 | Neltharion's Tear | `19379` | 16 | +44 SP und viel Hit |
| Trinket 2 | The Restrained Essence of Sapphiron | `23046` | 0 | starker permanenter SP-Bonus + On-Use |
| Mainhand | The End of Dreams | `22988` | 0 | sehr hoher Spell Power |
| Offhand | Sapphiron's Left Eye | `23049` | 8 | SP + Crit + Hit |
| Relikt | Totem of the Storm | `23199` | 0 | +33 Spell Power für Lightning Bolt / Chain Lightning |

### Hit-Summe des Sets

```text
Pauldrons of Elemental Fury       8
Cloak of the Necropolis          8
Garb of Royal Ascension         16
Rockfury Bracers                 8
Dark Storm Gauntlets             8
Ring of the Fallen God           8
Band of the Inevitable           8
Neltharion's Tear               16
Sapphiron's Left Eye             8
----------------------------------
Gear gesamt                     88
```

---

# 3. Hit-Enchants

## Handschuhe

**Enchant Gloves – Precision**

```text
+20 Hit Rating
```

## Schuhe

**Enchant Boots – Icewalker**

```text
+12 Hit Rating
+12 Critical Strike Rating
```

Danach:

```text
120 Hit Rating aus Gear + Enchants
= 15 % Hit auf Level 60

+ 3 % Elemental Precision
= 18 % Gesamt-Hit
```

Benötigt werden gegen den Boss 17 %.

### Warum nicht Accuracy auf die Waffe?

`Enchant Weapon – Accuracy` liefert zwar:

```text
+25 Hit
+25 Crit
```

und würde das Hit-Cap sehr elegant treffen.

Auf `The End of Dreams` möchten wir aber lieber einen starken **Spell-Power-Waffen-Enchant** verwenden. Für einen Elementar-Schamanen ist es deshalb sinnvoller, Hit auf Handschuhe und Schuhe zu verlagern.

---

# 4. Spell-Power-Schwerpunkt

Die gewählten Items bringen grob **über 600 Spell Power bereits aus dem Gear**, noch bevor weitere passende Enchants hinzukommen.

Besonders starke Einzelteile sind:

```text
The End of Dreams               ~95 SP
Leggings of Polarity            ~44 SP
Neltharion's Tear               ~44 SP
Eyestalk Waist Cord             ~41 SP
The Restrained Essence          ~40 SP
Dark Storm Gauntlets            ~37 SP
Ring of the Fallen God          ~37 SP
Band of the Inevitable          ~36 SP
Mish'undare                     ~35 SP
Boots of Epiphany               ~34 SP
```

Dazu kommt das `Totem of the Storm`, das Lightning Bolt und Chain Lightning separat verstärkt.

---

# 5. Trinkets

## Standard / zuverlässig

### Neltharion's Tear – `19379`

Für dieses Setup nahezu perfekt:

```text
+44 Spell Power
+16 Hit Rating
```

Das Hit ist gerade auf Level 60 enorm wertvoll.

### The Restrained Essence of Sapphiron – `23046`

Als zweites Standardtrinket gewählt, weil es zuverlässigen Caster-DPS liefert und zusätzlich einen starken aktivierbaren Spell-Power-Effekt besitzt.

## Burst-Alternative

### Natural Alignment Crystal – `19344`

Schamanen-spezifisches Burst-Trinket.

Das kann bei kurzen Bossphasen sehr interessant sein. Für die Hauptliste nehme ich trotzdem `The Restrained Essence of Sapphiron`, weil wir ein unkompliziertes und verlässliches Raid-Killer-Set bauen und der genaue Effekt des Natural Alignment Crystal zwischen den verschiedenen WoW-Epochen mehrfach geändert wurde.

---

# 6. Warum kein komplettes Earthshatter-T3?

Obwohl die `Earthshatter`-Teile aus Naxxramas hohe Itemlevel besitzen, ist das komplette T3-Set **nicht als Elementar-DPS-Set itemisiert**.

Darum gewinnen einzelne echte Caster-/Elementar-Items deutlich:

```text
Mish'undare
Pauldrons of Elemental Fury
Garb of Royal Ascension
Dark Storm Gauntlets
Leggings of Polarity
...
```

Hoher Itemlevel allein ist hier kein sinnvolles Auswahlkriterium.

---

# 7. Warum Rockfury Bracers und Totem of the Storm nicht im ursprünglichen SQL-Dump standen

Die SQL-Abfrage hat absichtlich nur:

```text
Quality >= 4
```

geladen, also Epic oder höher.

Zwei sehr gute Level-60-Elementar-Items sind jedoch **Rare**:

```text
Rockfury Bracers   21186
Totem of the Storm 23199
```

Darum tauchten sie nicht in `elemental60.txt` auf.

Das ist kein Problem des Servers oder der Items, sondern nur eine Folge unseres ersten Filters.

---

# 8. 3.3.5a-Sonderfall: Ashen-Band-Ringe

Die lokale 3.3.5a-Datenbank enthält außerdem die ICC-Rufringe:

```text
52569 Ashen Band of Might
52570 Ashen Band of Greater Might
52571 Ashen Band of Unmatched Might
52572 Ashen Band of Endless Might
```

Einige davon haben technisch `RequiredLevel = 1` und könnten deshalb bei einer rein mathematischen SQL-Suche wie Level-60-Items aussehen.

**Sie werden bewusst NICHT für dieses Set verwendet.**

Grund:

- ICC-/Ashen-Verdict-Gegenstände
- Reputation-Anforderung
- für physische Strength-DPS itemisiert
- offensichtlich kein sinnvoller Level-60-Elementar-Gegenstand

Wir optimieren stark, aber nicht mit solchen Datenbank-/Expansion-Anomalien.

---

# 9. GM-Block – Level 60 Elementar

```text
.additem 19375
.additem 21608
.additem 23664
.additem 23050
.additem 21838
.additem 21186
.additem 21585
.additem 22730
.additem 23070
.additem 21600
.additem 21709
.additem 23031
.additem 19379
.additem 23046
.additem 22988
.additem 23049
.additem 23199
```

---

# 10. Kurzfassung

```text
Skillung:        Elementar
Charakterlevel:  60
Bossziel:        Level 63

Gear Hit:        ~88 Rating
Precision:       +20
Icewalker:       +12
----------------------
Hit gesamt:      ~120 Rating

Gear-Hit:        ~15 %
Talent-Hit:       +3 %
Gesamt:          ~18 %

Boss-Cap:         17 %
```

Damit ist der Schamane beim Treffen des Bosses auf der sicheren Seite und behält gleichzeitig sehr starke Classic-Endgame-Caster-Items.

---

# 11. Status

- [x] Level-60-Elementar-Kandidaten aus lokaler AzerothCore-DB ausgewertet
- [x] Classic-Endgame-BiS als Ausgangspunkt geprüft
- [x] 3.3.5a-Hitmechanik berücksichtigt
- [x] Rare-Ausnahmen ergänzt
- [x] Hit-Cap über Enchants hergestellt
- [x] ItemIDs dokumentiert
- [x] `.additem`-Block erstellt
- [ ] optional später: sämtliche Enchants als eigene GM-/Enchant-Befehlsliste
- [ ] Level-60-Verstärker nur bei Bedarf ergänzen

# Verstärker

## Ziel

Level-60-Enhancement unter **WoW 3.3.5a** ist ein Sonderfall: Wir tragen überwiegend Classic-/frühe-TBC-Gegenstände, benutzen aber bereits die WotLK-Enhancement-Mechanik mit Dual Wield, Spell-Hit und Expertise.

Für dieses Set gelten weiterhin:

- Raidboss = Level 63
- keine Draenei-Hit-Aura vorausgesetzt
- keine fremden Spell-Hit-Debuffs vorausgesetzt
- Angriff von hinten
- WotLK-Gems und -Enchants sind für dieses private GM-Setup erlaubt
- kein Versuch, den White-Dual-Wield-Hitcap zu erreichen

---

## 1. Caps auf Level 60

### Spell Hit

Enhancement verursacht einen relevanten Teil seines Schadens über Zauber (Shocks, Lightning Bolt über Maelstrom Weapon usw.).

Gegen einen +3-Boss benötigen wir:

```text
17 % Spell Hit
```

Auf Level 60:

```text
8 Hit Rating = 1 % Spell Hit
17 x 8 = 136 Hit Rating
```

Das ist unser robustes Hit-Ziel.

### Expertise / Waffenkunde

Ein Raidboss kann Angriffe von hinten um 6,5 % ausweichen.

Dafür benötigen wir:

```text
26 Expertise
```

Auf Level 60:

```text
2,5 Expertise Rating = 1 Expertise
26 x 2,5 = 65 Expertise Rating
```

Ziel:

```text
65 Expertise Rating
```

---

## 2. Empfohlenes Raid-Killer-Set

| Slot | Item | ItemID | Besonderheit |
|---|---|---:|---|
| Kopf | Bonescythe Helmet | `22478` | 30 Agi, 18 Str, zusätzlich Hit/Crit über Legacy-Auren |
| Hals | Prestor's Talisman of Connivery | `19377` | 25 Agi, Hit + AP |
| Schultern | Mantle of Wicked Revenge | `21665` | 30 Agi, 16 Str |
| Rücken | Cloak of the Fallen God | `21710` | 26 Agi, 11 Str |
| Brust | Vest of Swift Execution | `21680` | 41 Agi, 21 Str |
| Handgelenke | Bonescythe Bracers | `22483` | 26 Agi, Crit; guter Platz für Expertise-Enchant |
| Hände | Aged Core Leather Gloves | `18823` | 15 Str, **12 Expertise Rating**, Crit |
| Gürtel | Shifting Sash of Midnight | `24063` | 15 Agi, AP, **2 Sockel** |
| Beine | Scale Leggings of the Skirmisher | `24022` | 22 Agi, 15 Int, **3 Sockel** |
| Füße | Wormscale Stompers | `21612` | 26 Agi, 13 Int, **12 Hit Rating** |
| Ring 1 | Circle of Applied Force | `19432` | 22 Agi, 12 Str |
| Ring 2 | Band of Reanimation | `22961` | 22 Agi + AP |
| Trinket 1 | Kiss of the Spider | `22954` | 10 Hit, 14 Crit + starker Haste-On-Use |
| Trinket 2 | Slayer's Crest | `23041` | hoher AP-Bonus + starker On-Use |
| Mainhand | Misplaced Servo Arm | `23221` | 2,80 Speed, sehr hoher Waffenschaden, zusätzlicher Proc |
| Offhand | The Castigator | `22808` | 2,60 Speed, Hit/Crit/AP |
| Relikt | Enhancement-Totem nach Talent/Rotation | – | kein einzelnes Classic-Relikt ist für das Gesamtsetup zwingend |

### Waffen

```text
MH: Misplaced Servo Arm – 2,80
OH: The Castigator       – 2,60
```

Beide sind langsame Einhand-Streitkolben und passen dadurch wesentlich besser zu Enhancement als schnelle Rogue-Waffen.

`Misplaced Servo Arm` hat den höheren Top-End-Schaden und gehört deshalb in die Mainhand.

---

## 3. Hit des Grundsets

Ein Teil der alten Classic-Gegenstände speichert Rating noch als passive Equip-Spells. Relevant sind unter anderem:

```text
spell 15464 = +10 Hit Rating
spell 7597  = +14 Crit Rating
spell 7598  = +28 Crit Rating
```

Für das gewählte Set ergibt sich vor Gems/Enchants ungefähr:

```text
Bonescythe Helmet                    +10 Hit
Prestor's Talisman of Connivery     +10 Hit
Wormscale Stompers                   +12 Hit
Kiss of the Spider                   +10 Hit
The Castigator                       +10 Hit
--------------------------------------------
Grundset                             ~52 Hit
```

Hinweis: Die lokale SQL-Spalte `Hit` allein zeigt diese Legacy-Auren nicht vollständig; deshalb ist bei Classic-Items die Spell-ID mit zu berücksichtigen.

---

## 4. Expertise exakt über Gear + Enchant + Gems

Ausrüstung:

```text
Aged Core Leather Gloves     +12 Expertise Rating
```

Enchant auf den Armschienen:

```text
Enchant Bracers – Expertise  +15 Expertise Rating
```

Zwischensumme:

```text
27 Expertise Rating
```

Dann zwei Sockel mit:

```text
Precise Cardinal Ruby
ItemID 40118
+20 Expertise Rating
```

Ergebnis:

```text
27 + 40 = 67 Expertise Rating
```

Benötigt:

```text
65 Expertise Rating
```

Wir liegen nur **2 Rating über dem Softcap**.

Das ist praktisch perfekt:

```text
67 / 2,5 = 26,8 Expertise
```

Keine weiteren Expertise-Punkte nötig.

---

## 5. Hit über die verbleibenden drei Sockel + Enchants

Nach den zwei Expertise-Gems bleiben in Gürtel + Hose insgesamt noch drei Sockel frei.

Dort:

```text
3x Rigid King's Amber
ItemID 40125
+20 Hit Rating
```

Dadurch:

```text
~52 Grundset
+60 Hit-Gems
=112 Hit
```

Jetzt:

```text
Enchant Gloves – Precision  +20 Hit
Enchant Boots – Icewalker   +12 Hit
```

Gesamt:

```text
112
+20
+12
---
144 Hit Rating
```

Ziel:

```text
136 Hit Rating
```

Damit erreichen wir:

```text
144 / 8 = 18 % Spell Hit
```

Der Boss benötigt 17 %.

Wir liegen also nur etwa **1 % über dem Spell-Hit-Cap**.

Das ist für einen robusten Raid-Killer sinnvoller, als starke Teile gegen deutlich schwächere Hit-Gegenstände auszutauschen.

---

## 6. Warum kein Hit-Enchant auf den Waffen?

Absichtlich nicht.

Unsere beiden Waffen sind Itemlevel 83 und können deshalb mit dem WotLK-Enchant:

```text
Enchant Weapon – Berserking
```

versehen werden.

Der Proc liefert:

```text
+400 Attack Power
```

und kann bei Dual Wield auf **beiden Waffen separat proccen und gleichzeitig aktiv sein**.

Deshalb sollen Hit und Expertise möglichst über Gear, Sockel und Neben-Slots gelöst werden.

Empfehlung:

```text
Misplaced Servo Arm: Berserking
The Castigator:      Berserking
```

---

## 7. Gem-Verteilung

Die fünf Sockel aus:

```text
Shifting Sash of Midnight        2
Scale Leggings of the Skirmisher 3
----------------------------------
Gesamt                            5
```

werden so verwendet:

```text
2x Precise Cardinal Ruby   +40 Expertise
3x Rigid King's Amber      +60 Hit
```

ItemIDs:

```text
40118 = Precise Cardinal Ruby (+20 Expertise)
40125 = Rigid King's Amber    (+20 Hit)
```

---

## 8. Enchants – Kern

| Slot | Enchant | Zweck |
|---|---|---|
| Bracers | Expertise | +15 Expertise Rating |
| Gloves | Precision | +20 Hit Rating |
| Boots | Icewalker | +12 Hit + 12 Crit |
| Mainhand | Berserking | +400 AP Proc |
| Offhand | Berserking | +400 AP Proc |

Die restlichen Slots können anschließend auf **Agility / AP** optimiert werden.

---

## 9. Warum dieses Set nicht einfach eine Vanilla-Enhancement-BiS-Liste ist

Das wäre für deinen Server fachlich falsch.

Auf deinem Server gilt bereits WotLK-Enhancement:

- Dual Wield
- Maelstrom Weapon
- Expertise Rating
- gemeinsames Hit Rating
- Intellect trägt über `Mental Dexterity` zur Attack Power bei
- AP trägt über `Mental Quickness` zum Spell Power bei

Dazu kommen auf Level 60 bereits tragbare TBC-Gegenstände wie:

```text
Shifting Sash of Midnight
Scale Leggings of the Skirmisher
```

Diese besitzen Sockel und sind deshalb unter 3.3.5a-Regeln außergewöhnlich wertvoll.

Die Liste ist daher bewusst ein **Level-60-WotLK-Raid-Killer-Set**, kein historisches 2006-BiS.

---

## 10. GM-Block – Level 60 Verstärker

```text
.additem 22478
.additem 19377
.additem 21665
.additem 21710
.additem 21680
.additem 22483
.additem 18823
.additem 24063
.additem 24022
.additem 21612
.additem 19432
.additem 22961
.additem 22954
.additem 23041
.additem 23221
.additem 22808
```

Gems:

```text
.additem 40118 2
.additem 40125 3
```

---

## 11. Kurzfassung Verstärker

```text
Charakterlevel:        60
Bosslevel:             63

Spell-Hit-Ziel:       136 Rating
Geplantes Hit:        ~144 Rating
Status:                Cap erreicht

Expertise-Ziel:        65 Rating
Geplante Expertise:    67 Rating
Status:                Cap erreicht

Waffen:
MH Misplaced Servo Arm 2,80
OH The Castigator      2,60

Weapon Enchants:
Berserking / Berserking
```

Damit sind sowohl **Spell Hit als auch Waffenkunde praktisch sauber gecappt**, ohne die beiden Waffen mit Accuracy belegen zu müssen.

---

# Level-60-Status

- [x] Elementar vollständig
- [x] Verstärker vollständig
- [x] Hit-Caps für 3.3.5a berücksichtigt
- [x] Expertise/Waffenkunde für Verstärker berücksichtigt
- [x] Dual-Wield-Waffen festgelegt
- [x] ItemIDs dokumentiert
- [x] Gem-Verteilung dokumentiert
- [x] `.additem`-Blöcke vorhanden

**Level 60 ist damit abgeschlossen.**
