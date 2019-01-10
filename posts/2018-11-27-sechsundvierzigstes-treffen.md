---
title: libgccjit und Primzahlen
subtitle:
subsubtitle: 
meetup-announcement: 2019-01-24
meetup-counter: "46"
meetup-time: 19:00
author: iblech
---

Marc trägt über libgccjit vor; zudem hält möglicherweise Matthias einen
Vortrag zu Primzahlfindungsalgorithmen und zur Frage, wie man in nicht-strikten
Programmiersprachen wie Haskell überhaupt sinnvoll von Laufzeit und
Laufzeitanalyse sprechen kann.

Was es mit libgccjit auf sich hat?

Auch Implementiererinnen funktionaler Programmiersprachen stehen am Ende
vor dem Problem, Programme in (effizienten) Maschinencode übersetzen
zu müssen.

Die GCC kann das schon (und zwar für ziemlich viele Architekturen),
warum das Rad also zweimal erfinden und nicht auf den GCC aufsetzen?

Dank der Bibliothek libgccjit von David Malcolm, die seit GCC 5.1
offizieller Bestandteil des GCC-Projektes ist, ist es einfach
geworden, den GCC als AOT- oder JIT-Compiler-Backend in eigene
Programme einzubinden.

Im Vortrag stellt Marc die Bibliothek vor. Wir werden so etwas über die
Erzeugung von Maschinencode lernen und einen Blick auf die
GCC-Interna werfen.

Daran anschließen könnte natürlich ein gemeinsames Projekt, einen
rudimentären Compiler für eine rudimentäre (funktionale)
Programmiersprache zu schreiben.
