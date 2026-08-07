# Schamane Level 70 – Raid-DPS-Set (WoW 3.3.5a / AzerothCore)

Ziel: möglichst hoher Boss-DPS mit sauberem Hit- und Expertise-/Waffenkunde-Management.

> Grundlage für die Itemwerte: lokaler Dump aus `acore_npcbots_world.item_template`.
> Die Bewertung erfolgt unter WoW-3.3.5a-Mechanik, nicht unter originaler TBC-Talentmechanik.

---

# Elementar

## Hit-Ziel

Gegen Raidbosse (+3 Level) werden insgesamt 17 % Spell Hit benötigt.

Mit 3/3 **Elemental Precision**:

- 3 % Spell Hit aus Talent
- 14 % müssen aus Gear/Gems kommen
- Level 70: ca. 12,62 Hit Rating pro 1 %
- Ziel daher rund **177 Hit Rating**

Das geplante Grundset liefert **97 Hit Rating**.

Mit:

```text
4x Rigid King's Amber (+20 Hit)
```

ergibt sich:

```text
97 + 80 = 177 Hit Rating
```

Damit ist das Set ohne externe Raid-Debuffs am Boss-Hit-Cap.

## Empfohlenes Set

| Slot | Item | ItemID | Hit |
|---|---|---:|---:|
| Kopf | Cowl of Gul'dan | `34332` | 0 |
| Hals | Amulet of Unfettered Magics | `34204` | 15 |
| Schultern | Skyshatter Mantle | `31023` | 11 |
| Rücken | Tattered Cape of Antonidas | `34242` | 0 |
| Brust | Sunfire Robe | `34364` | 0 |
| Handgelenke | Skyshatter Bands | `34437` | 0 |
| Hände | Handguards of Defiled Worlds | `34344` | 27 |
| Gürtel | Skyshatter Cord | `34542` | 0 |
| Beine | Chain Links of the Tumultuous Storm | `34186` | 0 |
| Füße | Skyshatter Treads | `34566` | 0 |
| Ring 1 | Loop of Forged Power | `34362` | 19 |
| Ring 2 | Ring of Omnipotence | `34230` | 0 |
| Trinket 1 | The Skull of Gul'dan | `32483` | 25 |
| Trinket 2 | Shifting Naaru Sliver | `34429` | 0 |
| Mainhand | Sunflare | `34336` | 0 |
| Offhand | Heart of the Pit | `34179` | 0 |
| Relikt | Totem of Ancestral Guidance | `32330` | 0 |

## GM-Block

```text
.additem 34332
.additem 34204
.additem 31023
.additem 34242
.additem 34364
.additem 34437
.additem 34344
.additem 34542
.additem 34186
.additem 34566
.additem 34362
.additem 34230
.additem 32483
.additem 34429
.additem 34336
.additem 34179
.additem 32330
```

---

# Verstärker

## Zielwerte

Für Enhancement unter 3.3.5a sind zwei Caps besonders wichtig:

1. **Spell Hit**
   - Maelstrom-Lightning-Bolt, Shocks usw. verwenden Spell Hit.
   - Dual Wield Specialization hilft nur beim Melee-Hit, nicht beim Spell-Hit.
   - Ohne Misery / Improved Faerie Fire wird gegen Raidbosse das volle **17-%-Spell-Hit-Ziel** angesetzt.
   - Auf Level 70 entspricht das rund **215 Hit Rating**.

2. **Expertise / Waffenkunde**
   - Ziel von hinten: ungefähr **26 Expertise**
   - entspricht auf Level 70 rund **103 Expertise Rating**
   - damit werden Boss-Dodges praktisch ausgeschaltet.

White-Hit von Dual Wield wird nicht vollständig gecappt; das wäre für dieses Set zu teuer.

---

## Empfohlenes Grundset

| Slot | Item | ItemID | Hit | Expertise | Hinweis |
|---|---|---:|---:|---:|---|
| Kopf | Duplicitous Guise | `34244` | 30 | 0 | Sehr starker Sunwell-Helm |
| Hals | Hard Khorium Choker | `34358` | 0 | 0 | starke DPS-Werte; Jewelcrafting-Item |
| Schultern | Demontooth Shoulderpads | `34392` | 0 | 0 | starke rohe DPS-Stats |
| Rücken | Cloak of Unforgivable Sin | `34241` | 0 | 0 | BiS-DPS-Cape |
| Brust | Bladed Chaos Tunic | `34397` | 0 | 0 | Sunwell-BiS |
| Handgelenke | Skyshatter Wristguards | `34439` | 17 | 17 | Hit + Expertise |
| Hände | Thalassian Ranger Gauntlets | `34343` | 0 | 0 | starke DPS-Handschuhe |
| Gürtel | Skyshatter Girdle | `34545` | 0 | 22 | Expertise + Crit/Haste |
| Beine | Leggings of the Immortal Night | `34188` | 32 | 0 | sehr starke Beine |
| Füße | Skyshatter Greaves | `34567` | 0 | 29 | Expertise + Crit/Haste |
| Ring 1 | Band of Ruinous Delight | `34189` | 0 | 0 | BiS-DPS-Ring |
| Ring 2 | Stormrage Signet Ring | `32497` | 30 | 0 | viel Hit |
| Trinket 1 | Blackened Naaru Sliver | `34427` | 0 | 0 | starker DPS-Trinket |
| Trinket 2 | Shard of Contempt | `34472` | 0 | 44 | sehr effizient für Expertise |
| Mainhand | Hand of the Deceiver | `34331` | – | – | 2,6 Speed |
| Offhand | Mounting Vengeance | `34346` | – | – | 2,6 Speed |

