---
title: Programm für das fünfzehnte Treffen am 16. Juni 2016
subtitle: Initiale Algebren, terminale Koalgebren und FTypen
meetup-announcement: 2016-06-16
meetup-counter: "15"
meetup-time: 19:00
author: Ingo Blechschmidt
---

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/wSaGjm4qqNc?list=PLwpepnYDFK9NTzNM7VTw2OoDuhKtWS6KB" frameborder="0" allowfullscreen></iframe>

Ingo stellte [Minimalwissen zu initialen Algebren und terminalen Koalgebren](/files/initiale-algebren.pdf)
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

    L = 1 + A x L.
    -- in Haskell: data L = Nil | Cons A L

Nun sind das aber nicht wirklich Gleichungen. Es sind aber auch nicht
einfach nur "Isomorphiebeziehungen". Es ist etwas dazwischen -- es sind
initiale Algebren. Jede initiale Algebra bringt jeweils ein eigenes
Konzept mit, um Funktionen aus der so definierten Struktur rekursiv
definieren zu können. Im Falle der natürlichen Zahlen ist das im
Wesentlichen das bekannte Rekursionsprinzip (definiere für 0 und
definiere für n+1).

Der Vortrag erklärte, was initiale Algebren sind, welche Vorstellung sie
fassen und wozu man sie in der Informatik verwendet. Das Thema ist für manche
Teile der theoretischen Informatik absolut grundlegend, man kann kaum über die
Semantik von Programmiersprachen (welche benutzerdefinierte Datentypen
erlauben) sprechen, ohne Minimalwissen von initialen Algebren zu haben. Auch
für den praktischen Umgang mit Rekursion sind sie interessant, da sie manche
Dinge mit einer konzeptionellen, abstrakten Interpretation versehen.

Wir gingen auch auf das Gegenstück zu initialen Algebren ein, nämlich
terminale Koalgebren. Und es gab einen "witzigen" Wettbewerb.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/CeJoWI7maMU?list=PLwpepnYDFK9NTzNM7VTw2OoDuhKtWS6KB" frameborder="0" allowfullscreen></iframe>

Tim stellt seine WIP-Haskell-Bibliothek [ftypes](https://github.com/timjb/ftypes) vor. In FTypes werden die bekannten Typklassen `Functor`, `Applicative` und `Traversable` auf Typen vom Kind `(k -> *) -> *` übertragen. Dies hat Anwendungen etwa beim Schreiben von bidirektionalen Parsern für Produkttypen.

Tim hat vergessen, ein paar Sachen zu erwähnen, die er sich eigentlich vorgenommen hatte. Darum hat er sie [hier aufgeschrieben](https://gist.github.com/timjb/275f78e9dd449671c4b76dbdbeec574c).
