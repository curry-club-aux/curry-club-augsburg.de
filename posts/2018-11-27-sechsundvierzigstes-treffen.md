---
title: libgccjit und libjit
subtitle:
subsubtitle: 
meetup-announcement: 2019-01-24
meetup-counter: "46"
meetup-time: 19:00
author: iblech
---

Marc trägt über libgccjit vor, Jakob nerdet auf libjit ab.

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

Was es mit libjit auf sich hat? Das ist auch von GNU, aber wurde von Anfang an
für JIT-Kompilierung geschrieben. Ursprünglich als JIT-Backend für dotGNU (die
.NET-CLR von GNU) wird es inzwischen als eigenständige Bibliothek
weiterentwickelt.

Das Vorurteil gegenüber zu JIT umgebauten Offline-Compilern ist ja, dass sie zu
viel Zeit zum Kompilieren verwenden (zum Beispiel mit schweren Optimierungen)
-- selbst bei Code, der nur ein oder wenige Male ausgeführt wird. Ein hastig
zusammengebastelter Brainfuck-JIT-Compiler mit dieser Bibliothek (in weniger
als 100 Zeilen) produziert zugegebenermaßen nicht so guten Code wie libgccjit;
dem Vorurteil gemäß könnte er, die Kompilierzeit addiert, dennoch schneller
sein.
