# DebuffCleaner

Kleines WoW-3.3.5a-Addon fuer den privaten AzerothCore-Server.

Das Addon zeigt die aktuell auf dem eigenen Charakter aktiven **Debuffs** ueber `UnitDebuff("player", index)` an. Ein Klick auf einen Eintrag fuehrt gezielt `.unaura <spellId>` auf dem eigenen Charakter aus und stellt danach das vorherige Ziel wieder her.

Damit koennen problematische Boss-Effekte wie Silence, Fear, Mind Control, Stuns oder andere Debuffs waehrend eines Tests entfernt werden, ohne mit `.unaura all` saemtliche positiven/passiven Auren und damit z. B. Schadensboni zu verlieren.

## Installation

1. Diesen Ordner aus dem Repository kopieren:

   `Client/Interface/AddOns/DebuffCleaner`

2. In den WoW-3.3.5a-Client kopieren nach:

   `<WoW-Ordner>\Interface\AddOns\DebuffCleaner`

3. WoW komplett neu starten oder im Charakterauswahlbildschirm pruefen, ob `DebuffCleaner` aktiviert ist.

## Bedienung

Das Fenster zeigt bis zu 16 Debuff-Slots mit:

- Icon
- Name
- Stack-Anzahl
- Restdauer
- Spell-ID im Tooltip

Ein Klick auf einen belegten Eintrag fuehrt sinngemaess folgendes sichere Makro aus:

```text
/target [@player]
/run <aktuelle Spell-ID des Debuff-Slots lesen und .unaura senden>
/targetlasttarget
```

Dadurch bleibt der Boss nach dem Klick wieder dein Target.

## Slash-Befehle

```text
/dc
/dc show
/dc hide
/dc reset
```

`/dc reset` setzt die Fensterposition zurueck.

Fensterposition und Sichtbarkeit sollten ausserhalb des Kampfes geaendert werden. Die Debuff-Zeilen selbst verwenden vorbereitete SecureActionButtons mit statischen Makros, damit der Klick auch waehrend des Kampfes funktionieren kann.

## Warum feste Debuff-Slots?

WoW schuetzt SecureActionButtons im Kampf. Ein Addon darf deren sichere Makroattribute waehrend des Kampfes nicht beliebig neu setzen oder Buttons dynamisch ein-/ausblenden.

Deshalb werden beim Laden 16 feste, sichere Zeilen vorbereitet. Jede Zeile liest beim Klick die **aktuelle** Spell-ID aus ihrem `UnitDebuff`-Slot. Text, Icon und Restdauer duerfen weiterhin live aktualisiert werden.

## Voraussetzung

Der verwendete GM-Account muss den AzerothCore-Befehl `.unaura` ausfuehren duerfen.

AzerothCore `.unaura #spellid` entfernt die Aura dieser Spell-ID von der aktuell ausgewaehlten Einheit. Das Addon targetet deshalb kurz den eigenen Charakter und stellt danach das vorherige Target wieder her.

## Einschraenkung / Testhinweis

Der WoW-3.3.5a-Client hat strenge Combat-Lockdown-Regeln. Die Implementierung vermeidet absichtlich jede Aenderung sicherer Button-Attribute waehrend des Kampfes. Trotzdem sollte nach der Installation zuerst an einem harmlosen Debuff getestet werden, ob dein Client die Kombination aus sicherem Target-Wechsel und AzerothCore-Chatcommand wie erwartet verarbeitet.
