# Level-60-Raidvorlage fuer NPCBots

Die Vorlage ist fuer einen Level-60-Elementar-Schamanen ausgelegt und priorisiert physischen Schaden, damit die Gruppe auch waehrend Silence-Effekten weiterkaempft.

## Zusammensetzung

- Spieler: Elementar-Schamane
- Tank: Schutz-Krieger
- Heiler: Heilig-Paladin
- DD: Kampf-Schurke
- DD: Furor-Krieger
- DD: Treffsicherheits-Jaeger

## Oeffnen

```text
/pwaraid
```

Alternativ im Hauptfenster `/pwa` den Button `Raidvorlage` verwenden.

## Bot konfigurieren

Fuer jede Rolle:

1. Einen eigenen NPCBot der passenden Klasse als Ziel auswaehlen.
2. Bei der vorgesehenen Rolle `Konfigurieren` klicken.
3. Den Spec des Bots aktuell manuell setzen. Die Raidvorlage deaktiviert die automatische Spec-Konfiguration, weil die numerische Zuordnung je nach NPCBots-Build abweicht.
4. Danach wird das Ziel entfernt und das vorbereitete Level-60-Gear per `.additem` in das Inventar des Spielers gelegt.
5. Den Bot rechtsklicken.
6. `Manage equipment` und danach `Auto-equip` auswaehlen.
7. Vor der naechsten Rolle warten, bis die komplette Itemausgabe beendet wurde.

Die Itemausgabe erfolgt bewusst zeitversetzt, damit der Server die Befehle sicher verarbeitet.

Im Heilig-Paladin-Gear ersetzen `19345` (Aegis of Preservation) und `17105` (Aurastone Hammer) die lokal nicht nutzbaren IDs `19312` und `19360`.

## Gruppe und Raid vorbereiten

Die Erstellung der Gruppe und die Umwandlung in einen Raid erfolgen ausschliesslich manuell:

1. Beim NPCBot-Gossip `Create Group (all bots)` auswaehlen.
2. Die entstandene Gruppe ueber die Blizzard-UI manuell in einen Raid umwandeln.
3. Pruefen, ob die Bots weiterhin echte Gruppenmitglieder sind und auf Rechtsklick/Fokus reagieren.
4. Im Vorlagenfenster `Raid vorbereiten` klicken. Dieser Button sendet nur `.npcbot command follow` und `.npcbot recall teleport`.

Das Addon nimmt keine Raid-Konvertierung, Rollenvergabe, Befoerderung oder Manipulation der Blizzard-Raidframes vor. Falls bereits ein Raid besteht, werden ebenfalls nur Follow und Recall ausgefuehrt.

## Automatisierungsgrenzen

Ein WoW-Addon kann die Gegenstaende nicht direkt in die internen Ausruestungsslots eines NPCBots schreiben. Das sichere Anlegen erfolgt deshalb weiterhin ueber das vom NPCBots-Modul vorgesehene Gossip-Menue `Manage equipment -> Auto-equip`.

Auch die Heilerprioritaet auf einen bestimmten Tank kann nicht verlaesslich ueber die allgemeinen GM-Befehle gesetzt werden. Die Vorlage setzt deshalb Klasse und Gear; Spec und anschliessendes Rollenverhalten muessen aktuell ueber den lokalen NPCBots-Build beziehungsweise dessen Gossip-Menue eingerichtet werden.

## Testhinweise

Beim ersten Test kontrollieren:

- werden alle Item-IDs als gueltig erkannt,
- waehlt Auto-equip die vorgesehene Waffe beziehungsweise das Schild,
- haelt der Schutz-Krieger die Aggro,
- heilt und reinigt der Heilig-Paladin verlaesslich,
- bleiben die Bots nach der manuellen Raid-Konvertierung echte Gruppenmitglieder und folgen anschliessend.

Die Raidvorlage behebt nicht automatisch ein moegliches Eintrittsproblem der NPCBots bei Molten Core oder Blackwing Lair. Dieses Problem wird nach erfolgreicher Konfiguration erneut getestet.
