---
title: Programm für das einunddreißigste Treffen am 5. Oktober 2017
meetup-announcement: 2017-10-05
meetup-counter: "31"
meetup-time: 19:00
author: uwap
subtitle: Logik, Buffer Overflows und SSA
---

Der angekündigte Vortrag marudor zu typisiertem JavaScript muss leider
krankheitsbedingt entfallen.

Ingo wird mit uns die beim
[letzten Treffen begonnene](2017-09-07-dreissigstes-treffen.html)
Reise durch wundersame Phänomene der Logik fortsetzen.

Wir widmen uns Beispielen und Anwendungen von Gödels Unvollständigkeitssatz in der theoretischen
Informatik: Es gibt Computerprogramme (offiziell Turingmaschinen), deren
Halteverhalten unentscheidbar ist – von denen also bewiesen wurde, dass weder
ein Beweis, dass sie halten, noch ein Beweis, dass sie nicht halten, möglich
ist. Ein [Resultat aus dem Jahr
2016](https://www.scottaaronson.com/blog/?p=2725) zeigt, dass solche Programme
schon sehr kurz sein können.

Andere Programme verändern ihr Verhalten je nach dem, in welchem mathematischen
Alternativuniversum sie ausgeführt werden. Was diese seltsam anmutende
Behauptung bedeutet, und wie sich diese Programme in der realen Welt verhalten,
wird im Vortrag klar werden.

Wir schließen mit einem besonderen binären Baum von Kleene und einem Beispiel,
das zeigt, dass es Situationen gibt, in denen man nur mit Verwendung von Zufall
weiterkommt und keine deterministische Alternative existiert.

Richi spricht über Buffer Overflows, Arbitrary Code Execution und Format String
Exploits.

Marc erklärt SSA: Die meisten modernen Compiler für konventionelle
Programmiersprachen (GCC, Clang, SpiderMonkey, ...) schreiben das Programm für
ihr Middle-End in "Singe-Static-Assignment-Form" um, in der es dann optimiert
wird, bevor die SSA-Form im Back-End dann in Maschinensprache umgeschrieben
wird. Jeder Compiler-Bauer muß also wissen, was SSA bedeutet. Wir geben kurz
an, um was es sich bei der SSA-Form handelt, und was das Ganze mit funktionaler
Programmierung zu tun hat (woraus sich im Übrigen auch der Grund für den
Vorteil der SSA-Form ergibt.)
