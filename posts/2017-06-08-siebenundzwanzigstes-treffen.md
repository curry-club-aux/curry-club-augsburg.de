---
title: Programm für das siebenundzwanzigste Treffen am 15. Juni 2017
subtitle: Dicksons Lemma und hfish
meetup-announcement: 2017-06-15
meetup-counter: "27"
meetup-time: 17:30
author: Tim Baumann
---

Xaver stellt hfish vor, seine in Haskell geschriebene Shell, die mit diversen
Altlasten herkömmlicher Shells aufräumt.

Ingo improvisierte etwas zu folgender Problemstellung: Gegeben seien zwei
unendliche Listen natürlicher Zahlen, `as` und `bs`. Dann gibt es immer ein
Paar `(i,j)` von Indizes mit `i < j`, sodass
`as!!i <= as!!j` und `bs!!i <= bs!!j`.

Das ist gar nicht klar! Wie findet man ein solches Paar? Ein eleganter
klassischer Beweis der Existenz gibt dazu kaum Aufschluss, denn als
Hilfsschritt bestimmt er das Minimum einer unendlichen Liste. Man kann nun auf
clevere Art und Weise die Continuationmonade einsetzen, um diese eigentlich in
der Praxis unlösbar scheinende Aufgaben lösbar erscheinen zu lassen.
