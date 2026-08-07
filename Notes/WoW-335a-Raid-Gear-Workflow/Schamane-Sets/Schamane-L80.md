# Schamane Level 80 – Raid-DPS-Set
## WoW 3.3.5a / AzerothCore

Ziel: **möglichst hoher und gleichzeitig zuverlässiger Boss-DPS** auf Level 80.

Die ItemIDs wurden gegen den lokalen `shaman80.txt`-Dump aus `acore_npcbots_world.item_template` abgeglichen, soweit die Items dort vorhanden waren.

Grundannahmen:

- Raidboss = Level 83
- keine Draenei-Hit-Aura vorausgesetzt
- keine fremden Hit-Debuffs (`Misery` / `Improved Faerie Fire`) vorausgesetzt
- Angriff des Verstärkers von hinten
- Standard-PvE-Talente
- beim Verstärker wird 3/3 `Unleashed Rage` mit den daraus resultierenden 9 Expertise vorausgesetzt
- Ziel ist ein robuster „Raid-Killer“, nicht ein Setup, das nur unter perfekter Raid-Komposition funktioniert

---

# Elementar

## 1. Caps

### Spell Hit

Gegen einen Level-83-Raidboss:

```text
17 % Spell Hit insgesamt
-3 % Elemental Precision
-------------------------
14 % aus Gear
```

Auf Level 80:

```text
26,232 Hit Rating = 1 %
14 % ≈ 367 Hit Rating
```

Ziel:

```text
367 Hit Rating
```

---

## 2. Empfohlenes Set

Wir behalten bewusst **4 Teile T10** und verwenden die Heroic-277-Versionen.

| Slot | Item | ItemID | Hit | Hinweis |
|---|---|---:|---:|---|
| Kopf | Sanctified Frost Witch's Helm | `51237` | 0 | T10 |
| Hals | Amulet of the Silent Eulogy | `50658` | 60 | Hit + Haste + SP |
| Schultern | Horrific Flesh Epaulets | `50698` | 0 | starkes Off-Set |
| Rücken | Cloak of Burning Dusk | `54583` | 0 | Heroic Ruby Sanctum |
| Brust | Sanctified Frost Witch's Hauberk | `51239` | 0 | T10 |
| Handgelenke | Bracers of Fiery Night | `54582` | 0 | Heroic Ruby Sanctum |
| Hände | Sanctified Frost Witch's Gloves | `51238` | 82 | T10 |
| Gürtel | Split Shape Belt | `54587` | 0 | Heroic Ruby Sanctum |
| Beine | Sanctified Frost Witch's Kilt | `51236` | 106 | T10 |
| Füße | Plague Scientist's Boots | `50699` | 0 | Crit + Haste + SP |
| Ring 1 | Ring of Rapid Ascent | `50664` | 0 | Crit + Haste |
| Ring 2 | Ashen Band of Endless Destruction | `50398` | 51 | Hit + Haste + Proc |
| Trinket 1 | Dislodged Foreign Object | `50348` | 0 | Haste + SP-Proc |
| Trinket 2 | Phylactery of the Nameless Lich | `50365` | 0 | Crit + starker SP-Proc |
| Mainhand | Royal Scepter of Terenas II | `50734` | 0 | BiS-Caster-MH |
| Schild | Bulwark of Smouldering Steel | `50616` | 0 | starkes Caster-Schild |
| Relikt | Bizuri's Totem of Shattered Ice | `50458` | 0 | bestes T10-Relikt |

### Besonderheit Phylactery

`50365` wurde vom allgemeinen lokalen SQL-Dump nicht ausgegeben, obwohl dies die kanonische Heroic-WotLK-ItemID ist.

Falls dein Server bei:

```text
.additem 50365
```

meldet, dass das Item nicht existiert, verwende stattdessen:

```text
Charred Twilight Scale
ItemID 54588
```

Die Scale ist ebenfalls ein sehr starkes Endgame-Trinket und ist im lokalen Dump vorhanden.

---

## 3. Hit-Rechnung

Gear:

