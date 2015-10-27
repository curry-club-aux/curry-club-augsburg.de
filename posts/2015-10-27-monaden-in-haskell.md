---
title: Monaden in Haskell (Nachtrag zum Haskell-Workshop)
author: Ingo Blechschmidt
image: /images/a-monad-is-just.jpeg
image-alt: Eine Monade ist nichts anderes als ein Monoidobjekt in einer Kategorie von Endofunktoren
image-attr: <a href="http://wadler.blogspot.de/2012/12/tech-mesh-2012.html">Bodil Stokke und Philip Wadler auf der Tech Mesh 2012</a>
---

Dieser kurze Artikel soll als Nachtrag zum Haskell-Workshop kurz umreißen, wie
*monadische Ein- und Ausgabe* in Haskell funktioniert. TL;DR:

* Ein Wert vom Typ `IO a` ist eine Beschreibung einer IO-Aktion, welche durch die
  Laufzeitumgebung ausgeführt werden könnte (und dabei dann irgendwelche
  Nebenwirkungen verursachen und schließlich einen Wert vom Typ `a` produzieren
  würde).

* Der Sinn eines Haskell-Programms besteht darin, die Beschreibung einer
  IO-Aktion `main` festzulegen. Diese wird dann von der Laufzeitumgebung
  ausgeführt. Andere Beschreibungen werden nicht ausgeführt.

* Beschreibungen von IO-Aktionen kann man mit `>>` und `>>=` bzw. der do-Notation
  miteinander kombinieren. Der Operator `>>` ist wie das Zeilenende-Semikolon
  in anderen Sprachen.

* Wenn man nur veränderlichen Zustand möchte, benötigt man nicht die IO-Monade.
  Man muss nur Zustand per Hand durchfädeln – oder die praktische Abstraktion
  durch die State-Monade nutzen.


Das Problem: Unverträglichkeit mit referenzieller Transparenz
=============================================================

In vielen Programmiersprachen gibt es eine Funktion wie `readFile :: FilePath
-> String`, die eine Datei einliest und ihren Inhalt zurückgibt. *Eine solche
Funktion kann es in Haskell nicht geben,* denn in Haskell gilt das Prinzip der
*referenziellen Transparenz*: Wie in der Mathematik müssen Funktionen bei
gleichen Eingaben gleiche Ausgaben produzieren. Der Rückgabewert von `readFile
"foo.txt"` hängt aber vom aktuellen Inhalt der Datei `foo.txt` ab.

In Haskell schätzt man das Prinzip der referenziellen Transparenz sehr. Denn es
ermöglicht es, Code rein lokal zu verstehen und leicht umzustrukturieren.
Immer, wenn man irgendwo im Code an zwei Stellen denselben Teilausdruck
erspäht, kann man diesen durch eine mit `let ... in ...` oder `where ...`
eingeführte Variable ersetzen. Ohne referenzielle Transparenz geht das nicht:

``` perl
# Folgender Code ...
say foo();
say foo();

# ... macht im Allgemeinen etwas anderes als dieser hier:
my $x = foo();
say $x;
say $x;
```

Denn `foo()` könnte Nebenwirkungen auslösen, die dann nur ein einziges Mal
statt zwei Male ausgeführt werden (zum Beispiel, etwas auf Twitter zu
posten), oder auf veränderlichem Zustand basieren (zum Beispiel der Anzahl
Nanosekunden seit Programmstart).

Wie also kann man den Wunsch nach referenzieller Transparenz mit der Notwendigkeit,
Ein- und Ausgabe zu betreiben, vereinbaren?


Die Lösung: Monadische Ein- und Ausgabe
=======================================

In Haskell ist man – nach einigen suboptimalen Lösungen und Irrwegen – auf das
Konzept der *monadischen Ein- und Ausgabe* gestoßen, das das Problem
vollumfänglich löst. Dieses hat elegante mathematische Hintergründe, die man
für die Anwendung nicht kennen muss. So sieht ein Programm aus, das
den ausführenden Lambdroiden freundlich grüßt:

``` haskell
main = do
    putStr "Hallo! Was ist dein Name? "
    name <- getLine
    putStr "Das ist ein schöner Name. So lautet er rückwärts: "
    putStrLn $ reverse name
```

Die beteiligten Typen sind `getLine :: IO String` und `putStr :: String -> IO ()`.
Die Konstante `main` hat den Typ `main :: IO ()`.

Was passiert hier? Es bleibt dabei, dass Haskell-Funktionen keine
Nebenwirkungen wie Interaktion mit dem Terminal verursachen können. Man kann
allerdings durchaus IO-Aktionen *theoretisch beschreiben*. Der Sinn eines
Haskell-Programms besteht in diesem Bild darin, eine bestimmte IO-Aktion zu
beschreiben – die mit dem Namen `main`. Diese wird dann vom Laufzeitsystem
ausgeführt.

