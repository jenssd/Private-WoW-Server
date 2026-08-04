# Schamane – Treffergrenzen und Verzauberungsplanung

Gültig für einen AzerothCore-Server mit WoW 3.3.5a / Wrath-of-the-Lich-King-Regeln.

Diese Datei ergänzt die Ausrüstungslisten für:

- Elementar und Verstärkung
- Level 60, 70 und 80
- Solo-Spiel gegen Raidbosse
- individuelle Anpassung über Verzauberungen, Edelsteine und Ausrüstung

---

# 1. Was bedeutet „Boss“ für das Treffer-Cap?

Ein Raidboss wird für die Trefferberechnung als **drei Level höher als dein Charakter** behandelt:

| Dein Level | Boss wird behandelt wie |
|---:|---:|
| 60 | Level 63 |
| 70 | Level 73 |
| 80 | Level 83 |

Gegen ein Ziel drei Level über dir gelten in WotLK:

| Angriffsart | Fehlchance ohne Trefferbonus |
|---|---:|
| Zauber | 17 % |
| Nahkampf-Spezialangriffe | 8 % |
| Beidhändige normale Autoangriffe | 27 % |

Sobald das jeweilige Cap erreicht ist, bringt zusätzliche Trefferwertung für diese Angriffsart keinen weiteren Nutzen gegen Verfehlen.

---

# 2. Umrechnung von Trefferwertung

Die gleiche Trefferwertung wird mit steigendem Charakterlevel schwächer.

| Charakterlevel | Trefferwertung für 1 % Nahkampftreffer | Trefferwertung für 1 % Zaubertreffer |
|---:|---:|---:|
| 60 | 10,00 | 8,00 |
| 70 | 15,76 | 12,62 |
| 80 | 32,79 | 26,23 |

Die Tabellen unten runden immer auf die nächste ganze Trefferwertung auf, damit das Cap sicher erreicht wird.

---

# 3. Elementar-Schamane: Zaubertreffer-Cap

Elementar verwendet fast ausschließlich Zauber. Maßgeblich ist daher das **17-%-Zaubertreffer-Cap** gegen Raidbosse.

## Elementare Präzision

Das Talent `Elementare Präzision` gibt bei 3/3 Punkten:

```text
+3 % Zaubertrefferchance
```

Dadurch musst du über Ausrüstung, Edelsteine und Verzauberungen nur noch 14 % erreichen.

Ein Draenei erhält durch `Heldenhafte Präsenz` zusätzlich 1 % Trefferchance. Auf einem lokalen Singleplayer-Server solltest du diesen Bonus nur abziehen, wenn dein Charakter tatsächlich Draenei ist und der Bonus bei dir aktiv angezeigt wird.

## Benötigte Trefferwertung

| Level | Ohne Talent/Buff: 17 % | Mit 3/3 Elementare Präzision: 14 % | Talent + Draenei: 13 % |
|---:|---:|---:|---:|
| 60 | 136 | 112 | 104 |
| 70 | 215 | 177 | 165 |
| 80 | 446 | 368 | 341 |

## Empfehlung für dein Solo-Spiel

Für einen normalen Elementar-Build:

| Level | Empfohlenes Ziel |
|---:|---:|
| 60 | 112 Trefferwertung |
| 70 | 177 Trefferwertung |
| 80 | 368 Trefferwertung |

Diese Werte setzen `3/3 Elementare Präzision` voraus und berücksichtigen **keinen** externen Priester- oder Druiden-Debuff.

## Externe Gruppenbuffs

`Elend` eines Schattenpriesters oder `Verbessertes Feenfeuer` eines Gleichgewichtsdruiden kann die benötigte Trefferchance um weitere 3 % reduzieren.

Mit Talent und einem solchen Debuff wären nur noch 11 % aus Ausrüstung nötig:

| Level | 11 % Trefferwertung |
|---:|---:|
| 60 | 88 |
| 70 | 139 |
| 80 | 289 |

Für ein Solo-Spiel solltest du diese niedrigeren Werte nur verwenden, wenn einer deiner NPCBots den Debuff zuverlässig permanent auf Bossen hält.

---

# 4. Verstärkungs-Schamane: drei verschiedene Treffer-Caps

Beim Verstärker gibt es nicht nur ein einziges Cap.

## A. Spezialangriffe

