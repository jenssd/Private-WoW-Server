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
- Gems aus den Gear-Listen werden ebenfalls hinzugefuegt.
- Enchants werden nicht automatisch angewendet.
- Das Addon prueft nicht, ob ein einzelnes `.additem` serverseitig fehlgeschlagen ist.

## Hinweis zu Level 80

Die Sets verwenden fuer `Phylactery of the Nameless Lich` die ItemID `50365`.

Falls diese ID auf der lokalen AzerothCore-Installation nicht vorhanden ist, muss das betreffende Ersatztrinket separat hinzugefuegt bzw. die Liste im Addon angepasst werden.

## Neue Klassen / Sets ergaenzen

Neue Sets koennen in `RaidGearSets.lua` im Tabellenblock `sets` hinzugefuegt werden. Jedes Set besteht aus einem Namen und einer Liste kompletter GM-Kommandos.
