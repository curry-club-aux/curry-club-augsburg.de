---
title: Yolomorphismus
author: Profpatsch
image: /images/yolo-cat.jpg
image-alt: Yolo-Katze
---

Im Zuge unserer Unterhaltungen sind wir auf die Begrifflichkeit des „Yolomorphismus“ gekommen, welche Lars folgendermaßen definiert:

<dl>
  <dt><dfn>Yolomorphisums</dfn>, n.</dt>
  <dd>partielle, nicht-injektive Funktion</dd>
</dl>

Beispiele sind die allseits gefüchteten `head` und `tail`, sowie `(!!)`.

Ingo ergänzte um Beispiele im weiteren Sinn (YOLO ernst genommen):

```haskell
unsafePerformIO :: IO a -> a

unsafeCoerce :: a -> b  -- mehr YOLO geht nicht
```

Lukas merkte noch an, dass man das alles wunderbar in ein Language-Feature umwandeln kann:

```haskell
module Yolomorphism where

--| Yolomorphism typeclass
class Yolomorphable a where
  --| because YOLO
  yoloPerformIO :: IO a -> a
  --| because even more YOLO
  yoloCoerce    :: a -> b
```

Wir sollten das mal dem Haskell'-Team zur Einführung in die `base`-Library vorschlagen.