Genau wie ein Wert vom Typ `Tree a` ein Baum ist, dessen Blätter vom Typ `a`
sind, ist ein Wert vom Typ `IO a` eine Beschreibung einer IO-Aktion, die prinzipiell vom
Laufzeitsystem ausgeführt werden könnte, dabei irgendwelche Nebenwirkungen
verursachen und schließlich einen Wert vom Typ `a` produzieren würde.
Solche Beschreibungen sind "first class values", sie können manipuliert und
in Datenstrukturen abgelegt werden, ohne dass sie bei Ablauf des Programms
sofort ausgeführt werden würden. Nur eine einzige Beschreibung wird tatsächlich
ausgeführt: Die, die den Namen `main` trägt.

Das folgende Code-Beispiel soll diesen Punkt unterstreichen.

``` haskell
main = seq (putStrLn "abc") (putStrLn "def")
```

Die Funktion `seq` erzwingt die Auswertung ihres ersten Arguments – sobald `seq
x y` ausgewertet wird, wird zunächst `x` ausgewertet und dann `y`
zurückgegeben. Beispielsweise ist `seq (fib 10000) "Curry"` semantisch völlig
identisch zur Konstante `"Curry"`, aber langsamer in der Ausführung.

Jedenfalls passiert beim Ablauf dieses Programms folgendes: Zunächst wird
`putStrLn "abc"` ausgewertet. Das produziert eine Beschreibung einer IO-Aktion,
die wenn ausgeführt `abc` auf dem Terminal ausgeben würde. Diese Beschreibung
wird dann jedoch sofort verworfen. Schließlich produziert `putStrLn "def"` eine
Beschreibung, die `def` ausgeben würde. Diese Beschreibung ist letztendlich der
Wert von `main`, und diese Beschreibung wird vom Laufzeitsystem ausgeführt.


Konstruktion komplexer Aktionsbeschreibungen
============================================

Vorimplementierte Funktionen wie `putStrLn :: String -> IO ()` oder
`readFile :: FilePath -> IO String` produzieren gewisse primitive
Beschreibungen von IO-Aktionen. Die allermeisten Programme werden sich aber
mehrerer solcher primitiver Aktionen bedienen müssen. Es muss also eine
Möglichkeit geben, mehrere Aktionsbeschreibungen zu einer komplexeren
Beschreibung zu kombinieren – ganz so, wie etwa der Konstruktor `Fork` zwei
Teilbäume zu einem großen zusammensetzt.

Dazu gibt es in der Tat mehrere Möglichkeiten.

* Der Operator `(>>) :: IO a -> IO b -> IO b` nimmt zwei Aktionsbeschreibungen.
  Wird die resultierende Beschreibung `m >> n` ausgeführt, so wird zunächst `m`
  ausgeführt (und ihr Ergebnis vom Typ `a` verworfen) und dann `n` ausgeführt.

* In vielen Fällen möchte man die als zweites auszuführende Aktion vom Ergebnis
  der ersten abhängig machen. Dazu gibt es den Operator `(>>=) :: IO a -> (a ->
  IO b) -> IO b`. Die Aktionsbeschreibung `m >>= f` führt bei ihrer Ausführung
  dazu, dass zunächst `m` ausgeführt wird. Der dabei produzierte Wert `x` wird
  an die Funktion `f` übergeben, welche eine weitere Aktionsbeschreibung `f x`
  errechnet. Diese wird dann als zweites ausgeführt.

Außerdem gibt es noch eine triviale Möglichkeit, eine Aktionsbeschreibung zu
produzieren: Mit der Funktion `return :: a -> IO a`, die (Achtung!) nichts mit
dem gleichnamigen Schlüsselwort in vielen anderen Sprachen (zum vorzeitigen
Verlassen einer Subroutine) zu tun hat. Vielmehr ist `return x` eine
Aktionsbeschreibung, die bei ihrer Ausführung keinerlei Nebenwirkungen
verursacht und dann den Wert `x` produziert.

Etwa kann man den Ausdruck `return x >> m` zu `m` vereinfachen. Beide Ausdrücke
beschreiben genau dieselbe Aktion. Auch ist `return x >>= f` identisch zu `f x`.

Schließlich sei noch die *Funktorialität* von Aktionsbeschreibungen erwähnt.
Ist `m :: IO a` eine Aktionsbeschreibung, die bei Ausführung einen Wert `x` vom
Typ `a` produziert, und ist `g :: a -> b` eine beliebige Funktion, so
beschreibt `fmap g m :: IO b` diejenige Aktion, die die Beschreibung `m`
ausführt, deren Ergebnis `x` an die Funktion `g` übergibt und so den Wert `g x
:: b` produziert.

