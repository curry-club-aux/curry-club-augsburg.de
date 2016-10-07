---
title: Programm für das neunzehnte Treffen am 6. Oktober 2016
subtitle: Internationalisierung, Superturingmaschinen
meetup-announcement: 2016-10-06
meetup-counter: "19"
meetup-time: 19:00
author: Ingo Blechschmidt
---

Profpatsch setzte seine Vorstellung einer pragmatischen Implementierung von
Internationalisierung (i18n) in Haskell fort.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/0N5fiDPMA7Q" frameborder="0" allowfullscreen></iframe>

Ingo begann seine Einführung in Superturingmaschinen. Da er nicht fertig geworden ist, wird der Vortrag beim nächsten Treffen fortgesetzt.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/sUqwFbbwHQo" frameborder="0" allowfullscreen></iframe>

Superturingmaschinen können anders
als ihre bekannten Verwandten "länger als unendlich lange" laufen. Das drückt
sich mathematisch dadurch aus, dass die Nummer des aktuellen Zeitschritts nicht
mehr eine natürliche Zahl sein muss (Zeitschritt 0, Zeitschritt 1, …),
sondern auch eine sog. unendliche Ordinalzahl sein kann (Zeitschritt ω,
Zeitschritt ω+1, …).

Viele Probleme, die für gewöhnliche Turingmaschinen unlösbar sind, erledigen
Superturingmaschinen mit Links: Zum Beispiel können Superturingmaschinen leicht
zahlentheoretische Vermutungen überprüfen (einfach alle Zahlen durchgehen und
nach einem Gegenbeispiel suchen; wenn nach unendlich vielen Schritten keines
gefunden wurde, stimmt die Vermutung) oder entscheiden, ob eine gewöhnliche
Turingmaschine anhält oder nicht.

Superturingmaschinen können aber trotzdem längst nicht "alles". Es gibt
Probleme, die auch Superturingmaschinen bewiesenermaßen nicht lösen können.

Der Vortrag wird in die Theorie der Superturingmaschinen einführen, welche in
mancherlei Hinsicht parallel zur klassischen Theorie verläuft, sich in manchen
Punkten aber auch deutlich von ihr unterscheidet. Wir werden unter anderem
folgende Facetten diskutieren:

* Wie geht man präzise mit mehr als unendlich vielen Zeitschritten um?
  Wie kann man sich Superturingmaschinen physikalisch vorstellen?
  (Kurzer Crashkurs in Ordinalzahlen.)

* Nach der kleinsten unendlich großen Ordinalzahl gibt es eine echte Klasse
  weiterer unendlich großer Ordinalzahlen. Gibt es zu jeder solchen Zahl eine
  Superturingmaschine, die nach genau so vielen Schritten hält?

* Man schreibt Superturingmaschinen keine Maximalzahl zu verwendender
  Zeitschritte vor. Erstaunlicherweise gibt es trotzdem einen gewissen
  transfiniten Zeitpunkt, ab dem sich eine Superturingmaschine in ihrem
  Verhalten endlos wiederholen wird.

* Wo liegen die Grenzen des Möglichen für Superturingmaschinen?

* Manchmal kann man zwar ein gewisses Lied erkennen, wenn man es hört, es aber
  nicht vorsingen. Bei Superturingmaschinen gibt es dieses
  *Lost-Melody-Phänomen* ebenfalls: Sie können entscheiden, ob auf dem Band ein
  gewisser vorgegebener Inhalt steht, sind aber nicht in der Lage, diesen
  Inhalt selbst zu produzieren. Wieso?

* Jedes Berechenbarkeitskonzept – wie etwa das von realen Computern in der
  realen Welt, das von idealisierten Turingmaschinen und das von
  Superturingmaschinen – zieht ein mathematisches Alternativuniversum mit
  jeweils eigenen Gesetzen der Logik mit sich, einen "effektiven Topos".
  Insbesondere das Universum, welches zu Superturingmaschinen gehört, hat
  faszinierende Eigenschaften.

Originalquellen zum Thema sind der wegweisende Artikel von Joel Hamkins und
Andy Lewis [Infinite Time Turing Machines](http://arxiv.org/abs/math/9808093)
(Vorsicht Spoiler!) und zwei schöne Aufsätze von Andrej Bauer:
[Intuitionistic Mathematics and Realizability in the Physical
World](http://math.andrej.com/wp-content/uploads/2014/03/real-world-realizability.pdf)
und [Realizability as the Connection between Computable and Constructive
Mathematics](http://math.andrej.com/data/c2c.pdf). Um den Vortrag genießen zu
können, sollte man nur in seinem Leben irgendwann einmal gelernt haben, was
eine Turingmaschine ist (das erste Drittel des Wikipedia-Eintrags genügt
dazu völlig). Weitere Vorkenntnisse werden nicht vorausgesetzt.