```text
Amulet of the Silent Eulogy            60
Sanctified Frost Witch's Gloves        82
Sanctified Frost Witch's Kilt         106
Ashen Band of Endless Destruction      51
-----------------------------------------
Gear                                  299
```

Benötigt:

```text
367
```

Fehlend:

```text
68 Hit Rating
```

### Lösung

```text
3x Rigid King's Amber   +60 Hit
Enchant Boots: Icewalker +12 Hit
```

Ergebnis:

```text
299 + 60 + 12 = 371 Hit Rating
```

Damit liegen wir nur:

```text
4 Rating
```

über dem Ziel.

Das ist praktisch perfekt.

### Hit-Gem

```text
Rigid King's Amber
ItemID 40125
+20 Hit
```

Benötigt:

```text
.additem 40125 3
```

Die übrigen Sockel können auf Spell Power / Haste optimiert werden.

---

## 4. Elementar-Waffen

```text
Mainhand: Royal Scepter of Terenas II  50734
Offhand:  Bulwark of Smouldering Steel 50616
```

Für den Raid-Killer wird bewusst ein Schild statt eines Caster-Offhands verwendet, da die DPS-Werte sehr stark bleiben und zusätzliche physische Robustheit praktisch kostenlos mitkommt.

Waffen-Enchant:

```text
Mighty Spellpower
```

---

## 5. GM-Block Elementar

```text
.additem 51237
.additem 50658
.additem 50698
.additem 54583
.additem 51239
.additem 54582
.additem 51238
.additem 54587
.additem 51236
.additem 50699
.additem 50664
.additem 50398
.additem 50348
.additem 50365
.additem 50734
.additem 50616
.additem 50458
```

Hit-Gems:

```text
.additem 40125 3
```

Fallback, falls `50365` lokal fehlt:

```text
.additem 54588
```

---

# Verstärker

## 1. Besonderheit Level 80

Beim Verstärker ist das reine „höchstes Agility-Item nehmen“-Prinzip nicht optimal.

Enhancement verursacht in 3.3.5a einen großen Teil des Schadens über Zauber. Deshalb sind:

```text
Hit
Expertise
Haste
Agility/AP
Spell Power
Crit
```

gemeinsam zu betrachten.

Das finale Set ist deshalb bewusst ein **Hybrid-/Spellhance-Setup**.

---

## 2. Hit-Ziel

Ohne Draenei und ohne fremden Spell-Hit-Debuff:

```text
17 % Spell Hit
```

Auf Level 80:

```text
17 % x 26,232 ≈ 446 Hit Rating
```

Ziel:

```text
446 Hit Rating
```

`Dual Wield Specialization` hilft beim Melee-Hit, aber nicht beim Spell-Hit. Deshalb bleibt Spell Hit für den robusten Raid-Killer das entscheidende obere Hit-Ziel.

---

## 3. Expertise / Waffenkunde

Boss-Dodge von hinten:

```text
6,5 %
```

Ziel:

```text
26 Expertise
```

Mit 3/3 `Unleashed Rage` erhalten wir bereits:

```text
+9 Expertise
```

Damit fehlen aus Gear:

```text
17 Expertise
```

Auf Level 80 entsprechen 26 Expertise insgesamt rund 214 Expertise Rating; für die verbleibenden 17 Expertise benötigen wir rund:

```text
139 Expertise Rating
```

---

## 4. Empfohlenes robustes T10-Set

Hier weichen wir an **einem wichtigen Punkt** von der reinen Parse-BiS-Liste ab:

Statt T10-Brust + Off-Set-Handschuhen verwenden wir **T10-Handschuhe + Ikfirus's Sack of Wonder**.

Warum?

`Ikfirus's Sack of Wonder` liefert gleichzeitig:

```text
114 Hit
106 Expertise Rating
167 Agility
228 AP
```

Dadurch erreichen wir Hit und Expertise nahezu ohne massives Gem-Stapeln und behalten trotzdem den starken 4er-T10-Bonus.