Dazu gehören beispielsweise:

- Sturmschlag
- Lavapeitsche
- andere gelbe Nahkampfangriffe

Gegen einen Raidboss brauchen sie 8 % Trefferchance.

`Beidhändigkeitsspezialisierung` gibt bei 3/3 Punkten 6 % Nahkampftrefferchance. Damit fehlen nur noch 2 % aus Ausrüstung.

| Level | Ohne Beidhändigkeitsspezialisierung: 8 % | Mit 3/3 Beidhändigkeitsspezialisierung: 2 % |
|---:|---:|---:|
| 60 | 80 | 20 |
| 70 | 127 | 32 |
| 80 | 263 | 66 |

Dieses kleine Cap solltest du immer erreichen.

## B. Zauber des Verstärkers

Dazu gehören unter anderem:

- Erdschock
- Flammenschock
- Blitzschlag durch Waffe des Mahlstroms
- Kettenblitzschlag
- Feuernova

Diese Zauber verwenden das 17-%-Zaubertreffer-Cap.

`Beidhändigkeitsspezialisierung` hilft dabei **nicht**.

| Level | 17 % ohne weitere Boni | Draenei: 16 % | Mit 3/3 Elementare Präzision: 14 % |
|---:|---:|---:|---:|
| 60 | 136 | 128 | 112 |
| 70 | 215 | 202 | 177 |
| 80 | 446 | 420 | 368 |

Ein typischer reiner Verstärkungs-Build besitzt nicht zwingend `Elementare Präzision`. Prüfe daher deine tatsächliche Talentverteilung.

## C. Normale beidhändige Autoangriffe

Normale weiße Treffer haben beim Beidhändigkeitskampf eine Fehlchance von 27 %.

Mit 3/3 `Beidhändigkeitsspezialisierung` bleiben 21 %:

| Level | 27 % ohne Talent | 21 % mit Beidhändigkeitsspezialisierung |
|---:|---:|---:|
| 60 | 270 | 210 |
| 70 | 426 | 331 |
| 80 | 886 | 689 |

Dieses Cap solltest du **nicht gezielt anstreben**. Es kostet zu viele Ausrüstungspunkte. Trefferwertung oberhalb des Zaubertreffer-Caps verbessert zwar weiterhin deine normalen Autoangriffe, ist aber normalerweise schwächer als Angriffskraft, Tempo und andere Schadenswerte.

## Empfohlenes Ziel für Verstärkung

Für ein komfortables Solo-Endgame:

| Level | Mindestziel | Starkes Gesamtziel |
|---:|---:|---:|
| 60 | 20 Nahkampftrefferwertung | etwa 136 Trefferwertung für Zauber |
| 70 | 32 Nahkampftrefferwertung | etwa 215 Trefferwertung für Zauber |
| 80 | 66 Nahkampftrefferwertung | etwa 446 Trefferwertung für Zauber |

Da Trefferwertung in WotLK gleichzeitig Nahkampf- und Zaubertreffer unterstützt, erreichst du das Spezialangriffs-Cap automatisch lange vor dem Zaubertreffer-Cap.

Für Verstärkung ist daher praktisch:

```text
Zuerst Spezialangriffe absichern
→ dann Waffenkunde
→ anschließend möglichst nahe an das Zaubertreffer-Cap
→ Autoangriffs-Cap ignorieren
```

---

# 5. Waffenkunde für Verstärkung

Trefferwertung verhindert Verfehlen.  
Waffenkunde verhindert, dass der Boss deinen Nahkampfangriffen ausweicht oder sie pariert.

Wenn du hinter dem Boss stehst, kann er normalerweise nicht parieren. Dann musst du nur seine Ausweichchance von 6,5 % entfernen.

Dafür werden benötigt:

```text
26 Waffenkunde
```

## Benötigte Waffenkundewertung

| Level | Wertung pro Waffenkundepunkt | Für 26 Waffenkunde |
|---:|---:|---:|
| 60 | 2,50 | 65 |
| 70 | 3,94 | 103 |
| 80 | 8,20 | 214 |

Das Verstärkertalent `Entfesselte Wut` gibt 9 Waffenkunde. Dann fehlen nur noch 17 Punkte:

| Level | Wertung für verbleibende 17 Waffenkunde |
|---:|---:|
| 60 | 43 |
| 70 | 67 |
| 80 | 140 |

