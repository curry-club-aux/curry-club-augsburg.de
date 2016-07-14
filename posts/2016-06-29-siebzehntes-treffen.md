---
title: Programm für das siebzehnte Treffen am 11. August 2016
subtitle: Zipper, Patches
meetup-announcement: 2016-08-11
meetup-counter: "17"
meetup-time: 19:00
author: Ingo Blechschmidt
---

Profpatsch teilt seine Beobachtung mit, dass
[Zipper](https://www.st.cs.uni-saarland.de/edu/seminare/2005/advanced-fp/docs/huet-zipper.pdf)
zu den coolsten Datenstrukturen gehören, und wird damit die Reihe
über funktionale Datenstrukturen fortsetzen.

Tim wird einen Vortrag zu
Versionskontrollsystemen und Patch-Theorie halten. Er wird darin die
unterschiedlichen Modelle von git, darcs und insbesondere dem neuen
Versionskontrollsystem [Pijul](http://pijul.org/) vorstellen. Letzteres VCS
basiert auf (oder ist laut Webseite "inspiriert von") einer
kategorientheoretischen [Theorie von](http://www.lix.polytechnique.fr/Labo/Samuel.Mimram/docs/mimram_ctp.pdf)
[Patches](http://www.lix.polytechnique.fr/Labo/Samuel.Mimram/docs/mimram_ctp_slides.pdf)
von Samuel Mimram und Cinzia Di Giusto.

[Kurze Werbepause: Das Paper ist richtig cool! Die Autoren gehen von der
Kategorie der "normalen", linearen Dokumente aus und wollen dann
"mergen" als Pushout modellieren. Damit Patches immer gemergt werden
können, sollte die Kategorie endlich kovollständig sein, damit alle
Pushouts existieren. Deshalb gehen die Autoren zur freien konservativen
(schon existierende Kolimiten bleiben erhalten) Kovervollständigung der
Kategorie der linearen Dokumente über. Diese Kovervollständigung man
nach einem Folklore-Theorem explizit als volle Unterkategorie der
Kategorie der Prägarben auf der Kategorie der linearen Dokumente
beschreiben. Im Hauptteil des Papers leiten die Autoren eine viel
konkretere, graphentheoretische Beschreibung dieser Kategorie her.]

uwap wird Idris als "general purpose"-Sprache vorstellen, in der man abhängige
Typen praktisch verwenden kann.
