# RaidGearSets

Kleines WoW-3.3.5a-Addon fuer den privaten AzerothCore-Server.

Das Addon sendet vorbereitete GM-`.additem`-Befehle mit kurzem Abstand nacheinander an den Server. Damit muessen komplette Gear-Sets nicht manuell Zeile fuer Zeile eingegeben werden.

## Installation

1. Den Ordner `RaidGearSets` aus diesem Repository kopieren:

   `Client/Interface/AddOns/RaidGearSets`

2. Den kompletten Ordner in den WoW-3.3.5a-Client kopieren nach:

   `<WoW-Ordner>\Interface\AddOns\RaidGearSets`

3. Danach muessen direkt in diesem Ordner mindestens diese Dateien liegen:

   - `RaidGearSets.toc`
   - `RaidGearSets.lua`

4. WoW neu starten oder im Charakterauswahlbildschirm unter `AddOns` pruefen, ob `RaidGearSets` aktiviert ist.

5. Mit einem GM-Charakter einloggen.

## Befehle

```text
/gear60ele   Schamane Level 60 Elementar
/gear60enh   Schamane Level 60 Verstaerker
/gear70ele   Schamane Level 70 Elementar
/gear70enh   Schamane Level 70 Verstaerker
/gear80ele   Schamane Level 80 Elementar
/gear80enh   Schamane Level 80 Verstaerker
```

Allgemeine Hilfe:

```text
/raidgear help
```

Laufende Ausgabe abbrechen:

```text
/raidgear stop
```

## Verhalten

- Jeder Slash-Befehl startet genau ein Set.
- Die `.additem`-Kommandos werden mit 0,20 Sekunden Abstand gesendet.
- Waehrend ein Set laeuft, wird kein zweites gestartet.
- Gear und benoetigte Gems werden hinzugefuegt.
- Passende Major-/Minor-Glyphen fuer das jeweilige Level und die Skillung werden ebenfalls hinzugefuegt.
- Passende Verzauberungsrollen werden ebenfalls ins Inventar gelegt.
- Glyphen und Verzauberungsrollen werden **nicht automatisch angewendet**; sie liegen danach im Inventar und werden manuell benutzt.
- Das Addon prueft nicht, ob ein einzelnes `.additem` serverseitig fehlgeschlagen ist.

## Glyphen

### Elementar

- Level 60: Glyph of Lightning Bolt, Glyph of Totem of Wrath
- Level 70: Glyph of Lightning Bolt, Glyph of Lava
- Level 80: Glyph of Lightning Bolt, Glyph of Lava, Glyph of Totem of Wrath
- Minor: Water Shield, Renewed Life; ab Level 70 zusaetzlich Water Walking

### Verstaerker

- Level 60/70: Glyph of Stormstrike, Glyph of Feral Spirit
- Level 80: fuer das im Addon verwendete Spellhance-Setup Glyph of Stormstrike, Glyph of Fire Nova, Glyph of Flametongue Weapon
- Minor: Water Shield, Renewed Life; ab Level 70 zusaetzlich Water Walking

## Verzauberungsrollen

Die Rollen sind auf die jeweilige Set-/Cap-Planung abgestimmt. Beispiele:

- Elementar: Greater Speed, Powerful Stats, Superior Spellpower, Exceptional Spellpower bzw. Precision, Icewalker/Tuskarr's Vitality, Mighty Spellpower, auf Level 80 zusaetzlich Greater Intellect fuer das Schild.
- Verstaerker: Greater Speed, Powerful Stats, Expertise bzw. Greater Assault, Precision/Crusher, Icewalker/Tuskarr's Vitality und Berserking fuer beide Waffen.

Wichtig: Einige Verzauberungen veraendern Hit oder Expertise. Deshalb nicht wahllos Rollen zwischen den Sets tauschen, da die Gem-/Cap-Rechnung des jeweiligen Sets darauf abgestimmt ist.

## Hinweis zu Level 80

Die Sets verwenden fuer `Phylactery of the Nameless Lich` die ItemID `50365`.

Falls diese ID auf der lokalen AzerothCore-Installation nicht vorhanden ist, muss das betreffende Ersatztrinket separat hinzugefuegt bzw. die Liste im Addon angepasst werden.

## Neue Klassen / Sets ergaenzen

Neue Sets koennen in `RaidGearSets.lua` im Tabellenblock `sets` hinzugefuegt werden. Jedes Set besteht aus einem Namen und einer Liste kompletter GM-Kommandos.

Fuer neue Klassen sollte der gleiche Aufbau verwendet werden:

```text
Gear
Gems
Glyphen passend zum Level
Verzauberungsrollen passend zur finalen Cap-Rechnung
```