## Empfehlung

Für Verstärkung gegen Bosse:

```text
26 Waffenkunde insgesamt
```

beziehungsweise mit `Entfesselte Wut` ungefähr:

```text
Level 60: 43 Waffenkundewertung
Level 70: 67 Waffenkundewertung
Level 80: 140 Waffenkundewertung
```

---

# 6. Trefferwertung im Charakterfenster kontrollieren

## Elementar

Charakterfenster öffnen und unter den Zauberwerten die Trefferchance beziehungsweise Trefferwertung kontrollieren.

Die Summe setzt sich zusammen aus:

```text
Trefferwertung auf Ausrüstung
+ Trefferwertung aus Edelsteinen
+ Trefferwertung aus Verzauberungen
+ Talentbonus
+ Rassenbonus
+ Gruppen- oder Gegnerdebuffs
```

## Verstärkung

Du musst zwei Anzeigen beachten:

- Nahkampftrefferchance
- Zaubertrefferchance

Die gleiche Trefferwertung wird unterschiedlich in Prozent umgerechnet. Deshalb kann das Nahkampf-Cap bereits erreicht sein, während bei Zaubern noch mehrere Prozent fehlen.

---

# 7. Verzauberungen zum Feinabstimmen der Trefferwertung

## WotLK / Level 80

| Slot | Verzauberung | Trefferwertung | Zusatzwert |
|---|---|---:|---|
| Handschuhe | Precision | +20 | – |
| Stiefel | Icewalker | +12 | +12 kritische Trefferwertung |
| Waffe | Accuracy | +25 | +25 kritische Trefferwertung |

Maximal über diese drei Slots:

```text
57 Trefferwertung
```

Damit kannst du ein knapp verfehltes Cap sehr bequem schließen.

## Wann welche Verzauberung?

| Fehlende Trefferwertung | Sinnvolle Anpassung |
|---:|---|
| 1–12 | Icewalker auf Stiefel |
| 13–20 | Precision auf Handschuhe |
| 21–25 | Accuracy auf Waffe |
| 26–32 | Handschuhe + Stiefel |
| 33–45 | Waffe + Handschuhe |
| 46–57 | alle drei Trefferverzauberungen |
| mehr als 57 | zusätzlich Ausrüstung oder Edelsteine ändern |

## Sobald das Cap erreicht ist

Überflüssige Trefferverzauberungen ersetzen:

### Elementar

- Waffe: Zaubermacht oder Black Magic
- Handschuhe: Zaubermacht
- Stiefel: Tempo, Ausdauer/Bewegung oder anderer Schadenswert

### Verstärkung

- Waffen: Berserking beziehungsweise passende Schadensverzauberungen
- Handschuhe: Angriffskraft
- Stiefel: Angriffskraft, Beweglichkeit oder Bewegungstempo nach Setup

---

# 8. Level 60 und 70

Nicht jede WotLK-Verzauberung kann auf ältere Gegenstände angewendet werden. Manche Verzauberungen verlangen ein bestimmtes Gegenstandslevel.

Darum gilt:

1. gewünschte fertige Verzauberungsrolle suchen,
2. Tooltip auf Gegenstandslevel-Beschränkung prüfen,
3. falls sie nicht anwendbar ist, eine ältere Trefferverzauberung oder Trefferedelsteine verwenden.

Suche lokal:

```text
.lookup item Scroll of Enchant Gloves
.lookup item Scroll of Enchant Boots
.lookup item Scroll of Enchant Weapon
```

Oder über dein Addon:

```text
/pwai precision
/pwai icewalker
/pwai accuracy
/pwai treffer
```

---

# 9. Fertige Verzauberungsrollen statt Beruf

Du musst Verzauberkunst nicht selbst lernen.

Der reguläre WotLK-Ablauf ist:

```text
Inschriftenkundler stellt leeres Pergament her
→ Verzauberer wirkt die Verzauberung auf das Pergament
→ fertige Verzauberungsrolle entsteht
→ jeder Charakter kann die Rolle anwenden
```

Auf deinem privaten Server kannst du die fertige Rolle direkt geben:

```text
.additem <ROLLEN-ID> 1
```

Dann:

1. Rolle im Inventar rechtsklicken,
2. passendes Ausrüstungsteil anklicken,
3. Verzauberung wird angewendet.