| Slot | Item | ItemID | Hit | Expertise | Hinweis |
|---|---|---:|---:|---:|---|
| Kopf | Sanctified Frost Witch's Faceguard | `51242` | 0 | 0 | T10 |
| Hals | Sindragosa's Cruel Claw | `50633` | 0 | 0 | starker ST-Hals |
| Schultern | Sanctified Frost Witch's Shoulderguards | `51240` | 0 | 0 | T10 |
| Rücken | Cloak of Burning Dusk | `54583` | 0 | 0 | Haste/Crit/SP |
| Brust | Ikfirus's Sack of Wonder | `50656` | 114 | 106 | Schlüsselteil für Caps |
| Handgelenke | Umbrage Armbands | `54580` | 0 | 0 | Agi + Haste + Crit |
| Hände | Sanctified Frost Witch's Grips | `51243` | 63 | 0 | T10 |
| Gürtel | Split Shape Belt | `54587` | 0 | 0 | sehr starker Haste-Slot |
| Beine | Sanctified Frost Witch's War-Kilt | `51241` | 88 | 0 | T10 |
| Füße | Treads of the Wasteland | `50711` | 55 | 0 | Agi + Hit + Crit |
| Ring 1 | Band of the Bone Colossus | `50604` | 62 | 0 | Agi + Hit + Haste |
| Ring 2 | Ashen Band of Endless Vengeance | `50402` | 59 | 0 | Agi + Hit + Crit + Proc |
| Trinket 1 | Charred Twilight Scale | `54588` | 0 | 0 | Haste + starker SP-Proc |
| Trinket 2 | Phylactery of the Nameless Lich | `50365` | 0 | 0 | Crit + starker SP-Proc |
| Mainhand | Royal Scepter of Terenas II | `50734` | 0 | 0 | SP-MH |
| Offhand | Havoc's Call, Blade of Lordaeron Kings | `50737` | 0 | 0 | 2,60 Speed, physischer OH |
| Relikt | Bizuri's Totem of Shattered Ice | `50458` | 0 | 0 | stark mit T10 |

---

## 5. Verstärker-Hit

Gear:

```text
Ikfirus's Sack of Wonder                114
Sanctified Frost Witch's Grips           63
Sanctified Frost Witch's War-Kilt        88
Treads of the Wasteland                  55
Band of the Bone Colossus                62
Ashen Band of Endless Vengeance          59
-------------------------------------------
Gesamt                                  441 Hit
```

Ziel:

```text
446 Hit
```

Es fehlen gerade einmal:

```text
5 Hit Rating
```

Wir verwenden deshalb einen Hybrid-Gem:

```text
Glinting Ametrine
ItemID 40148
+10 Agility
+10 Hit
```

Ergebnis:

```text
451 Hit Rating
```

Nur:

```text
5 Rating
```

über dem robusten Spell-Hit-Cap.

Damit sind auch Melee-Specials problemlos abgedeckt.

---

## 6. Expertise

Gear:

```text
Ikfirus's Sack of Wonder  106 Expertise Rating
```

106 Rating entsprechen auf Level 80 ungefähr:

```text
12,9 Expertise
```

Talent:

```text
Unleashed Rage +9
```

Zwischenstand:

```text
~21,9 Expertise
```

Es fehlen rund:

```text
4,1 Expertise
```

### Lösung

Bracer-Enchant:

```text
Enchant Bracers – Expertise
+15 Expertise Rating
```

Gem:

```text
Precise Cardinal Ruby
ItemID 40118
+20 Expertise Rating
```

Dann:

```text
106 + 15 + 20 = 141 Expertise Rating aus Gear/Enchant/Gem
```

Das sind ungefähr:

```text
17,2 Expertise
```

plus Talent:

```text
+9
```

Gesamt:

```text
~26,2 Expertise
```

Damit sind wir praktisch exakt am Boss-Dodge-Cap.

---

## 7. Waffen – warum eine Caster-Mainhand?

Empfohlen:

