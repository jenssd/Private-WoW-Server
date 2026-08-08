# Raidinstanzen Level 60 / 70 / 80
## WoW 3.3.5a / AzerothCore

Diese Übersicht ist für einen privaten **AzerothCore 3.3.5a**-Server gedacht.

Ziel: schnell sehen,

- welche Raidinstanzen zu Level 60, 70 und 80 gehören,
- wo sie liegen,
- wie man normal dorthin kommt,
- und welcher `.tele`-Name auf einem typischen AzerothCore/TrinityCore-Setup sinnvoll ist.

> **Wichtig zu `.tele`:** AzerothCore liest die Ziele aus der World-DB-Tabelle `game_tele`. Die exakten Namen können je nach DB-Stand abweichen. Falls ein unten genannter Name nicht funktioniert, suche ihn in `game_tele`.
>
> Beispiel:
>
> ```sql
> SELECT id, name, map, position_x, position_y, position_z
> FROM game_tele
> WHERE name LIKE '%Naxx%';
> ```
>
> Im Spiel:
>
> ```text
> .tele Naxxramas
> ```
>
> AzerothCore unterstützt außerdem:
>
> ```text
> .teleport <location>
> .go xyz <x> <y> <z> <mapid>
> ```

---

# Level 60 – Classic Raids

Unter WoW 3.3.5a sind **Naxxramas und Onyxia nicht mehr Level-60-Raids**. Beide wurden für Wrath auf Level 80 umgesetzt.

## Molten Core

**Raidgröße:** 40  
**Gebiet:** Blackrock Mountain, zwischen Burning Steppes und Searing Gorge  
**Endboss:** Ragnaros

Normaler Weg:

```text
Blackrock Mountain
→ ganz nach unten zum Lava-Bereich
→ Eingang Molten Core
```

Mit abgeschlossener Einstimmungsquest kann man außerdem über Lothos Riftwalker direkt hinein.

Typischer Teleport:

```text
.tele MoltenCore
```

Falls nicht vorhanden:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Molten%';
```

---

## Blackwing Lair

**Raidgröße:** 40  
**Gebiet:** Blackrock Mountain  
**Endboss:** Nefarian

Normaler Weg:

```text
Blackrock Mountain
→ Blackrock Spire
→ oberer Bereich vor UBRS
→ Orb of Command
```

Für den Orb ist normalerweise die BWL-Einstimmung erforderlich.

Typischer Teleport:

```text
.tele BlackwingLair
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Blackwing%';
```

---

## Zul'Gurub

**Raidgröße:** 20  
**Gebiet:** Stranglethorn Vale  
**Endboss:** Hakkar

Normaler Weg:

```text
Stranglethorn Vale
→ nordöstlicher Bereich
→ großes Trolltor nach Zul'Gurub
```

Typischer Teleport:

```text
.tele ZulGurub
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Gurub%';
```

---

## Ruins of Ahn'Qiraj – AQ20

**Raidgröße:** 20  
**Gebiet:** Silithus  
**Endboss:** Ossirian the Unscarred

Normaler Weg:

```text
Silithus
→ südlich zur Scarab Wall
→ linker/nördlicher Raid-Eingang
```

Typische Teleport-Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Ahn%'
   OR name LIKE '%Qiraj%';
```

---

## Temple of Ahn'Qiraj – AQ40

**Raidgröße:** 40  
**Gebiet:** Silithus  
**Endboss:** C'Thun

Normaler Weg:

```text
Silithus
→ Scarab Wall ganz im Süden
→ großer zentraler Raid-Eingang
```

Typische Teleport-Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Ahn%'
   OR name LIKE '%Qiraj%';