Die genaue Rollen-ID solltest du aus deiner lokalen `item_template` ermitteln, weil sie auf deinem Server verbindlich ist.

## SQL-Suche nach Trefferrollen

```sql
SELECT
    entry,
    name,
    RequiredLevel,
    spellid_1
FROM item_template
WHERE name LIKE '%Scroll of Enchant%'
  AND (
      name LIKE '%Accuracy%'
      OR name LIKE '%Precision%'
      OR name LIKE '%Icewalker%'
      OR name LIKE '%Hit%'
  )
ORDER BY name;
```

## Allgemeine Suche nach Verzauberungsrollen

```sql
SELECT entry, name, RequiredLevel
FROM item_template
WHERE name LIKE 'Scroll of Enchant%'
ORDER BY name;
```

---

# 10. Praktische Beispiele

## Level 60 Elementar mit 3/3 Elementare Präzision

Ziel:

```text
112 Trefferwertung
```

Aktuelle Ausrüstung liefert beispielsweise:

```text
95 Trefferwertung
```

Es fehlen:

```text
17 Trefferwertung
```

Eine Handschuhverzauberung mit 20 Trefferwertung würde das Cap erreichen:

```text
95 + 20 = 115
```

Die drei Punkte oberhalb des Caps sind nicht schlimm, aber bringen keinen weiteren Zaubertreffer-Nutzen.

## Level 70 Elementar mit 3/3 Elementare Präzision

Ziel:

```text
177 Trefferwertung
```

Aktuell:

```text
145 Trefferwertung
```

Fehlend:

```text
32 Trefferwertung
```

Passende Kombination:

```text
+20 Handschuhe
+12 Stiefel
= +32
```

Ergebnis:

```text
177 Trefferwertung
```

## Level 80 Elementar mit 3/3 Elementare Präzision

Ziel:

```text
368 Trefferwertung
```

Aktuell:

```text
323 Trefferwertung
```

Fehlend:

```text
45 Trefferwertung
```

Passende Kombination:

```text
+25 Waffe
+20 Handschuhe
= +45
```

Ergebnis:

```text
368 Trefferwertung
```

## Level 80 Verstärkung

Angenommen:

```text
3/3 Beidhändigkeitsspezialisierung
9 Waffenkunde aus Entfesselte Wut
```

Erste Ziele:

```text
mindestens 66 Trefferwertung
etwa 140 Waffenkundewertung
```

Komfortables Zauberziel ohne externe Buffs:

```text
446 Trefferwertung
```

Das weiße Autoangriffs-Cap von ungefähr 689 Trefferwertung nach Talent wird nicht gezielt angestrebt.

---

# 11. Kurzreferenz

## Elementar gegen Raidboss

| Level | Mit 3/3 Elementare Präzision |
|---:|---:|
| 60 | 112 Trefferwertung |
| 70 | 177 Trefferwertung |
| 80 | 368 Trefferwertung |

## Verstärkung gegen Raidboss

| Level | Spezialangriffe mit 3/3 Beidhändigkeitsspezialisierung | Zauber ohne weitere Boni | Waffenkunde mit Entfesselter Wut |
|---:|---:|---:|---:|
| 60 | 20 Trefferwertung | 136 Trefferwertung | 43 Waffenkundewertung |
| 70 | 32 Trefferwertung | 215 Trefferwertung | 67 Waffenkundewertung |
| 80 | 66 Trefferwertung | 446 Trefferwertung | 140 Waffenkundewertung |

## Nicht als Ziel verwenden

| Level | Weißes DW-Cap nach Beidhändigkeitsspezialisierung |
|---:|---:|
| 60 | etwa 210 |
| 70 | etwa 331 |
| 80 | etwa 689 |

Diese Werte sind technisch erreichbar, aber für eine sinnvolle Ausrüstungsoptimierung normalerweise zu teuer.

---

# 12. Lokale Kontrolle

Die verbindlichen Werte deines Charakters siehst du im Spiel. Servermodule oder lokale Änderungen können Talente oder Formeln beeinflussen.

Hilfreiche Befehle:

```text
.lookup item <Name>
/pwai <Name oder ID>
.help lookup item
```

Für Gegenstände und Rollen bleibt deine lokale Tabelle `item_template` maßgeblich.