Aus historischen Gründen kann man statt `fmap g m` auch `liftM g m` schreiben.
Die beiden Ausdrücke beschreiben genau dieselbe IO-Aktion.


Die do-Notation
===============

Haskell erleichtert mit der *do-Notation* den Umgang mit Aktionsbeschreibungen
ungemein. Sie ist angenehmer syntaktischer Zucker für die Operatoren `>>` und
`>>=`. Das Eingangsbeispiel schreibt sich ohne do-Notation wie folgt:

``` haskell
main =
    putStr "Hallo! Was ist dein Name? " >>=
        (\name ->
            putStr "Das ist ein schöner Name. So lautet er rückwärts: " >>
                putStrLn (reverse name))
```

Die Übersetzungsregeln lauten also:

* Zwei aufeinanderfolgende Anweisungen werden implizit mit `>>` miteinander
  verbunden.

* Die Bindung des Produktionsergebnisses einer IO-Aktion mit `<-` wird
  hinter den Kulissen in einen λ-Ausdruck und `>>=` umgesetzt.

Solche Bindungen unterscheiden sich von den weiterhin möglichen
Variablendefinitionen mit `let`. Ein längeres Programm könnte zum Beispiel so
aussehen:

``` haskell
main = do
    putStr "Was ist der Radius des Kreises? "
    antwort <- getLine
    let radius = read antwort
        umfang = 2 * pi * radius
        n      = fib 42
    putStrLn $ "Dann ist der Umfang: " ++ show umfang
    putStrLn $ "Und die 42-te Fibonacci-Zahl ist: " ++ show n
```

Das sonst bei `let` benötigte Schlüsselwort `in` kann man bei der `do`-Notation
weglassen.


Referenzielle Transparenz ist bewahrt
=====================================

Der folgende Code gibt zwei Ausgaben aus:

``` haskell
main = do
    putStrLn $ show $ fib 42
    putStrLn $ show $ fib 42
```

Wenn man von Optimierungen des Compilers absieht, wird dabei die
Aktionsbeschreibung `putStrLn $ show $ fib 42` zwei Mal berechnet. Wenn man
möchte, kann man den Code wie folgt umstrukturieren.

``` haskell
main = do
    let m = putStrLn $ show $ fib 42
    m
    m

-- Alternativ ohne do-Notation:
main = m >> m where m = putStrLn $ show $ fib 42
```

Hier wird die Aktionsbeschreibung nur noch einmal berechnet, allerdings immer
noch zwei Male ausgeführt.


Eigene Kontrollstrukturen
=========================

Dadurch, dass Aktionsbeschreibungen "first class values" sind, kann man leicht
eigene Kontrollstrukturen definieren. Das Modul `Control.Monad` exportiert etwa
folgende:

``` haskell
-- `forever m` beschreibt eine unendliche Wiederholung von `m`.
forever :: IO a -> IO ()
forever m = m >> forever m

-- `replicateM i m` beschreibt eine Aktion, die wenn ausgeführt
-- die gegebene Beschreibung `m` `i` Mal ausführt und die dabei
-- produzierten Ergebnisse in einer Liste sammelt.
replicateM :: Int -> IO a -> IO [a]
replicateM 0 _ = return []
replicateM i m = do
    x  <- m
    xs <- replicate (i-1) m
    return (x:xs)

-- Was macht wohl diese Funktion?
forM :: [a] -> (a -> IO b) -> IO [b]
forM []     _ = return []
forM (x:xs) f = ...
```


Eine Falle im Umgang mit `return`
=================================

Folgender Code enthält einen Typfehler:

``` haskell
main = do
    eman <- revertierer
    putStrLn eman

revertierer = do
    name <- getLine
    reverse name
```

Das Problem liegt in der Zeile `reverse name`. Verwendet man die do-Notation,
so muss (bis auf reine Anteile mit `let`) jede Zeile eine Aktionsbeschreibung
sein, schließlich werden diese Beschreibungen dann hinter den Kulissen mit `>>`
bzw. `>>=` zu einer großen kombiniert. Der Ausdruck `reverse name` ist
allerdings eine einfache Liste, keine Aktionsbeschreibung. Abhilfe schafft die
Verwendung von `return`:

``` haskell
main = do
    eman <- revertierer
    putStrLn eman

revertierer = do
    name <- getLine
    return $ reverse name
```

Idiomatischer würde man das Programm übrigens wie folgt schreiben.

``` haskell
main        = revertierer >>= putStrLn
revertierer = fmap reverse getLine
```


Die State-Monade
================

