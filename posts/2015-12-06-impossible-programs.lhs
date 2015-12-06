---
title: Scheinbar unmögliche Programme
author: Ingo Blechschmidt
---
> {-# LANGUAGE FlexibleInstances #-}
> module Main where
>
> import Data.Maybe

Mit `[Bool]` meinen wir den Typ der unendlichen 0/1-Folgen.

> p1, p2, p3 :: [Bool] -> Bool
> p1 xs = xs!!3
> p2 xs = xs!!4
> p3 xs = xs!!(2+1) && (xs!!8 || not (xs!!8))

> test1 = p1 == p2
> test2 = p1 == p3

Das liefert einen Fehler über eine fehlende `Eq`-Instanz, oder?
Weit gefehlt! Beide Programme terminieren. `test1` hat den Wert `False`,
`test2` hat den Wert `True`.

Das ist umso erstaunlicher, wenn man bedenkt, dass `[Bool]` *überabzahlbar
unendlich groß ist*.


**Hintergrund: Abzählbarkeit und Überabzählbarkeit**

Eine Menge heißt genau dann *abzählbar*, wenn es eine unendliche Liste gibt, in
der alle Elemente der Menge vorkommen.

Prototypbeispiel: Die Menge N der natürlichen Zahlen ist abzählbar.

    0, 1, 2, 3, 4, ...

Die Menge Z der ganzen Zahlen ist ebenfalls abzählbar, insbesondere also genau
so groß wie die Menge der natürlichen Zahlen:

    0, 1, -1, 2, -2, 3, -3, 4, -4, 5, -5, ...

Übungsaufgabe: Zeige, dass auch die Menge Q der rationalen Zahlen abzählbar ist.

Eine Menge heißt genau dann *überabzählbar*, wenn sie nicht abzählbar ist.

Beispiel (Cantor): Die Menge R der reellen Zahlen ist überabzählbar.

Oder: Die Menge [Bool] aller unendlichen 0/1-Folgen ist überabzählbar.

Beweis durch das Cantorsche Diagonalargument:

Keine Liste von 0/1-Folgen kann *alle* 0/1-Folgen enthalten. Denn wenn zum
Beispiel folgende Liste gegeben ist:

<pre>
01000101011011011...
11101011111101111...
10101010101010101...
11100011100010010...
10010101100100000...
11010101100100000...
.
.
.
</pre>

Wenn man nun die Diagonale (von oben links nach unten rechts) durchgeht,
und jeweils die Gegenziffer wählt, erhält man eine 0/1-Folge, die sicher
nicht in der Liste vorkommt. Im Beispiel wäre das

<pre>100110...</pre>

Diese 0/1-Folge kann nicht das erste Element der Liste sein, denn sie
unterscheidet sich vom ersten Element ja an der vordersten Stelle. Sie kann
auch nicht das zweite Element der Liste sein, denn sie unterscheidet sich
vom zweiten Element ja an der zweitvordersten Stelle. Und so weiter!



**Epsilon**

Sei `p :: [Bool] -> Bool` ein beliebiges Prädikat.

Falls `p` erfüllbar ist, d.h. falls es eine 0/1-Folge `xs` gibt, sodass `p xs`,
dann soll `epsilon p` irgendeine 0/1-Folge sein, sodass `p (epsilon p)`.

Falls `p` nicht erfüllbar ist, dann kann `epsilon p` sein, was es möchte.

> epsilon :: ([Bool] -> Bool) -> [Bool]
> epsilon p = if p (False : xs)
>     then False : xs
>     else True  : epsilon (p . (True:))
>     where xs = epsilon (p . (False:))

Etwas schneller geht es dank Lazyness so:

    epsilon :: ([Bool] -> Bool) -> [Bool]
    epsilon p = h : epsilon (p . (h:))
        where
        h = not $ p (False : epsilon (p . (False:)))

Wer es noch schneller möchte -- sodass auch Code wie `epsilon $ \xs -> xs !!
(10^10)` funktioniert, kann sich den Code von Martín Escardó ansehen.


**exists**

Sei `p :: [Bool] -> Bool` ein beliebiges Prädikat.

Falls `p` erfüllbar ist, dann soll `exists p` ein Zeuge dieser Erfüllbarkeit
sein (in einem Maybe verpackt), also eine 0/1-Folge `xs`, sodass `p xs`.

Falls `p` nicht erfüllbar ist, soll `exists p` `Nothing` sein.

> exists :: ([Bool] -> Bool) -> Maybe [Bool]
> exists p = if p xs then Just xs else Nothing
>     where xs = epsilon p


**forall**

Sei `p :: [Bool] -> Bool` ein beliebiges Prädikat.

`forall p` soll dann und nur dann True sein, falls ``p auf jeder 0/1-Folge
konstant `True` ist.

> forall :: ([Bool] -> Bool) -> Bool
> forall p = isNothing $ exists (not . p)

Punktfrei geht es auch:

`forall = not . isJust . exists . (not .)`


**Eq-Instanz für Funktionen [Bool] -> Bool**

> instance Eq ([Bool] -> Bool) where
>     f == g = forall $ \xs -> f xs == g xs
>     -- "zwei Prädikate sind genau dann gleich, wenn sie auf jedem Argument
>     -- gleich sind"


**Exkurs: Beispiel für eine unstetige Funktion**

Eine Funktion von R nach R ist genau dann stetig, wenn man ihren Graph zeichnen
kann, ohne den Stift abzusetzen. Eine stetige Funktion darf also keine
Sprungstellen besitzen.

<pre>
f : R --> R

x |-> if x < 0 then -1 else if x == 0 then 0 else 1

</pre>

Die Signumfunktion!

Sie ist aber nur definiert auf der Teilmenge

<pre>{ x in R | x < 0 oder x = 0 oder x > 0 }.</pre>

Konstruktiv kann man nicht zeigen, dass diese Teilmenge ganz R ist.
Die Funktion ist also nicht als total nachweisbar.


**Wieso funktionieren die "scheinbar unmöglichen Programme"?**

1. In Haskell kann man nur stetige Funktionen implementieren. (Wie in manchen
   Schulen konstruktiver Mathematik auch.) Jede Funktion vom Typ `[Bool] -> Bool`
   ist stetig.

2. In der Topologie gibt es folgenden Satz: Jede stetige Funktion, deren
   Definitionsmenge kompakt ist, ist schon gleichmäßig stetig.

   Die Menge `[Bool]` ist kompakt. (Eigentlich sollte man "Raum" statt "Menge"
   sagen. Für Topologie-Fans: Das folgt sofort aus dem Satz von Tychonoff.)

3. Im Spezialfall von Funktionen `[Bool] -> Bool` bedeutet gleichmäßig
   stetig: Eine solche Funktion ist genau dann gleichmäßig stetig, wenn es eine
   Schranke `m` gibt, sodass die Funktion zur Berechnung ihres Ergebnisses nur
   die ersten `m` Bits der Folge benötigt (unabhängig von der speziellen
   Eingabefolge).

4. `epsilon` ruft sich selbst rekursiv auf. Wenn `p` als Schranke `m` hat, dann
   hat das im rekursiven Aufruf verwendete Prädikat `(p . (False:))` als
   Schranke `m-1`. Also terminiert nach `m` rekursiven Aufrufen das Verfahren.


**Und die Moral von der Geschicht**

In der Frage, ob Gleichheit von Funktionen vom Typ `A -> Bool` entscheidbar
ist, ist es nicht relevant, ob `A` endlich ist oder nicht. Tatsächlich
entscheidend ist, ob `A` *kompakt* ist oder nicht.

* Endliche Typen sind kompakt.
* `[Bool]` ist kompakt.
* Sind `A` und `B` kompakt, so auch der Produkttyp `(A,B)`.
* `Nat` und `Integer` sind nicht kompakt.
* Der Datentyp der "lazy naturals", welche auch `+infty` enthalten, ist kompakt.

**Übungsaufgaben:**

1. Übertrage die Funktion `epsilon` -- und damit auch `exists` und `forall`,
   auf den Fall von Funktionen `NAT -> Bool` (statt `[Bool] -> Bool`). Dabei
   soll `NAT` der Typ der "lazy naturals" sein, zum Beispiel definiert durch:

   `data NAT = Zero | Succ NAT`

   `infty = Succ infty`

2. Definiere eine Typklasse `Compact` und implementiere Instanzen für
   `[Bool]` und `NAT` sowie eine generische Instanz `(Compact a, Compact b) =>
   Compact (a,b)`.


**Diesen Text gibt es auch als [kompilierbares Literate
Haskell](https://github.com/iblech/vortrag-haskell/blob/master/impossible-programs.lhs)!**
