---
title: Programm für das dreiundzwanzigste Treffen am 23. Februar 2017
subtitle: Frank und Continuations
meetup-announcement: 2017-02-23
meetup-counter: "23"
meetup-time: 19:00
author: Tim Baumann
---

Tim wird die experimentelle Programmiersprache Frank ([Paper](https://arxiv.org/pdf/1611.09259.pdf), [Implementierung](https://github.com/cmcl/frankjnr)) vorstellen.
In Frank gibt es Werte und Berechnungen. Jede Berechnung ist dabei getaggt mit den Effekten, die sie ausführen möchte. Berechnungen können an Funktionen übergeben werden. Beim Aufruf einer Berechnung müssen entweder Handler für ihre benötigten Effekte angegeben werden oder diese Effekte werden im Typsystem weiter nach außen propagiert (damit müssen sie weiter außen gehandhabt werden).

Vorteile von Frank sind:

* Es ist sehr einfach und natürlich, Code mit Nebeneffekten so abstrakt zu schreiben, dass man ihn in verschiedenen Kontexten verwenden kann und auch gut testen kann.
* Man kann rein funktionalen und effektbehafteten Code sehr gut kombinieren: In Haskell ruft man ja rein funktionalen Code aus IO-Actions auf, aber man kann nicht andersrum eine IO-Action in rein funktionalem Code verwenden. Dies führt dazu, dass viele Funktionen in einer rein funktionalen und in einer IO/monadischen Variante existieren, wie z.B. `map` und `mapM` (beide wenden eine Funktion auf jedes Element einer Liste an). In Frank hat man stattdessen eine Funktion `map : {X -> Y} -> List X -> List Y`, die man sowohl auf effektfreie Funktionen, als auch auf effektbehaftete Berechnungen anwenden kann.

Ingo wird etwa über Continuations erzählen. Worauf der Schwerpunkt gesetzt
werden sollen, entscheiden die Anwesenden. Möglichkeiten umfassen:

* Tutorial zum Umgang mit Continuations: Was sind Continuations? Wie geht man
  mit ihnen um? Welche Vorteile haben Sprachen, die Continuations eingebaut
  haben (wie etwa Scheme) oder die in einer angenehmen Syntax mit Continuations
  nachgerüstet werden können (wie etwa Haskell mit der Continuation-Monade)?
  Was hat es mit der CPS-Transformation auf sich? Wie kann man dank
  Continuations OpenGL-Grafikprogrammierung so aussehen lassen, als ob man in
  QBASIC der 90er Jahre programmiert? Sind Continuations auch gefährlich? Wieso
  sagt alle Welt, dass die Continuation-Monade die Mutter aller Monaden sei?

* Konstruktive Mathematik ist nicht nur ein Teil von klassischer Mathematik
  (das ist klar: alles, was man konstruktiv beweisen kann, gilt auch
  klassisch), sondern umgekehrt ist vermöge der "Doppelnegationsübersetzung"
  auch klassische Mathematik ein Teil von konstruktiver Mathematik. Mit der
  richtigen Brille (der Curry–Howard-Brille) betrachtet, ist die
  Doppelnegationsübersetzung genau dasselbe wie die CPS-Transformation.

  Die Doppelnegationsübersetzung wurde in den 30ern entdeckt, die
  CPS-Transformation in den 70ern. In den 90ern wurde offenbar, dass es sich um
  dieselbe Entdeckung handelte.

Christine leitet anschließend eine Diskussionsrunde nach dem
OpenSpace- oder LeanCoffee-Format an.
