---
title: Programm für das erste Treffen am 23. April 2015
subtitle: Parserkombinatoren und typsicheres Routing
meetup-announcement: 2015-04-23
meetup-counter: 1
author: Tim Baumann
---

# Monadische Parserkombinatoren (Ingo Blechschmidt)

<div class="abstract">
  Parserkombinatoren sind ein beliebter Ansatz zur
  Programmierung von Parsern in funktionalen Sprachen. Anstatt
  Grammatiken in speziellen eingeschränkten Sprachen beschreiben zu
  müssen, steht dabei die volle Ausdrucksfähigkeit einer funktionalen
  Hochsprache zur Verfügung. Ausgehend von einigen Grundbausteinen
  kann man mit Kombinatoren beliebig komplexe Parser zusammenstellen.
  Dabei ergibt sich auf natürliche Art und Weise eine Monade.

  Beim Treffen werden wir unsere eigene kleine naive
  Kombinatorenbibliothek implementieren, Beispiele für ihren Einsatz
  durchspielen und diskutieren, was zu professionellen Lösungen
  noch fehlt. Wer Haskell einsetzt, kann danach zum Beispiel das
  beliebte Parsec verwenden.

  <p class="materials">
  [<a href="https://github.com/iblech/vortrag-haskell">Folien und Code auf Github</a>]
  </p>

  **Vorkenntnisse**: grundlegende Vertrautheit in funktionaler
    Programmierung. Monaden muss man noch nicht kennen.
</div>


# Typsicheres Routing in Haskell (Tim Baumann)

<div class="abstract">
  Routing ist die große Fallunterscheidung über die URL, die in einer Webapplikation dafür sorgt, dass jede Anfrage eine passende Antwort erhält. Eine Forderung an gute Webframeworks ist, dass sie sichergestellen, dass Links immer aktuell bleiben. Das heißt, (interne) Links sollen immer auf eine Adresse verweisen, die vom Routing-Code erkannt wird. Ich werde einen Überblick über verschiedene Lösungsansätze geben und und dann das <a href="http://www.spock.li/2015/04/19/type-safe_routing.html">Routing-System von Spock</a> genauer erklären. Dabei werden wir sehen, warum Listen auf Typlevel ein sehr nützliches Werkzeug sind.

  <p class="materials">
  [<a href="https://github.com/timjb/reroute-talk">Beispielwebseite und Code auf Github</a>]
  </p>

  **Voraussetzungen**: Oranger Gürtel in Haskell, insbesondere sind Kenntnisse des Kindsystems nützlich. Monaden werden nur am Rande vorkommen.
</div>