```

---

# Level 70 – The Burning Crusade Raids

## Karazhan

**Raidgröße:** 10  
**Gebiet:** Deadwind Pass  
**Endboss:** Prince Malchezaar

Normaler Weg:

```text
Eastern Kingdoms
→ Deadwind Pass
→ Karazhan im Süden der Zone
```

Typischer Teleport:

```text
.tele Karazhan
```

---

## Gruul's Lair

**Raidgröße:** 25  
**Gebiet:** Blade's Edge Mountains  
**Endboss:** Gruul the Dragonkiller

Normaler Weg:

```text
Outland
→ Blade's Edge Mountains
→ Gruul's Lair
```

Typischer Teleport:

```text
.tele GruulsLair
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Gruul%';
```

---

## Magtheridon's Lair

**Raidgröße:** 25  
**Gebiet:** Hellfire Peninsula  
**Endboss:** Magtheridon

Normaler Weg:

```text
Hellfire Peninsula
→ Hellfire Citadel
→ Raid-Eingang am Citadel-Komplex
```

Typischer Teleport:

```text
.tele MagtheridonsLair
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Magther%';
```

---

## Serpentshrine Cavern – SSC

**Raidgröße:** 25  
**Gebiet:** Zangarmarsh / Coilfang Reservoir  
**Endboss:** Lady Vashj

Normaler Weg:

```text
Zangarmarsh
→ Coilfang Reservoir
→ in den See tauchen
→ durch das zentrale Rohr
→ Raid-Eingang im inneren Reservoir
```

Typischer Teleport:

```text
.tele SerpentshrineCavern
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Serpent%';
```

---

## Tempest Keep: The Eye

**Raidgröße:** 25  
**Gebiet:** Netherstorm  
**Endboss:** Kael'thas Sunstrider

Normaler Weg:

```text
Netherstorm
→ Tempest Keep im Osten
→ großes mittleres fliegendes Gebäude
```

Typischer Teleport:

```text
.tele TempestKeep
```

Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Tempest%'
   OR name LIKE '%Eye%';
```

---

## Battle for Mount Hyjal

**Raidgröße:** 25  
**Gebiet:** Caverns of Time, Tanaris  
**Endboss:** Archimonde

Normaler Weg:

```text
Tanaris
→ Caverns of Time
→ Eingang Battle for Mount Hyjal
```

Typischer Teleport:

```text
.tele Hyjal
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Hyjal%';
```

---

## Black Temple

**Raidgröße:** 25  
**Gebiet:** Shadowmoon Valley  
**Endboss:** Illidan Stormrage

Normaler Weg:

```text
Outland
→ Shadowmoon Valley
→ ganz im Osten zum Black Temple
```

Typischer Teleport:

```text
.tele BlackTemple
```

---

## Zul'Aman

**Raidgröße:** 10  
**Gebiet:** Ghostlands  
**Endboss:** Zul'jin

Normaler Weg:

```text
Eastern Kingdoms
→ Ghostlands
→ südöstlicher Bereich
→ Zul'Aman
```

Typischer Teleport:

```text
.tele ZulAman
```

---

## Sunwell Plateau

**Raidgröße:** 25  
**Gebiet:** Isle of Quel'Danas  
**Endboss:** Kil'jaeden

Normaler Weg:

```text
Isle of Quel'Danas
→ südwestlicher Bereich der Insel
→ Sunwell Plateau
```

Typischer Teleport:

```text
.tele SunwellPlateau
```

Suche:

```sql
SELECT * FROM game_tele WHERE name LIKE '%Sunwell%';
```

---

# Level 80 – Wrath of the Lich King Raids

## Naxxramas

**Raidgröße:** 10 / 25  
**Gebiet:** Dragonblight  
**Endboss:** Kel'Thuzad

Normaler Weg:

```text
Dragonblight
→ fliegende Nekropole Naxxramas
→ Eingang über die Plattform
```

Typischer Teleport:

```text
.tele Naxxramas
```

---

## The Obsidian Sanctum

**Raidgröße:** 10 / 25  
**Gebiet:** Dragonblight / Wyrmrest Temple  
**Endboss:** Sartharion

Normaler Weg:

```text
Dragonblight
→ Wyrmrest Temple
→ unter den Tempel
→ Chamber of Aspects
→ schwarzes Portal
```

Typischer Teleport:

```text
.tele ObsidianSanctum
```

---

## The Eye of Eternity

**Raidgröße:** 10 / 25  
**Gebiet:** Borean Tundra / Coldarra  
**Endboss:** Malygos

Normaler Weg:

```text
Borean Tundra
→ Coldarra
→ Nexus-Komplex
→ Raid-Eingang
```

Typische Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Eternity%'
   OR name LIKE '%Malygos%';
```

---

## Vault of Archavon

**Raidgröße:** 10 / 25  
**Gebiet:** Wintergrasp  
**Bosse:** Archavon, Emalon, Koralon, Toravon

Normaler Weg:

```text
Wintergrasp
→ Wintergrasp Fortress
→ innerhalb der Festung zum Raidportal
```

Typische Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Archavon%'
   OR name LIKE '%Vault%';
```

---

## Ulduar

**Raidgröße:** 10 / 25  
**Gebiet:** The Storm Peaks  
**Endboss:** Yogg-Saron  
**Optional:** Algalon the Observer

Normaler Weg:

```text
Storm Peaks
→ ganz im Norden
→ Ulduar-Komplex
→ Eingang hinter dem Vorplatz
```

