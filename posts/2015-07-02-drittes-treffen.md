---
title: Drittes Treffen des Curry Clubs
author: Profpatsch
image: /images/curry-club-03.jpg
image-alt: Bild vom Treffen
image-attr: CC BY-NC-ND 4.0
---

# Über Scala, Logik, Kategorien und Yolomorphismen

Das dritte Treffen war wieder ein sehr lehrreicher Abend gespickt mit funktionalem Witz und vielen Einblicken in tolle Themen.

## Leon

Mit [Leon][leon] wurde uns ein System vorgestellt, dass den Scala-Compiler um einige interessante Möglichkeiten erweitert; So kann man direkt Pre- und Postconditions einfügen, die dann vom Compiler mittels eines automatischen Theorembeweisers überprüft werden. Am Ende zeigte er uns dann noch, dass man sogar den Code generieren lassen kann.

## Prolog

Eine Einführung in [Prolog][pro] anhand eines praktischen Beispiels brachte uns die Vorteile und Grenzen der Sprache nahe. Das Resümee war dann, dass man Prolog sehr gut als domainspezifische Sprache über das C-Interface einbinden kann, aber es nicht als Allzweckprogrammiersprache („general Purpose“) verwenden will.

Weite Zustimmung fand die Alternative, das Logikproblem (soweit möglich) in aussagenlogische Ausdrücke zu transformieren und dann in einen [SAT-Solver][sat] zu stecken. Diese sind mittlerweile sehr schnell geworden.

## Kategorientheorie

Am Ende ging es dann nochmal in die Mathematik und Ingo gab uns eine Einführung in die Kategorientheorie. Der Vortrag war sehr gut nachvollziehbar, was unter anderem auch an den [Folien][cat] lag. Aber um es wirklich nachvollziehen zu können, muss man natürlich das Treffen besuchen. :)

Nächstes Mal gibt es die Fortsetzung.

## Zusammenfassung

Alles in allem war es ein sehr gelungener Abend und auch die Gespräche im [Sangam][san] hinterher sehr erhellend. Zum Beispiel haben wir gelernt, dass man nicht-totale Funktionen wie `head`, `tail` und `(!!)` *Yolomorphismen* nennen sollte. Zu den Yolomorphismen sollte man auch `unsafePerformIO :: IO a -> a`, sowie die Mutter aller Yolomorphismen, die Funktion `unsafeCoerce :: a -> b`, zählen.

[leon]: http://leon.epfl.ch/
[pro]: https://en.wikipedia.org/wiki/Prolog
[sat]: https://en.wikipedia.org/wiki/Boolean_satisfiability_problem#Algorithms_for_solving_SAT
[cat]: /files/was-sollen-kategorien.pdf
[san]: http://www.sangam-augsburg.de/
