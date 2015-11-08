---
title: Achtes Treffen des Curry Clubs
author: Lars
image: /images/yes-we-kan.jpg
image-alt: Yes We Kan
---

# Über Scala, Effekte und Gopher

Wie schon beim [dritten Treffen](/posts/2015-07-02-drittes-treffen.html) war wieder Scala mit von der Partie.

## Vorträge

Lars verglich Scala mit Haskell und ML und zeigte, dass Scala nicht ein "schlechteres Haskell" oder ein "besseres ML" sei, sondern eine eigene Sprache mit eigenen Konzepten.
Hauptpunkt war hier, dass in Scala viele Konzepte "first class" sind, wie z.B. Typklassen und Instanzen aus Haskell oder Module und Funktoren aus ML.
Trotzdem erhält man dann einige Komplexität, mit der es dann – als Programmierer – diszipliniert umzugehen gilt.
Der Vergleich von Programmiersprachen führt oft zu hintersinnigem Humor, aber auch Verzweiflung.
Im Vortrag besonders erwähnt wurden: [Scala vs. Haskell](https://twitter.com/tihomirb/status/577624701767319552) und [Haskell vs. SML](https://twitter.com/srpablo/status/342341342694883329) – wobei bei "SML" viele Leute nur an das tatsächlich seit über 15 Jahren untote SML/NJ denken, nicht aber an das wesentlich frischere Poly/ML oder gar die Isabelle/ML-Umgebung.
Teile des Vortrags können von einer vorherigen Iteration [nachgelesen](https://speakerdeck.com/larsrh/what-haskell-can-learn-from-scala) bzw. [nachgehört](https://skillsmatter.com/skillscasts/6592-what-haskell-can-learn-from-scala) werden.

Ingo gab eine kleine Einführung in Effektsysteme über freie Funktoren und freie Monaden.
In diesem Vortrag der Reihe "What the Kmett is a Monad" zeigte Ingo, wie man aus beliebigen Typkonstruktoren einen (freien) Funktor und aus beliebigen Funktoren eine (freie) Monade machen kann.
Als Anwendungszweck stellte er vor, wie man Effekte als einfachen Datentyp modelliert und aus diesem dann "für lau" eine passende Monade erhält, welche Programm mit diesen Effekten modellieren kann.
Anschließend kann man dann dieses Programm interpretieren und so zum Beispiel nach IO, aber auch nach andere Monaden, überführen.
Schließlich zeigte er noch das aktuelle Werk von Oleg Kiselyov, womit man zum Einen bessere Performance bekommt, zum Anderen aber auch auf einfache Art und Weise verschiedene Effekte kombinieren und modular interpretieren kann.

Sternenseemann erzählte uns zunächst vom Gopher-Protokoll, was drei Jahre vor HTTP/1.0 standardisiert worden ist.
Tatsächlich gibt es anscheinend auch noch aktive Gopher-Server, die allerdings verschiedene Erweiterungen des Protokolls benutzen.
Das Protokoll selbst ist relativ einfach strukturiert.
Als krönenden Abschluss zeigte er uns seine Serverimplementation in Haskell names "Spacecookie".
Eine entsprechende Spacecookie-Monade durfte natürlich nicht fehlen.

## Diskussionen & Sonstiges

Tim hat Curry-Club-Sticker mitgebracht.
Auf einen vorherigen Twitter-Beitrag hin hat sich ein Programmierer aus Barcelona gemeldet, der auch gerne welche hätte.
Freundlicherweise hat Tim ihm ein paar Exemplare geschickt.
Der Curry Club Augsburg ist demzufolge [international bekannt](https://twitter.com/jordi_aranda/status/662695479021555713)!

Lars wies während Ingos Vortrag, bei dem Kan-Erweiterungen vorkamen, auf den obligatorischen "Yes We Kan"-Witz hin, der auch [während der Haskell eXchange fiel](https://skillsmatter.com/skillscasts/6733-transformers-handlers-in-disguise).

Ingo setzte eine Belohnung aus: auf einen Beweis der Tatsache, dass die Listenmonade keine freie Monade ist.
