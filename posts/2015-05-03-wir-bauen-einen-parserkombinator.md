---
title: Wir bauen einen Parserkombinator
author: Profpatsch
image: /images/monadic-parser-combinators.jpg
image-alt: I don’t always parse Text, but when I do I use Monadic Parser Combinators
---

Ein Parser ist eine Funktion von einem String zu einem eventuellen Tupel aus Resttext und geparsten Daten,

``` haskell
String -> Maybe (String, a)

-- oder mit newtype Wrapper:
newtype Parser a = MkParser
    { runParser :: String -> Maybe (String,a) }
```

So kann man jetzt zum Beispiel einen Char parsen:

``` haskell
char :: Char -> Parser Char
char c = MkParser $ \s ->
    case s of
	(d:cs) | c == d -> Just (cs, c)
	otherwise       -> Nothing
```

Diese Funktion nimmt einen Char und gibt einen Parser zurück, der wiederum zur Ausführung einen String nimmt und prüft, ob dessen Anfangschar gleich dem Char `c` ist. Wenn das nicht so ist (`otherwise`), schlägt der Parser fehl.

Schnell definieren wir auch eine mysteriöse Funktion `bind`, die einen Parser nimmt, diesen ausführt, und das Ergebnis an eine zweite Funktion übergibt, die wiederum einen Parser zurückgibt.

``` haskell
bind :: Parser a -> (a -> Parser b) -> Parser b
bind m f = MkParser $ \s ->
    case runParser m s of
	Just (s', x) -> runParser (f x) s'
	Nothing      -> Nothing
```

Also quasi eine Verkettung von Parsern mit durchfädeln der Ergebnisse; das mag dem einen oder anderen bekannt vorkommen und man kann das Prinzip tatsächlich auf viele andere Typen auch anwenden. Man kennt das – oh Schreck! – im allgemeinen auch unter dem Begriff „Monade“. Das werden wir im nächsten Treffen aus verschiedenen Blickwinkeln beleuchten; dort sind dann alle eingeladen sind, die mit „Monoid aus der Kategorie der Endofunktoren“ nichts anfangen können.

Natürlich darf dann auch der Kumpan von `bind/>>=`, `pure/return` nicht fehlen:

``` haskell
pure :: a -> Parser a
pure x = MkParser $ \s -> Just (s, x)
```

Das macht einfach einen beliebigen Wert zu einem Parser (damit man ihn auch mit anderen Parsern verketten kann).

Diese Definitionen kombiniert man dann (Parser*kombinatioren*) zu höherleveligen Hilfsfunktionen, wie z.B.

``` haskell
andThen :: Parser a -> Parser b -> Parser a
andThen m n = bind m (\x -> bind n (\y -> pure x))
```

was ein Stück Eingabe parst und dann wegschmeißt. Das wird dann von dem S-Expr-Parser wieder benutzt, um Tokens zu definieren:

``` haskell
token :: String -> Parser String
token s = string s `andThen` spaces
```

Ein Token ist ein String, gefolgt von optionalen Spaces, die aber verworfen werden. So ist z.B. `foo` der gleiche Token wie `foo        `.

Am Ende bleibt dann nur noch übrig, die Datenstruktur von S-Expressions hinzuschreiben und den Parser, der definiert, wie sie als Text dargestellt werden.

``` haskell
data Exp = Atom String | List [Exp]
    deriving (Show,Eq)

-- Das sind Beispiele für S-Exprs:
-- hallo
-- (foo bar baz (...))

parseExp :: Parser Exp
parseExp = choice [ parseAtom, parseList ]

parseAtom :: Parser Exp
parseAtom = do
    x <- many1 alphaNum
    spaces
    return (Atom x)

parseList :: Parser Exp
parseList = do
    token "("
    xs <- many parseExp
    token ")"
    return $ List xs
```

# Was fehlt noch?

- Unsere naive Bibliothek leckt Speicher
- Wir geben keine guten Parse-Fehlermeldungen aus
- Wir haben keine Kombinatoren zum Parsen von Termen mit Operatoren

![xkcd about regular expressions](/images/regular_expressions.png)
<div class="attribution"><p><a href="https://xkcd.com/208/">xkcd</a></p></div>

Danke [Ingo Blechschmidt][ingo] für den tollen Vortrag! Das Ergebnis kann [hier][parserc] bestaunt werden.

[parserc]: https://github.com/iblech/vortrag-haskell/blob/master/monadic-parsing-snapshot-der-live-version.hs
[ingo]: http://speicherleck.de/iblech/
