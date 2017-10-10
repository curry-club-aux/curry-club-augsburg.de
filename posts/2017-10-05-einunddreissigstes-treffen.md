---
title: Programm für das einunddreißigste Treffen am 5. Oktober 2017
meetup-announcement: 2017-10-05
meetup-counter: "31"
meetup-time: 19:00
author: uwap
subtitle: Logik, Buffer Overflows und SSA
---

Der angekündigte Vortrag marudor zu typisiertem JavaScript musste leider
krankheitsbedingt entfallen.

Ingo setzte mit uns die beim
[letzten Treffen begonnene](2017-09-07-dreissigstes-treffen.html)
Reise durch wundersame Phänomene der Logik fort.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/S9x181N8k_U" frameborder="0" allowfullscreen></iframe>

Richi sprach über Buffer Overflows, Arbitrary Code Execution und Format String
Exploits.

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/_moCOMcjkJs" frameborder="0" allowfullscreen></iframe>

Marc erklärte SSA: Die meisten modernen Compiler für konventionelle
Programmiersprachen (GCC, Clang, SpiderMonkey, ...) schreiben das Programm für
ihr Middle-End in "Singe-Static-Assignment-Form" um, in der es dann optimiert
wird, bevor die SSA-Form im Back-End dann in Maschinensprache umgeschrieben
wird. Jeder Compiler-Bauer muß also wissen, was SSA bedeutet. Wir geben kurz
an, um was es sich bei der SSA-Form handelt, und was das Ganze mit funktionaler
Programmierung zu tun hat (woraus sich im Übrigen auch der Grund für den
Vorteil der SSA-Form ergibt.)

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/iSLIclOTPE4" frameborder="0" allowfullscreen></iframe>