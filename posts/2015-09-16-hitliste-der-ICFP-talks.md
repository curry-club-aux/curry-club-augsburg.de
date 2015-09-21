---
title: Hitliste der Talks von der ICFP
---
[Tim](https://github.com/timjb) hat die offizielle Empfehlungsliste des Curry Clubs für Talks von der diesjährigen [ICFP](http://www.icfpconference.org/) erstellt. Wir wünschen angenehme Stunden der funktionalen Weiterbildung!

* [The State of GHC](https://www.youtube.com/watch?v=ga83zOo95bs) von Simon Peyton Jones  
  Ein Ausblick auf GHC 8.0. Pflichtvideo. (Achtung: Comic Sans in gelb
  auf blau.)

* [The State of GHCJS](https://www.youtube.com/watch?v=ZEUTndOzrvw) von Luite Stegeman  
  Kurzzusammenfassung: GHCJS ist mit GHC 7.10.2 endlich einfach zu
  installieren. Es gibt eine neue Version der GHCJS-Standardbibliothek.
  Es steht einem Praxiseinsatz von GHCJS nichts mehr im Wege!

* [Practical Probabilistic Programming with Monads](https://www.youtube.com/watch?v=hI0ajVy2xEk) von Adam Scibior  
  Eine DSL, mit der man bayesische Inferenz betreiben kann. (sehr
  interessant)

* [GADTs Meet Their Match](https://www.youtube.com/watch?v=AFSLMTgoClI) von George Karachalias  
  Wenn man in Haskell eine Funktion "a -> b" definiert, dann überprüft
  GHC, ob man mit der Definition jede mögliche Eingabe abgedeckt hat.
  Das funktioniert aber noch nicht so gut, wenn a ein GADT ist. Der
  Vortrag beschreibt einen Algorithmus, der dieses Problem löst.

* [Look Ma, No Signatures!](https://www.youtube.com/watch?v=PrDSxnO29d0) von Edward Z. Yang  
  Wie bringt man GHC bei, rekursiv voneinander abhängige Module zu
  kompilieren? (sehr unterhaltsam)

* [The Unreasonable Effectiveness of Lenses for Business Applications](https://www.youtube.com/watch?v=T88TDS7L5DY) von Edward Kmett  
  Ein Lens-Vortrag vom geliebten Propheten höchstpersönlich. Außerdem:
  Sonderpreis für den besten Vortragstitel

* [Practical Principled FRP](https://www.youtube.com/watch?v=WajfYdqCeAM) von Atze van der Ploeg  
  Untertitel: Forget the past, change the future! FRPNow!
  Ein neuer Ansatz für Functional Reactive Programming.

* [The History of Standard ML: Ideas, Principles, Culture](https://www.youtube.com/watch?v=NVEgyJCTee4) von David MacQueen  
  Von Makarius empfohlen.

* [Stack](https://www.youtube.com/watch?v=RRmb2RtU0hU) von Emanual Borsboom  
  Über die neue `cabal`-Alternative. Ich habe sehr gute Erfahrungen mit
  Stack gemacht. Im Gegensatz zu Cabal hatte ich mit Stack noch nie Probleme damit, dass verschiedene Pakete unterschiedliche Versionen von Dependencies vorausgesetzt haben. Es verwendet dazu eine kuratierte Datenbank von Paketen und Schnappschüssen von miteinander verträglichen Versionen von diesen.

* [Which simple Types have a unique Inhabitant?](https://www.youtube.com/watch?v=lNSfVpKEnnI) von Gabriel Scherer  
  Es wird ein Algorithmus skizziert, der diese Frage wird im Setting des
  einfach typisierten Lambda-Kalküls beantwortet. In komplexeren
  Typsystemen ist diese Frage unentscheidbar. Ein Algorithmus, der diese
  Frage in vielen Fällen beantwortet kann aber trotzdem hilfreich für
  Programmierer sein.

* [Future of Haskell: Dependent types](https://www.youtube.com/watch?v=W6a36RoFeNw) von Richard Eisenberg  
  Es gibt den Plan, GHC abhängige Typen beizubringen. Dieser Vortrag
  stellt kurz (in ca 5min) vor, was damit möglich sein wird. Danach gibt
  es eine lange Diskussion.

* [The Remote Monad Design Pattern](https://www.youtube.com/watch?v=guMLPr6eBLo) von Andy Gill  
  Wie man durch Bündeln von Kommandos mit möglichst wenigen
  Netzwerkzugriffen andere Geräte, wie z.B. Toaster steuert.

* [Diagrams: A Functional EDSL for Vector Graphics](https://www.youtube.com/watch?v=oAz8AEf7WDA) von Ryan Yates und Brent Yorgey  
  Über die supercoole Bibliothek [`diagrams`](http://projects.haskell.org/diagrams/), mit der man Vektorgraphiken
  mit Haskell zeichnen kann.

* [Guilt Free Ivory](https://www.youtube.com/watch?v=D1rm5SnvmKE) von Galois  
  Design einer Haskell-DSL, die sicheren C-Code für eingebettete Systeme
  erzeugt.

* [Monadic Effects](https://www.youtube.com/watch?v=NBBQoX1EWCY) von Niki Vazou und Daan Leijen  
  Beschreibt die Sprache Koka, die nach JavaScript kompiliert und ein
  Effektsystem besitzt.
  Es ist dabei möglich, eigene Effekte zu implementieren, indem man
  einfach eine Monadeninstanz schreibt.

* [Dependent Types for Real time Constraints](https://www.youtube.com/watch?v=nBaRKI5q-DI) von William Blair  
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

* [Freer Monads, More Extensible Effects](https://www.youtube.com/watch?v=3Ltgkjpme-Y) von Oleg Kiselyov ([Paper](http://okmij.org/ftp/Haskell/extensible/more.pdf))  
  Dieses Thema werden wir noch genauer im Curry Club besprechen.
  Der Vortrag baut auf den Ideen zur performanten Implementierung von freien Monaden des Papers [Reflection without remorse](http://okmij.org/ftp/Haskell/zseq.pdf) von der letztjährigen ICFP ([Video des Vortrags](https://youtube.com/watch?v=_XoI65Rxmss)) auf.

* [Dependent Types and Effects in F*](https://www.youtube.com/watch?v=bEJKKquyngk) von Nik Swamy und Catalin Hritcu  
  F* ist ein ML-Dialekt, welcher abhängige Typen, Refinement Types und
  ein Effektsystem kombiniert. Dank Einbinding eines SMT-Solvers können
  Beweise automatisiert werden. Falls der SMT-Solver scheitert, kann man
  per Hand einen Beweisterm angeben. Es kann ML-Code extrahiert werden.
  (Leider auch ein Beispiel dafür, warum man Text auf Folien auf keinen
  Fall grau machen sollte!)

* [Meta Programming and Auto Tuning in the Search for High Performance GPU Code](https://www.youtube.com/watch?v=_1_3wi_sLKo) von Michael Vollmer  
  Stellt eine DSL vor, mit der man performanten Code für die GPU schreiben kann, vor. Zur Performanceoptimierung des Codes wird eine automatisierte Suche verwendet. Der Programmierer kann die Suchparameter einstellen.

* [Injective Type Families for Haskell](https://www.youtube.com/watch?v=s0wkCKZU3WI) von Jan Stolarek  
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

* [A Typechecker Plugin for Units of Measure](https://www.youtube.com/watch?v=UizO7fZSkPY) von Adam Gundry  
  Wie man ein GHC-Typsystem-Plugin schreibt, das Haskell beibringt, mit
  physikalischen Einheiten umzugehen. So etwas ist auch in [Idris](http://www.idris-lang.org/) ohne weiteres möglich und darum gibt es eine [Idris Bibliothek von Tim](https://github.com/timjb/quantities), die genau das tut.

* [Improving Haskell Types with SMT](https://www.youtube.com/watch?v=UoPoBQRGuZM) von Iavor S. Diatchki  
  Vektoren sind Listen, die mit ihrer Länge indiziert sind. Zum Beispiel ist `v :: Vect (S (S Z)) Int` eine Liste der Länge zwei bestehend aus `Int`s.
  Beim Programmieren mit Vektoren ergeben sich häufig Situation wie die folgende: Man hat Vektoren `v :: Vect n a`, `w :: Vect m a` und einen Wert `x :: a`. Man möchte die Vektoren `v` und `w` zusammenhängen mit `x` als Seperator dazwischen, also `v ++ (x : w) :: Vect (S (n + m)) a`. Aber dieses Type Judgement ist für GHC nicht nachvollziehbar! Denn `v ++ (x : w)` hat zunächst den Typ `Vect (n + S m) a`. Dass `n + S m ~ S (n + m)` gilt, weiß GHC nicht. Aber man kann es ihm beibringen, indem man ein Typsystemplugin schreibt, welches solche Gleichheiten mit Hilfe eines SMT-Solvers löst.

* [Two can keep a Secret if one of them uses Haskell](https://www.youtube.com/watch?v=K6Uf61U0fvo) von Alejandro Russo  
  Wie man mithilfe des Typsystems das Leaken von sensiblen Daten verhindern kann. Der Programmierer schreibt seinen Code in einer Monade, welche nur Daten von bestimmter Vertraulichkeit lesen oder schreiben kann. Daten sind mit der Vertraulichkeitsebene getaggt. Mit SafeHaskell wird ein Ausbrechen aus diesem Regime verhindert.

Viel Spaß beim Ansehen!