In Haskell gibt es keine veränderlichen Variablen. Man kann sie allerdings
emulieren: Eine Funktion, die eigentlich eine gewisse Variable verändern
möchte, kann den neuen Wert einfach an den Aufrufer zurückgeben. Dieser muss
den neuen Wert dann bei weiteren Funktionsaufrufen berücksichtigen. Konkret
kann das zum Beispiel so aussehen:

``` haskell
f1 :: S -> (A,S)
f2 :: S -> A -> (B,S)
f3 :: S -> B -> (C,S)

f :: S -> (C,S)
f s =
    let (x,s')   = f1 s
        (y,s'')  = f2 s'  x
        (z,s''') = f3 s'' y
    in  (z,s''')
```

Durch dieses manuelle Durchfädeln des Zustands kann man veränderliche Variablen
in Haskell nachbauen. Schön ist das allerdings nicht! Und fehleranfällig
obendrein. Der Compiler kann uns nämlich nicht davor schützen, die vielen
Zwischenzustände zu verwechseln, also zum Beispiel `f3 s' y` statt `f3 s'' y`
zu schreiben.

Abhilfe schafft die *State-Monade*. Folgender Code ist viel übersichtlicher:

``` haskell
f1 :: State S A
f2 :: A -> State S B
f3 :: B -> State S C

f :: State S C
f = do
    x <- f1
    y <- f2 x
    z <- f3 y
    return z
-- oder kürzer: f = f1 >>= f2 >>= f3
```

Einen Wert vom Typ `State s a` kann man sich analog zum IO-Fall als eine
Beschreibung einer Aktion vorstellen: eine, die unter Zugriff und potenzieller
Veränderung eines Zustands vom Typ `s` einen Wert vom Typ `a` produziert.

Mit der Funktion ``runState :: State s a -> s -> (a,s)`` kann man eine solche
Beschreibung ausführen, wenn man einen initialen Wert des Zustands vorgibt.
Das ist ein Unterschied zur IO-Monade: Nur das Laufzeitsystem ist in der Lage,
eine Beschreibung einer IO-Aktion auszuführen. State-Aktionen können dagegen
Haskell-intern ausgeführt werden.

Übrigens kommt es in der täglichen Praxis mit Haskell nicht besonders häufig
vor, dass man veränderliche Variablen benötigen würde. Fast immer ist eine
Alternativlösung ohne veränderliche Variablen eleganter und wartbarer. Falls
man imperativ geprägt ist, lohnt es sich daher trotzdem, etwas Mühe zu
investieren, um zustandslose Implementierungen zu finden.


Weitere Monaden
===============

Aus der Not wurde eine Tugend: Nachdem die Nützlichkeit des monadischen Ansatzes
für Ein- und Ausgabe erkannt wurde, hat man viele weitere nützliche Monaden
entdeckt und entworfen.

* State (veränderlicher Zustand)
* Parser (Parsen von Text)
* Maybe (Behandlung von Fehlerfällen, Vermeidung von "or else"-Kaskaden)
* Reader (vererbende Umgebung)
* Writer (Logging)
* Listen (Nichtdeterminismus und Logikprogrammierung)
* Cont (Continuations)

Alle Monaden zeichnen sich dadurch aus, dass sie über Operatoren `>>=` und
`return` sowie `fmap` verfügen. Es gibt eine Typklasse `Monad`, der alle
Monaden angehören. Ihre Definition lautet:

``` haskell
class Functor f where
    fmap :: (a -> b) -> (f a -> f b)

class (Functor m) => Monad m where
    return :: a -> m a
    (>>=)  :: m a -> (a -> m b) -> m b
```

Gelegentlich kann man sogar *polymorph in der Monade* programmieren. Etwa
ergeben die oben erwähnten Kontrollstrukturen `forever`, `replicateM` und
`forM` nicht nur im Spezialfall der IO-Monade Sinn, sondern auch bei jeder
anderen Monade.


Wie geht's weiter?
==================

Im Internet gibt es [zahlreiche
Einführungen](https://wiki.haskell.org/Monad_tutorials_timeline) in die Welt
der Monaden. Außerdem gibt es Artikel über die [Monad Tutorial
Fallacy](https://byorgey.wordpress.com/2009/01/12/abstraction-intuition-and-the-monad-tutorial-fallacy/).
Sobald man Monaden verstanden hat, verliert man instantan die Fähigkeit, sie
verständlich zu erklären.

Wer fortgeschritten ist und verstehen möchte, was Monaden mit Monoiden zu tun
haben, sei ein [Foliensatz](/files/freie-monaden.pdf) von einem der Treffen des
Curry Clubs empfohlen. Für alle
lesenswert ist aber auf jeden Fall ein Artikel des großartigen Dan "sigfpe" Piponi:
[You could have invented monads! (And maybe you already
have.)](http://blog.sigfpe.com/2006/08/you-could-have-invented-monads-and.html)