```text
MH: Royal Scepter of Terenas II
    ItemID 50734
    893 Spell Power

OH: Havoc's Call, Blade of Lordaeron Kings
    ItemID 50737
    2,60 Speed
```

Das sieht zunächst seltsam aus, ist aber für 3.3.5a-Enhancement normal:

- ein großer Teil des Schadens skaliert mit Spell Power
- Mental Quickness macht Spell-Damage besonders relevant
- die physische Offhand behält hohen Waffenschaden für Lava Lash / White Hits / Windfury
- für reinen Single Target ist diese Kombination eine der stärksten möglichen Varianten

Wer bewusst **kein Spellhance** spielen möchte, kann stattdessen:

```text
Havoc's Call / Havoc's Call
```

verwenden.

Für maximales Gesamtpotenzial bleibt hier aber:

```text
Royal Scepter + Havoc's Call
```

die Hauptempfehlung.

Waffen-Enchants:

```text
Berserking / Berserking
```

---

## 8. Trinkets und lokale DB

### Charred Twilight Scale

```text
ItemID 54588
184 Haste Rating
```

Das Item ist im lokalen Dump vorhanden.

### Phylactery of the Nameless Lich

Kanonische Heroic-ItemID:

```text
50365
```

Dieses Item wurde durch unseren allgemeinen lokalen Export nicht ausgegeben.

Wenn:

```text
.additem 50365
```

auf deinem AzerothCore nicht funktioniert, verwende als sichere lokale Alternative:

```text
Whispering Fanged Skull
ItemID 50343
```

oder für noch stärkeren Zauberfokus:

```text
Dislodged Foreign Object
ItemID 50348
```

---

## 9. Gems Verstärker

Für die beiden Caps benötigen wir nur:

```text
1x Precise Cardinal Ruby
ItemID 40118
+20 Expertise

1x Glinting Ametrine
ItemID 40148
+10 Agility / +10 Hit
```

GM:

```text
.additem 40118
.additem 40148
```

Alle weiteren Sockel können anschließend auf den eigentlichen DPS ausgerichtet werden, typischerweise Agility/Haste abhängig vom Sockel und gewünschten Feintuning.

---

## 10. GM-Block Verstärker

```text
.additem 51242
.additem 50633
.additem 51240
.additem 54583
.additem 50656
.additem 54580
.additem 51243
.additem 54587
.additem 51241
.additem 50711
.additem 50604
.additem 50402
.additem 54588
.additem 50365
.additem 50734
.additem 50737
.additem 50458
```

Caps:

```text
.additem 40118
.additem 40148
```

Fallback für fehlendes Phylactery:

```text
.additem 50343
```

---

# Kurzvergleich

## Elementar

```text
Gear Hit:          299
3x Hit-Gem:        +60
Icewalker:         +12
----------------------
Hit:               371

Ziel:              367
Overcap:             4
```

T10:

```text
Helm
Chest
Gloves
Legs
= 4er T10
```

---

## Verstärker

```text
Gear Hit:          441
Glinting Ametrine: +10
----------------------
Hit:               451

Ziel:              446
Overcap:             5
```

Expertise:

```text
Ikfirus:           106 Rating
Bracer Enchant:    +15
Precise Ruby:      +20
----------------------
Gear/Bonus:        141 Rating
≈                  17,2 Expertise

Unleashed Rage:     +9 Expertise
----------------------
Gesamt:            ~26,2 Expertise
```

T10:

```text
Faceguard
Shoulderguards
Grips
War-Kilt
= 4er T10
```

---

# Level-80-Status

- [x] Elementar Set
- [x] Elementar Spell-Hit-Cap
- [x] Elementar 4er T10
- [x] Verstärker Set
- [x] Verstärker Spell-Hit-Cap
- [x] Verstärker Expertise/Waffenkunde
- [x] Verstärker 4er T10
- [x] Spellhance-Waffenwahl
- [x] lokale ItemIDs abgeglichen
- [x] GM-Blocks
- [x] Gem-Lösung
- [x] Fallback für lokal nicht exportiertes Phylactery

**Level 80 ist damit abgeschlossen.**
