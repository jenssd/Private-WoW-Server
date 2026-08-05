# NPCBots in Raidinstanzen

## Problem

NPCBots funktionierten in der offenen Welt und in normalen 5-Spieler-Instanzen, blieben aber bei Raidinstanzen wie Molten Core am Eingang bzw. wurden nicht zum Spieler in die Instanz teleportiert.

Die Installation, der Build, die Datenbanktabellen und die Gruppenzuordnung waren korrekt. Auch ein Update auf den aktuellen NPCBots-AzerothCore-Stand änderte das Verhalten nicht.

## Ursache

Raidinstanzen sind für NPCBots standardmäßig deaktiviert.

In der aktiven `worldserver.conf` stand:

```ini
NpcBot.Enable.Raid = 0
```

Dadurch lehnt die NPCBot-Logik den Teleport in Raidkarten über `BotCfg::IsMapAllowedForBots(...)` ab. Im NPCBot-Log zeigte sich das als wiederholter Teleport-Versuch im Abstand von etwa fünf Sekunden.

## Lösung

In der aktiven Datei

```text
AzerothCore/Install-NPCBots/configs/worldserver.conf
```

diesen Wert setzen:

```ini
NpcBot.Enable.Raid = 1
```

Danach den Worldserver neu starten.

Diese Werte können unverändert bleiben:

```ini
NpcBot.DisableInstances = ""
NpcBot.Limit.Raid = 1
```

## Wichtiger Hinweis bei Installation und Updates

Nach Installation oder Update des vorgepatchten AzerothCore-NPCBots-Forks die NPCBot-Sektion aus `worldserver.conf.dist` immer vollständig mit der aktiven `worldserver.conf` vergleichen.

Besonders prüfen:

```ini
NpcBot.Enable = 1
NpcBot.Enable.Dungeon = 1
NpcBot.Enable.Raid = 1
```

Die mitgelieferte Standardkonfiguration setzt `NpcBot.Enable.Raid` auf `0`. Wer Raids mit NPCBots nutzen möchte, muss die Option ausdrücklich aktivieren.

## Diagnosemerkmale

Typisches Fehlerbild:

- 5er-Instanzen funktionieren
- Raidgruppe ist korrekt erstellt
- Bots werden im Raidframe angezeigt
- Bots bleiben am Raidportal oder erscheinen nicht beim Spieler
- `.npcbot recall teleport` hat keine sichtbare Wirkung
- `characters_npcbot_group_member` enthält korrekte Gruppeneinträge
- NPCBot-Logs zeigen wiederholte `NPCBOT_LOG_TELEPORT_FINISH`-Einträge

Vor tieferem Debugging deshalb immer zuerst `NpcBot.Enable.Raid` prüfen.
