---
title: Programm für das fünfzehnte Treffen am 16. Juni 2016
subtitle: Initiale Algebren, Cobra, Homotopietyptheorie
meetup-announcement: 2016-06-16
meetup-counter: "15"
meetup-time: 19:00
author: Ingo Blechschmidt
---

Ingo stellt Minimalwissen zu initialen Algebren und terminalen Koalgebren
bereit. Diese verwendet man (unter anderem), um Datentypen mathematisch zu
modellieren. In Form von Cata- und Anamorphismen haben sie aber auch eine ganz
praktische Bedeutung in der Abstraktion von bekannten Rekursionsmustern.

Initiale Algebren und terminale Koalgebren untersucht man deswegen, weil sie
einen geeigneten Rahmen geben, um Fixpunktgleichungen für *Strukturen* (statt
*Zahlen* oder *Elemente* von Datentypen) zu verstehen.

Zum Beispiel ist die Struktur der natürlichen Zahlen eine Lösung von
folgender Fixpunktgleichung:

    N = 1 + N
    -- mit der rechten Seite ist gemeint: {*} disjunkt-vereinigt-mit N
    -- in Haskell würde man schreiben: data N = Zero | Succ N

Die Struktur der endlichen Listen mit Einträgen aus A ist eine Lösung von

    L = 1 + A x N.

Nun sind das aber nicht wirklich Gleichungen. Es sind aber auch nicht
einfach nur "Isomorphiebeziehungen". Es ist etwas dazwischen -- es sind
initiale Algebren. Jede initiale Algebra bringt jeweils ein eigenes
Konzept mit, um Funktionen aus der so definierten Struktur rekursiv
definieren zu können. Im Falle der natürlichen Zahlen ist das im
Wesentlichen das bekannte Rekursionsprinzip (definiere für 0 und
definiere für n+1).

Der Vortrag wird erklären, was initiale Algebren sind, welche Vorstellung sie
fassen und wozu man sie in der Informatik verwendet. Das Thema ist für manche
Teile der theoretischen Informatik absolut grundlegend, man kann kaum über die
Semantik von Programmiersprachen (welche benutzerdefinierte Datentypen
erlauben) sprechen, ohne Minimalwissen von initialen Algebren zu haben. Auch
für den praktischen Umgang mit Rekursion sind sie interessant, da sie manche
Dinge mit einer konzeptionellen, abstrakten Interpretation versehen.

Wir werden auch auf das Gegenstück zu initialen Algebren eingehen, nämlich
terminale Koalgebren. Und es wird einen "witzigen" Wettbewerb geben.

Makarius stellt [Cobra](http://www.flatmap.net/cobra) vor, ein modernes
Framework, um Code und Beweise zu präsentieren. Cobra unterstützt
Isabelle-Beweise sowie Scala- und Haskell-Code.

Tim stellt seine WIP-Haskell-Bibliothek [ftypes](https://github.com/timjb/ftypes) vor. In FTypes werden die bekannten Typklassen `Functor`, `Applicative` und `Traversable` auf Typen vom Kind `(k -> *) -> *` übertragen. Dies hat Anwendungen etwa beim Schreiben von bidirektionalen Parsern für Produkttypen.

Ingo beginnt eine Einführung in Homotopietyptheorie. Homotopietyptheorie ist
ein neuer Zweig der Mathematik, der Aspekte von verschiedenen anderen
Teilgebieten der Mathematik auf verblüffende Art und Weise kombiniert. Es ist
Teil von Voevoedskys Programm zu einer *univalenten Grundlegung* der Mathematik
und basiert auf einer kürzlich entdeckten Verbindung zwischen Homotopietheorie
aus der Mathematik und Typtheorie aus der Logik und theoretischen Informatik.

In gewöhnlichen Zugängen zu einer Grundlegung der Mathematik unterscheidet man
zwischen Objekten (wie zum Beispiel natürlichen Zahlen und Mengen) und Aussagen
über diese Objekte. In Homotopietyptheorie gibt es diese Unterscheidung nicht.
Objekte und Aussagen über Objekte werden auf eine gemeinsame Stufe gestellt.
Beweisen und Konstruieren werden miteinander identifiziert.

Der Vortrag setzt keine Vorkenntnisse aus Logik und Typtheorie und
selbstverständlich auch keine aus Homotopietheorie voraus. Der Vortrag ist für
Leute konzipiert, die sich für diese neue Bewegung in der Logik interessieren,
aber nicht praktizierende Mathematikerinnen sind.

Er wird folgende Fragen klären: Was hat es mit Homotopietyptheorie auf sich?
Wie werden in Homotopietyptheorie Objekte und Aussagen miteinander vereint, auf
eine Stufe gestellt? Wozu ist Homotopietyptheorie gut? Wieso und für wen ist
sie interessant?

Ein Teil der Antwort auf die letzte Frage lautet: Homotopietyptheorie ist für
Leute interessant, die computergestützt Beweise führen möchten.
