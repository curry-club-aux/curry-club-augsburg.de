---
title: Programm für das dreiundzwanzigste Treffen am 23. Februar 2017
subtitle: Lineare Logik
subsubtitle: why not? &ndash; of course!
meetup-announcement: 2017-02-23
meetup-counter: "23"
meetup-time: 19:00
author: Tim Baumann
---

Uwap wird eine Einführung in Lineare Logik und lineare Typsysteme geben.

Tim wird die experimentelle Programmiersprache Frank ([Paper](https://arxiv.org/pdf/1611.09259.pdf), [Implementierung](https://github.com/cmcl/frankjnr)) vorstellen.
In Frank gibt es Werte und Berechnungen. Jede Berechnung ist dabei getaggt mit den Effekten, die sie ausführen möchte. Berechnungen können an Funktionen übergeben werden. Beim Aufruf einer Berechnung müssen entweder Handler für ihre benötigten Effekte angegeben werden oder diese Effekte werden im Typsystem weiter nach außen propagiert (damit müssen sie weiter außen gehandhabt werden).

Vorteile von Frank sind:

* Es ist sehr einfach und natürlich, Code mit Nebeneffekten so abstrakt zu schreiben, dass man ihn in verschiedenen Kontexten verwenden kann und auch gut testen kann.
* Man kann rein funktionalen und effektbehafteten Code sehr gut kombinieren: In Haskell ruft man ja rein funktionalen Code aus IO-Actions auf, aber man kann nicht andersrum eine IO-Action in rein funktionalem Code verwenden. Dies führt dazu, dass viele Funktionen in einer rein funktionalen und in einer IO/monadischen Variante existieren, wie z.B. `map` und `mapM` (beide wenden eine Funktion auf jedes Element einer Liste an). In Frank hat man stattdessen eine Funktion `map : {X -> Y} -> List X -> List Y`, die man sowohl auf effektfreie Funktionen, als auch auf effektbehaftete Berechnungen anwenden kann.
