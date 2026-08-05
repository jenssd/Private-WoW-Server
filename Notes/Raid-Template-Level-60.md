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

## Raid vorbereiten

Zuerst alle Bots als normale Gruppenmitglieder aufnehmen. Danach im Vorlagenfenster `Raid vorbereiten` klicken.

Der Button:

- wandelt eine bestehende Gruppe in einen Raid um,
- setzt alle NPCBots auf Follow,
- ruft die Bots zur aktuellen Position zurueck.

Falls bereits ein Raid besteht, werden nur Follow und Recall ausgefuehrt.

## Automatisierungsgrenzen

Ein WoW-Addon kann die Gegenstaende nicht direkt in die internen Ausruestungsslots eines NPCBots schreiben. Das sichere Anlegen erfolgt deshalb weiterhin ueber das vom NPCBots-Modul vorgesehene Gossip-Menue `Manage equipment -> Auto-equip`.

Auch die Heilerprioritaet auf einen bestimmten Tank kann nicht verlaesslich ueber die allgemeinen GM-Befehle gesetzt werden. Die Vorlage setzt deshalb Klasse und Gear; Spec und anschliessendes Rollenverhalten muessen aktuell ueber den lokalen NPCBots-Build beziehungsweise dessen Gossip-Menue eingerichtet werden.

## Testhinweise

Beim ersten Test kontrollieren:

- werden alle Item-IDs als gueltig erkannt,
- waehlt Auto-equip die vorgesehene Waffe beziehungsweise das Schild,
- haelt der Schutz-Krieger die Aggro,
- heilt und reinigt der Heilig-Paladin verlaesslich,
- folgen alle Bots nach der Raid-Konvertierung.

Die Raidvorlage behebt nicht automatisch ein moegliches Eintrittsproblem der NPCBots bei Molten Core oder Blackwing Lair. Dieses Problem wird nach erfolgreicher Konfiguration erneut getestet.
