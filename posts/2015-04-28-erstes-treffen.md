---
title: Erstes Treffen des Curry Clubs
author: Profpatsch
image: learn-you-a-haskell-for-great-good.png
image-alt: Learn you a Haskell for great good
image-attr: <a href="http://learnyouahaskell.com/">LearnYouAHaskell</a> (CC BY-NC-SA)
---

Am vergangenen Donnerstag hatten wir unser erstes Treffen im [OpenLab Augsburg][ola]. Es waren fast 20 Personen anwesend.

Nach einer kurzen Vorstellungsrunde ging es gleich richtig zur Sache, Ingo schrieb und beschrieb in einer Stunde einen funktionierenden Parserkombinator, der dann auch gleich auf S-Expressions losgelassen wurde. Dem Talk ist ein [eigener Blogeintrag][curry-parser] gewidmet.

Viele Zwischenfragen – auch zu esoterischeren und theoretischeren Themen – sorgten dafür, dass auch Fortgeschrittene auf ihre Kosten kamen.

Maximilian stellte seine Anwendung [mySortMaildir][msm] vor, ein Tool in Haskell, das für ihn Mails filtert und sortiert.

Tim ging im dritten Talk auf die Typebene und beschrieb das von ihm implementierte typsichere Parsing von Routen im Webframework [Spock][spock]. Er schaffte nur den ersten Teil und wird beim nächsten Treffen den Rest halten. Die Folien sind [auf Github zu finden][tsrslides] und eine zusammenfassende Beschreibung [im Blog des Projekts][tsrblog].

Zum Schluss ließ ein Teil der Anwesenden den Abend bei einem leckeren Curry im [Sangam][sg] ausklingen.


## Beim Essen haben wir unter anderem gelernt

* Der Code von [Isabelle][isabelle] war die letzten 20 Jahre über sehr gut wartbar und konnte mehrmals tiefgreifend umstrukturiert werden. Es gibt aber auch eine Funktion, die zusätzlich zu mehreren anderen Parametern fünf boolsche Flags nimmt und die sich niemand anzufassen traut. :-)
* Isabelle besitzt auch einen Kern für minimale Logik.
* Beweist man etwas [konstruktiv][konstr], so gilt die Behauptung in allen Topoi.
* ghcid ist die beste Erfindung seit geschnitten Brot. (Zur Einführung in die Konstruktive Mathematik gibt es ein [Skript von Ingo][pizza-konstr].)
* In jeder Kategorie kann man formulieren, was ein Monoid-Objekt sein soll. In der Kategorie der Mengen sind Monoid-Objekte gewöhnliche Monoide. In der Kategorie Hask sind Monoide solche Typen, denen man eine Instanz der Monoid-Typklasse spendieren kann. In Kategorien von Endofunktoren sind Monoide Monaden.
* Manchen Menschen macht es Spaß, Pi auswendig zu lernen.
* OCaml wird nicht nur von Jane Street Capital, sondern auch in Routern eingesetzt; es ist eine Art "Higher-Order C".
* Etwas Wesentliches, was OCaml fehlt, ist Multithreading, so wie auch im Falle von Emacs LISP.
* Es gibt Punkte, die sowohl für ein Informatikstudium an der Uni Augsburg sprechen als auch für ein Studium an der TU München. Eine Auswahl:
    * Uni Augsburg
        * Pro: Übersichtlich, man kennt fast jeden, Fächer sind relativ leicht zu bestehen, das [OpenLab][ola]
        * Con: Es wird hauptsächlich Java gelehrt, Windows überall
    * TU München
        * Pro: Viel Auswahl (mehr Lehrstühle), funktionale Programmierung wird gelehrt, anerkanntere Uni
        * Con: Entfernung (oder hohe Mietpreise), teils schwer in gute Übungen zu kommen


[ola]: https://openlab-augsburg.de/
[curry-parser]: 2015-05-03-wir-bauen-einen-parserkombinator.html
[msm]: https://github.com/maximilianhuber/mySortMaildir
[spock]: http://www.spock.li/
[tsrblog]: http://www.spock.li/2015/04/19/type-safe_routing.html
[tsrslides]: https://github.com/timjb/reroute-talk
[sg]:http://www.sangam-augsburg.de/
[isabelle]: https://en.wikipedia.org/wiki/Isabelle_(proof_assistant)
[konstr]: https://de.wikipedia.org/wiki/Konstruktive_Mathematik
[pizza-konstr]: http://pizzaseminar.speicherleck.de/skript2/konstruktive-mathematik.pdf
