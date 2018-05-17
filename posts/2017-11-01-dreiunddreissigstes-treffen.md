---
title: Programm für das dreiunddreißigste Treffen am 30. November 2017
subtitle: Church-Kodierung, Potenzreihen und Dhall
meetup-announcement: 2017-11-30
meetup-counter: "33"
meetup-time: 19:00
author: iblech
---

Matthias wird in einem Kurzvortrag (der eigentlich an unserem letzten runden
Jubiläumstreffen hätte stattfinden sollen) auf Church-Encodings abnerden. Er
erklärt auf anschauliche Art und Weise, was es mit dem gefeierten
[λ-Kalkül](https://de.wikipedia.org/wiki/Lambda-Kalk%C3%BCl) auf sich hat und
wie man ihn als Grundlage für Berechenbarkeitstheorie verwenden kann. Im
λ-Kalkül gibt es nur drei Primitiven: Funktionsanwendung, Variablen und
λ-Abstraktion. Es gibt nicht: Zahlen, Listen, Bäume, Mengen, ... Trotzdem kann
man all diese Dinge nachbauen. Matthias erklärt, wie das geht.

Simon stellt seine Haskell-Implementierung von formalen Potenzreihen vor.
Potenzreihen sind Wäscheleinen für Zahlen und kamen schon im vorletzten Vortrag
von Manuel kurz vor. sigfpe, der Urheber des [berühmten
Haskell-Blogs](http://blog.sigfpe.com/), spricht auch oft über sie.

Zum Abschluss stellt Profpatsch die mit Absicht nicht-turingvollständige
Sprache
[Dhall](https://hackage.haskell.org/package/dhall-1.8.0/docs/Dhall-Tutorial.html)
vor. Gabriel Gonzales hat diese Sprache erdacht und umgesetzt, und Profpatsch
hat ein Cheatsheet geschrieben und versucht gerade, sie nach JavaScript zu
kompilieren (mit GHCJS und nix).
