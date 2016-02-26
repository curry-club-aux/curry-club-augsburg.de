---
title: Programm für das elfte Treffen am 25. Februar 2016
subtitle: Kombinatorische Spieltheorie und verifizierte Analyse von Firewall-Regeln
meetup-announcement: 2016-02-25
meetup-counter: 11
meetup-time: 19:00
author: Ingo Blechschmidt
---

Makarius gibt (diesmal wirklich) eine Einführung in *Programme und Beweise in Isabelle/HOL*.
Inhaltlich werden das einige formale Fußnoten in klassicher Mathematik
zu [scheinbar unmöglichen funktionalen
Programmen](https://www.youtube.com/watch?v=F53aOAW9PBo)
sowie eine Nacharbeit zu
den beiden Haskell-Workshops ([erstes
Übungsblatt](https://curry-club-aux.github.io/haskell-workshop/uebung.pdf),
[zweites
Übungsblatt](https://curry-club-aux.github.io/haskell-workshop/uebung2.pdf))
sein. Bei der Gelegenheit können wir auch den ersten Release Candidate von
Isabelle2016 feiern, der am Tag des Treffens wahrscheinlich veröffentlicht
wird. **Update:** Der Vortrag muss leider krankheitsbedingt entfallen. Er wird
beim nächsten Treffen nachgeholt.

Sternenseemann stellt generische Programmierung mit GHC.Generics vor.
**Update:** Entfällt wegen Krankheit und wird nachgeholt.
<!-- Lars hält
vielleicht einen Vortrag über das Scala-Äquivalent
[shapeless](https://github.com/milessabin/shapeless). -->

Profpatsch zeigt einen Trick, der Lens und Generics verbindet, um sehr fragwürdige Dinge zu erreichen.
**Update:** Entfällt und wird nachgeholt.

Cornelius spricht über *Verified Firewall Ruleset Analysis*. Diesen Vortrag hat
er schon auf dem Kongress gehalten; im Curry Club gibt's Details.
Ingo stellt kombinatorische Spieltheorie mit surrealen Zahlen und Haskell vor.

<!--more-->

> **Kombinatorische Spieltheorie mit surrealen Zahlen und Haskell**
>
> Rundenbasierte Zwei-Personen-Spiele, die keinerlei Zufallselemente
> enthalten und nicht mit verborgenen Informationen arbeiten, lassen
> sich mit einer wunderschönen mathematischen Theorie beschreiben.
> ("Schach", nicht "Fußball".)
> 
> Dabei ordnet man jeder Spielsituation einen gewissen Wert zu. Ist
> dieser positiv, gewinnt der eine Spieler; ist sie negativ, gewinnt
> der andere. Wenn eine Situation in zwei unabhängige Teile zerfällt,
> ist der zugeordnete Wert die Summe der Einzelwerte.
> 
> Gewöhnliche Zahlen genügen dafür aber nicht! Man verwendet
> stattdessen surreale Zahlen (und eine leichte Variante), eine
> elegante Neuschöpfung und weitreichende Verallgemeinerung der
> gewöhnlichen bekannten Zahlen. In den surrealen Zahlen haben
> Ausdrücke wie "unendlich", "unendlich plus 1" und "unendlich minus
> 37" eine sinnvolle Bedeutung und werden in der Spielanalyse
> anschaulich.
> 
> Die grundlegenden Operationen mit surrealen Zahlen kann man elegant
> in Haskell implementieren. Mathematische Vorkenntnisse benötigt man
> dafür nicht, da man alles an grafischen Spielen ablesen kann. Damit
> können wir dann Gewinnstrategien für diverse Spiele berechnen lassen.
>
> ["Folien"](http://rawgit.com/iblech/vortrag-haskell/master/surreal.pdf),
> [Quellcode](https://github.com/iblech/vortrag-haskell/blob/master/surreal.hs)

> **Verified Firewall Ruleset Analysis**
>
> We develop a tool to verify Linux netfilter/iptables firewalls rulesets. Then,
> we verify the verification tool itself.
> 
> Warning: involves math!
> 
> This talk is also an introduction to interactive theorem proving and
> programming in Isabelle/HOL. We strongly suggest that audience members have
> some familiarity with functional programming. A strong mathematical background
> is NOT required.
> 
> TL;DR: Math is cool again, we now have the tools for "executable math". Also:
> iptables!
