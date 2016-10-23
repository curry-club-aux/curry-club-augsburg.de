---
title: Programm für das siebzehnte Treffen am 11. August 2016
subtitle: Idris und Versionskontrollsysteme
meetup-announcement: 2016-08-11
meetup-counter: "17"
meetup-time: 19:00
author: Ingo Blechschmidt
---

uwap stellte Idris als "general purpose"-Sprache vor, in der man abhängige
Typen praktisch verwenden kann.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/DhznnY59Lu4" frameborder="0" allowfullscreen></iframe>

Tim hielt spontan einen Vortrag über [quantities](https://github.com/timjb/quantities), eine von ihm geschriebene Idris-Bibliothek zum Rechnen mit physikalischen Einheiten.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/PrNVF2tWaVs" frameborder="0" allowfullscreen></iframe>

Tim hielt einen Vortrag zu
Versionskontrollsystemen und Patch-Theorie. Er stellte die
unterschiedlichen Modelle von git und darcs vor. Eigentlich wollte er noch insbesondere auf das neue
Versionskontrollsystem [Pijul](http://pijul.org/) eingehen, welches
aufgebaut ist auf (oder ist laut Webseite "inspiriert ist von") einer
kategorientheoretischen [Theorie von](http://www.lix.polytechnique.fr/Labo/Samuel.Mimram/docs/mimram_ctp.pdf)
[Patches](http://www.lix.polytechnique.fr/Labo/Samuel.Mimram/docs/mimram_ctp_slides.pdf)
von Samuel Mimram und Cinzia Di Giusto. Tim musste aber leider kurz vor dem Vortrag feststellen, dass das Paper fehlerhaft ist und die aktuelle Version von Pijul nicht funktioniert.

[Kurze Werbepause: Das Idee des Papers ist richtig cool! Die Autoren gehen von der
Kategorie der "normalen", linearen Dokumente aus und wollen dann
"mergen" als Pushout modellieren. Damit Patches immer gemergt werden
können, sollte die Kategorie endlich kovollständig sein, damit alle
Pushouts existieren. Deshalb gehen die Autoren zur freien konservativen
(schon existierende Kolimiten bleiben erhalten) Kovervollständigung der
Kategorie der linearen Dokumente über. Diese Kovervollständigung kann man
nach einem Folklore-Theorem explizit als volle Unterkategorie der
Kategorie der Prägarben auf der Kategorie der linearen Dokumente
beschreiben. Im Hauptteil des Papers leiten die Autoren eine viel
konkretere, graphentheoretische (aber leider falsche) Beschreibung dieser Kategorie her.]

Aufgrund der vortgeschrittenen Zeit wurde Profpatsch's Vortrag verschoben.
