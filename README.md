# Webseite des Curry Club Augsburg [![Build Status][travis-img]][travis-url]

Siehe auch: [Wiki][wiki], [Liste von Issues][issues]

Der `master`-Branch enthält den Inhalt der Webseite. Das Haskell-Programm `site.hs` erzeugt aus den Inhalten eine statische Webseite. Es benutzt dafür die Haskell-Bibliothek [Hakyll][hakyll]. Die generierten statischen Dateien werden im [`gh-pages`][gh-pages-branch]-Branch hochgeladen und von [GitHub Pages][gh-pages] unter der URL [curry-club-augsburg.de](http://curry-club-augsburg.de/) verfügbar gemacht.

Der Continous-Integration-Dienst [Travis.CI][travis] wird dazu verwendet, die Seite bei Änderungen im `master`-Branch neu zu bauen und das Ergebnis in `gh-pages` zu veröffentlichen. Das Schild neben der Überschrift zeigt an, ob der letzte Buildvorgang erfolgreich war. Die Vorgehensweise ist in [diesem Artikel](http://timbaumann.info/posts/2013-08-04-hakyll-github-and-travis.html) beschrieben.


## Änderungen am Inhalt

Kleinere Änderungen kann man gut im [GitHub Webinterface][gh-webinterface] vornehmen. Es vergehen ca. 15 Minuten, bis Travis die Seite neu gebaut hat. (Können wir das irgendwie schneller machen?)


## Änderungen an `site.hs`

Für Änderungen am Aufbau und Design der Seite empfiehlt es sich, lokal zu arbeiten, damit man Änderungen schneller sieht. Wenn man das Repo geklont hat, muss man zuerst die Abhängigkeiten installieren und `site.hs` kompilieren.

Mit Nix:

```bash
$ nix-shell
[nix-shell] $ cabal build
```

Ohne Nix:

```bash
$ cabal sandbox init
$ cabal install --only-dependencies # installiert hakyll
$ cabal build
```

Dann kann man `./site build` aufrufen. Das Programm generiert die Webseite neu und legt die statischen Dateien in den Ordner `_site`.

Wenn man mit dem Ergebnis zufrieden ist, macht man einen Commit und pusht zum `master`-Branch. Dann wartet man, bis Travis die Webseite neu generiert hat.

Wenn einem das zu langsam geht, kann man auch manuell die Webseite deployen: Dazu muss man nur `./site deploy` aufrufen. Das Programm baut die Webseite neu und pusht die Änderungen in den `gh-pages`-Branch auf GitHub.

Wenn man den Anderen die Änderungen erst einmal zeigen möchte, kann man folgenden Workflow verwenden:

* Forke dieses Repository.
* Mache lokal deine Änderungen.
* Rufe `./deploy.sh git@github.com:deingithubname/curry-club-augsburg.de.git` auf. (Das baut die Seite und pusht das Ergebnis in den `gh-pages`-Branch von deinem Fork.)
* Committe deine Änderungen in einem speziellen Feature-Branch und push die Commits zu Github.
* Starte einen Pull-Request, in dem du auf `http://deingithubname.github.io/curry-club-augsburg.de/` verlinkst.

[wiki]: https://github.com/curry-club-aux/curry-club-augsburg.de/wiki
[issues]: https://github.com/curry-club-aux/curry-club-augsburg.de/issues
[gh-pages]: https://pages.github.com/
[travis]: https://travis-ci.org/
[travis-url]: https://travis-ci.org/curry-club-aux/curry-club-augsburg.de
[travis-img]: https://travis-ci.org/curry-club-aux/curry-club-augsburg.de.svg?branch=master
[gh-webinterface]: https://help.github.com/articles/github-flow-in-the-browser/
[hakyll]: http://jaspervdj.be/hakyll/
[gh-pages-branch]: https://github.com/curry-club-aux/curry-club-augsburg.de/tree/gh-pages
