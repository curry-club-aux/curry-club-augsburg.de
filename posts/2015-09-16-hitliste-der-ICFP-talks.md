---
title: Hitliste der Talks von der ICFP
---
[Tim](https://github.com/timjb) hat die offizielle Curry Club Empfehlungsliste für Talks von der diesjährigen [ICFP](http://www.icfpconference.org/) erstellt. Wir wünschen angenehme Stunden der funktionalen Weiterbildung!

* [The State of GHC von SPJ](https://www.youtube.com/watch?v=ga83zOo95bs)
  Ein Ausblick auf GHC 8.0. Pflichtvideo. (Achtung: Comic Sans in gelb
  auf blau.)

* [The State of GHCJS von Luite Stegeman](https://www.youtube.com/watch?v=ZEUTndOzrvw)
  Kurzzusammenfassung: GHCJS ist mit GHC 7.10.2 endlich einfach zu
  installieren. Es gibt eine neue Version der GHCJS-Standardbibliothek.
  Es steht einem Praxiseinsatz von GHCJS nichts mehr im Wege!

* [Practical Probabilistic Programming with Monads von Adam Scibior](https://www.youtube.com/watch?v=hI0ajVy2xEk)
  Eine DSL, mit der man bayesische Inferenz betreiben kann. (sehr
  interessant)

* [GADTs Meet Their Match von George Karachalias](https://www.youtube.com/watch?v=AFSLMTgoClI)
  Wenn man in Haskell eine Funktion "a -> b" definiert, dann überprüft
  GHC, ob man mit der Definition jeden mögliche Eingabe abgedeckt hat.
  Das funktioniert aber noch nicht so gut, wenn a ein GADT ist. Der
  Vortrag beschreibt einen Algorithmus, der dieses Problem löst.

* [Look Ma, No Signatures! von Edward Z. Yang](https://www.youtube.com/watch?v=PrDSxnO29d0)
  Wie bringt man GHC bei, rekursiv voneinander abhängige Module zu
  kompilieren? (sehr unterhaltsam)

* [The Unreasonable Effectiveness of Lenses for Business Applications von
Edward Kmett](https://www.youtube.com/watch?v=T88TDS7L5DY)
  Ein Lens-Vortrag vom geliebten Propheten höchstpersönlich. Außerdem:
  Sonderpreis für den besten Vortragstitel

* [Practical Principled FRP von Atze van der Ploeg](https://www.youtube.com/watch?v=WajfYdqCeAM)
  Untertitel: Forget the past, change the future! FRPNow!
  Ein neuer Ansatz für Functional Reactive Programming.

* [The History of Standard ML: Ideas, Principles, Culture](https://www.youtube.com/watch?v=NVEgyJCTee4)
  Von Makarius empfohlen.

* [Stack](https://www.youtube.com/watch?v=RRmb2RtU0hU)
  Über die neue "cabal"-Alternative. Ich habe sehr gute Erfahrungen mit
  Stack gemacht. Das Tool tut einfach zuverlässig das, was es soll, ohne
  große Dependency-Schwierigkeiten, wobei es aber auf ältere Pakete setzt, also auf Hackage verfügbar.

* [Which simple Types have a unique Inhabitant? von Gabriel Scherer](https://www.youtube.com/watch?v=lNSfVpKEnnI)
  Es wird ein Algorithmus skizziert, der diese Frage wird im Setting des
  einfach typisierten Lambda-Kalküls beantwortet. In komplexeren
  Typsystemen ist diese Frage unentscheidbar. Ein Algorithmus, der diese
  Frage in vielen Fällen beantwortet kann aber trotzdem hilfreich für
  Programmierer sein.

* [Future of Haskell: Dependent types von Richard Eisenberg](https://www.youtube.com/watch?v=W6a36RoFeNw)
  Es gibt den Plan, GHC abhängige Typen beizubringen. Dieser Vortrag
  stellt kurz (in ca 5min) vor, was damit möglich sein wird. Danach gibt
  es eine lange Diskussion.

* [The Remote Monad Design Pattern](https://www.youtube.com/watch?v=guMLPr6eBLo)
  Wie man durch Bündeln von Kommandos mit möglichst wenigen
  Netzwerkzugriffen andere Geräte, wie z.B. Toaster steuert.

* [Diagrams: a Functional EDSL for Vector Graphics](https://www.youtube.com/watch?v=oAz8AEf7WDA)
  Über die supercoole Bibliothek diagrams, mit der man Vektorgraphiken
  mit Haskell zeichnen kann.

* [Guilt Free Ivory](https://www.youtube.com/watch?v=D1rm5SnvmKE)
  Design einer Haskell-DSL, die sicheren C-Code für eingebettete Systeme
  erzeugt.

* [Monadic Effects](https://www.youtube.com/watch?v=NBBQoX1EWCY)
  Beschreibt die Sprache Koka, die nach JavaScript kompiliert und ein
  Effektsystem besitzt.
  Es ist dabei möglich, eigene Effekte zu implementieren, indem man
  einfach eine Monadeninstanz schreibt.

* [Dependent Types for Real time Constraints](https://www.youtube.com/watch?v=nBaRKI5q-DI)
  Für Real-Time-Systeme (z.B. der Flugkontrolle in einem Flugzeug) gibt
  es synchrone Programmiersprachen: Diese besitzen einen globalen
  Taktgeber. Zu jedem Takt werden Daten von Sensoren ausgelesen,
  Berechnungen ausgeführt oder Anweisungen an andere Systeme geschickt.
  Nun möchte man in so einem System vielleicht auch Berechnungen haben,
  die länger dauern als einen Takt, z.B. 10 Takte. Diese müssen mit
  anderen Berechnungen synchronisiert werden. Um zu überprüfen, dass
  alle Prozesse aufeinander abgestimmt sind (z.B. ein Prozess erwartet
  einen Input von einem anderem Prozess genau zu dem Takt wo der andere
  Prozess fertig ist), kann man abhängige Typen verwenden.

* [Freer Monads, More Extensible Effects von Oleg Kiselyov](https://www.youtube.com/watch?v=3Ltgkjpme-Y)
  Das [zugehörige Paper findet man auch hier](http://okmij.org/ftp/Haskell/extensible/more.pdf). Und [so implementiert man performante freie Monaden](http://okmij.org/ftp/Haskell/zseq.pdf).
  Dieses Thema werden wir noch genauer im Curry Club besprechen.

* [Dependent Types and Effects in F*](https://www.youtube.com/watch?v=bEJKKquyngk)
  F* ist ein ML-Dialekt, welcher abhängige Typen, Refinement Types und
  ein Effektsystem kombiniert. Dank Einbinding eines SMT-Solvers können
  Beweise automatisiert werden. Falls der SMT-Solver scheitert, kann man
  per Hand einen Beweisterm angeben. Es kann ML-Code extrahiert werden.
  (Leider auch ein Beispiel dafür, warum man Text auf Folien auf keinen
  Fall grau machen sollte!)

* [Meta Programming and Auto Tuning in the Search for High Performance GPU Code](https://www.youtube.com/watch?v=_1_3wi_sLKo)
  Stellt eine DSL vor, mit der man performanten Code für die GPU vor. Es
  stellt sich heraus, dass man dafür dem Programmierer etwas Kontrolle
  über die Wahl des Optimierungsalgorithmus geben muss.

* [Injective Type Families for Haskell](https://www.youtube.com/watch?v=s0wkCKZU3WI)
  Wenn man Haskell programmiert, ist man manchmal gezwungen,
  Phantom-Parameter einzuführen, deren einziger Zweck es ist, einen Typ
  eindeutig festzulegen. In vielen Fällen liegt das daran, dass
  Typfamilien nicht injektiv sind. Das bedeutet, dass wenn TF eine
  Typfamilie vom Kind * -> * ist, man nicht vom Typ `TF a` auf den Typ
  `a` schließen kann. Deswegen kann man nicht einfach die Typsignatur
  `TF a -> Int` verwenden, sondern muss noch einen Phantomtyp einführen:
  `phantom a -> TF a -> Int`. (Ich hab leider kein Beispiel aus dem
  echten Leben zur Hand.) Dieser Vortrag beschreibt, wie man in Zukunft
  bestimmte Typfamilien in GHC als injektiv kennzeichnen kann.

* [A Typechecker Plugin for Units of Measure von Adam Gundry](https://www.youtube.com/watch?v=UizO7fZSkPY)
  Wie man ein GHC-Typsystem-Plugin schreibt, das Haskell beibringt, mit
  physikalischen Einheiten umzugehen. So etwas ist auch in [Idris](http://www.idris-lang.org/) ohne weiteres möglich und darum gibt es eine [Idris Bibliothek von Tim](https://github.com/timjb/quantities), die genau das tut.

Viel Spaß beim Ansehen!