Typischer Teleport:

```text
.tele Ulduar
```

---

## Trial of the Crusader – ToC / ToGC

**Raidgröße:** 10 / 25  
**Heroic:** Trial of the Grand Crusader  
**Gebiet:** Icecrown / Argent Tournament Grounds  
**Endboss:** Anub'arak

Normaler Weg:

```text
Icecrown
→ Argent Tournament Grounds
→ Coliseum
→ Raid-Eingang
```

Typische Suche:

```sql
SELECT * FROM game_tele
WHERE name LIKE '%Crusader%'
   OR name LIKE '%Tournament%';
```

---

## Onyxia's Lair

**Raidgröße:** 10 / 25  
**Gebiet:** Dustwallow Marsh  
**Endboss:** Onyxia

> Unter 3.3.5a ist dies die **Level-80-Version**, nicht mehr der ursprüngliche Level-60-Raid.

Normaler Weg:

```text
Dustwallow Marsh
→ südlicher Bereich bei Wyrmbog
→ Höhleneingang
```

Typischer Teleport:

```text
.tele OnyxiasLair
```

---

## Icecrown Citadel – ICC

**Raidgröße:** 10 / 25  
**Heroic:** 10H / 25H  
**Gebiet:** Icecrown  
**Endboss:** The Lich King

Normaler Weg:

```text
Icecrown
→ südlicher Teil der Icecrown Citadel
→ große Eingangstreppe / Raidportal
```

Typischer Teleport:

```text
.tele IcecrownCitadel
```

---

## The Ruby Sanctum

**Raidgröße:** 10 / 25  
**Heroic:** 10H / 25H  
**Gebiet:** Dragonblight / Wyrmrest Temple  
**Endboss:** Halion

Normaler Weg:

```text
Dragonblight
→ Wyrmrest Temple
→ unter den Tempel
→ Chamber of Aspects
→ Ruby-Sanctum-Portal
```

Typischer Teleport:

```text
.tele RubySanctum
```

---

# Schnellübersicht

| Level | Raid | Größe | Gebiet |
|---:|---|---|---|
| 60 | Molten Core | 40 | Blackrock Mountain |
| 60 | Blackwing Lair | 40 | Blackrock Mountain |
| 60 | Zul'Gurub | 20 | Stranglethorn Vale |
| 60 | Ruins of Ahn'Qiraj | 20 | Silithus |
| 60 | Temple of Ahn'Qiraj | 40 | Silithus |
| 70 | Karazhan | 10 | Deadwind Pass |
| 70 | Gruul's Lair | 25 | Blade's Edge Mountains |
| 70 | Magtheridon's Lair | 25 | Hellfire Peninsula |
| 70 | Serpentshrine Cavern | 25 | Zangarmarsh |
| 70 | Tempest Keep: The Eye | 25 | Netherstorm |
| 70 | Battle for Mount Hyjal | 25 | Caverns of Time |
| 70 | Black Temple | 25 | Shadowmoon Valley |
| 70 | Zul'Aman | 10 | Ghostlands |
| 70 | Sunwell Plateau | 25 | Isle of Quel'Danas |
| 80 | Naxxramas | 10/25 | Dragonblight |
| 80 | Obsidian Sanctum | 10/25 | Dragonblight |
| 80 | Eye of Eternity | 10/25 | Borean Tundra |
| 80 | Vault of Archavon | 10/25 | Wintergrasp |
| 80 | Ulduar | 10/25 | Storm Peaks |
| 80 | Trial of the Crusader | 10/25 | Icecrown |
| 80 | Onyxia's Lair | 10/25 | Dustwallow Marsh |
| 80 | Icecrown Citadel | 10/25 | Icecrown |
| 80 | Ruby Sanctum | 10/25 | Dragonblight |

---

# Praktischer GM-Tipp

Wenn ein `.tele`-Name nicht funktioniert, ist die lokale DB die zuverlässigste Quelle:

```sql
SELECT id, name, map, position_x, position_y, position_z
FROM game_tele
WHERE name LIKE '%Suchbegriff%'
ORDER BY name;
```

Danach im Spiel:

```text
.tele <NameAusDerDB>
```

AzerothCore verwendet für `.tele` / `.teleport` die Einträge aus `game_tele`.

## Eigenen Teleport anlegen

Wenn du direkt vor einem Raid-Eingang stehst:

```text
.tele add MeinRaid
```

Danach kannst du künftig einfach:

```text
.tele MeinRaid
```

verwenden.