### Basiswerte aus dem lokalen Dump

```text
Hit Rating:       109
Expertise Rating: 112
```

Die Waffen waren im ersten Dump nicht enthalten, weil die SQL-Filterung den normalen One-Hand-Slot nicht vollständig abgedeckt hatte. Für die Cap-Betrachtung der oben gelisteten Rüstung/Schmuckstücke ist das aber bereits ausreichend.

---

## Expertise-Bewertung

Das Set landet mit:

```text
Skyshatter Wristguards  17
Skyshatter Girdle       22
Skyshatter Greaves      29
Shard of Contempt       44
--------------------------
Gesamt                 112 Expertise Rating
```

Ziel sind ungefähr **103 Expertise Rating**.

Damit liegen wir nur etwa **9 Rating über dem Softcap**.

Das ist für dieses Set völlig akzeptabel und deutlich besser, als ein starkes BiS-Teil nur für mathematisch exakt 103 Rating auszutauschen.

**Fazit Expertise: erledigt. Keine Expertise-Gems erforderlich.**

---

## Hit-Bewertung

Basis:

```text
109 Hit Rating
```

Robustes Ziel ohne externen Spell-Hit-Debuff:

```text
ca. 215 Hit Rating
```

Fehlend:

```text
ca. 106 Hit Rating
```

Da wir auf deinem privaten 3.3.5a-Server auch WotLK-Gems verwenden können, ist die einfachste Variante zunächst Hit über Sockel zu ergänzen und die starken Sunwell-Items nicht gegen schlechtere Hit-Items auszutauschen.

Mit 5× +20 Hit:

```text
109 + 100 = 209
```

Das liegt noch knapp unter dem Ziel.

Mit 6× +20 Hit:

```text
109 + 120 = 229
```

Damit liegen wir rund 14 Rating über dem Ziel.

Für einen robusten Raid-Killer ist **229 Hit** momentan die bevorzugte Variante: etwas Overcap ist wesentlich weniger problematisch als verfehlte Lightning Bolts/Shocks.

### Hit-Gem

```text
Rigid King's Amber
ItemID: 40125
+20 Hit Rating
```

Benötigt:

```text
.additem 40125 6
```

> Später kann man die rund 14 überschüssigen Hit-Punkte noch mit einer gemischten Gem-Kombination oder einem einzelnen Slottausch genauer ausoptimieren. Für deinen Zweck ist das nicht nötig.

---

## Waffen

Die Kombination bleibt:

```text
Mainhand: Hand of the Deceiver  (34331)
Offhand:  Mounting Vengeance    (34346)
```

Beide laufen mit **2,6 Sekunden Geschwindigkeit**.

Das ist für Enhancement besonders angenehm, weil möglichst gleiche langsame Waffengeschwindigkeiten Flurry/Windfury und die allgemeine Schlag-Synchronisierung begünstigen.

---

## GM-Block – Verstärker

```text
.additem 34244
.additem 34358
.additem 34392
.additem 34241
.additem 34397
.additem 34439
.additem 34343
.additem 34545
.additem 34188
.additem 34567
.additem 34189
.additem 32497
.additem 34427
.additem 34472
.additem 34331
.additem 34346
```

Hit-Gems:

```text
.additem 40125 6
```

---

# Level-70-Fazit

## Elementar

```text
Hit-Ziel: 177
Grundset:   97
4 Hit-Gems: +80
Ergebnis:  177
```

## Verstärker

```text
Spell-Hit-Ziel:    ca. 215
Grundset Hit:          109
6 Hit-Gems:           +120
Ergebnis:              229

Expertise-Ziel:     ca. 103
Grundset Expertise:    112
Ergebnis:           Cap erreicht
```

Das Enhancement-Set ist damit bewusst auf **zuverlässigen Boss-DPS** statt auf ein theoretisches TBC-Parse-Setup ausgelegt.

---

# Nächster Schritt

Level 70 ist damit als praxisfähiges Raid-Set grundsätzlich abgeschlossen.

Als nächste Datei:

`Schamane-L60.md`

Schwerpunkt zuerst:

**Elementar Level 60 unter 3.3.5a-Mechanik**, weil das aktuell die gespielte Level-60-Skillung ist.
