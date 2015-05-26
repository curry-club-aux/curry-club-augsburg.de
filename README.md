# Webseite des Curry Club Augsburg [![Build Status][circleci-img]][circleci-url]

Siehe auch: [Wiki][wiki], [Liste von Issues][issues]

Der `master`-Branch enthält den Inhalt der Webseite. Das Haskell-Programm `site.hs` erzeugt aus den Inhalten eine statische Webseite. Es benutzt dafür die Haskell-Bibliothek [Hakyll][hakyll]. Die generierten statischen Dateien werden im [`gh-pages`][gh-pages-branch]-Branch hochgeladen und von [GitHub Pages][gh-pages] unter der URL [curry-club-augsburg.de](http://curry-club-augsburg.de/) verfügbar gemacht.

Der Continous-Integration-Dienst [CircleCI][circleci] wird dazu verwendet, die Seite bei Änderungen im `master`-Branch neu zu bauen und das Ergebnis in `gh-pages` zu veröffentlichen. Das Schild neben der Überschrift zeigt an, ob der letzte Buildvorgang erfolgreich war. Die Vorgehensweise ist in [diesem Artikel](http://timbaumann.info/posts/2013-08-04-hakyll-github-and-travis.html) beschrieben.

## Neuer Blogeintrag

Einträge schreiben wir mit [Markdown][md]. Ein Beispiel ist `posts/2015-03-17-hallo-welt.md`.

Links innerhalb der Seite müssen vom „root“ aus angegeben werden, also z.B. für Bilder `/images/foobar.png`.

Metadaten werden mit `---` eingeschlossen, am Anfang der Datei. Mögliche Felder sind:

- `title`: Titel
- `author`: Autor
- `image`: Bild am Anfang
- `image-alt`: Alt-Text für das Bild. Bitte bei Verwendung eines Bilds immer angeben
- `image-attr`: Bildquelle (Attribution)
- `meetup-announcement`: Datum des Treffens, für das der Post die Ankündigung ist

Teilüberschriften starten mit `#` und dann für jede Ebene ein `#` mehr.

Bis eine bessere Lösung gefunden wird, kann eine Bildquelle im Text mit

    <div class="attribution"><p><a href="https://xkcd.com/208/">xkcd</a></p></div>

angegeben werden.

Der Post, dessen `meetup-announcement`-Datum am nähesten in der Zukunft liegt, wird auf der Hauptseite angezeigt und gibt das Datum des nächsten Treffens an.


## Änderungen am Inhalt

Kleinere Änderungen kann man gut im [GitHub Webinterface][gh-webinterface] vornehmen. Es vergehen ca. 2 Minuten, bis CircleCi die Seite neu gebaut hat.


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

Wenn man mit dem Ergebnis zufrieden ist, macht man einen Commit und pusht zum `master`-Branch. Dann wartet man, bis CircleCI die Webseite neu generiert hat.

Wenn einem das zu langsam geht, kann man auch manuell die Webseite deployen: Dazu muss man nur `./site deploy` aufrufen. Das Programm baut die Webseite neu und pusht die Änderungen in den `gh-pages`-Branch auf GitHub.

## Potentiell kontroverse Änderungen

Wenn man den Anderen die Änderungen erst einmal zeigen möchte, kann man folgenden Workflow verwenden:

* Forke dieses Repository.
* Mache lokal deine Änderungen.
* Rufe `./deploy.sh git@github.com:deingithubname/curry-club-augsburg.de.git` auf. (Das baut die Seite und pusht das Ergebnis in den `gh-pages`-Branch von deinem Fork.)
* Committe deine Änderungen in einem speziellen Feature-Branch und push die Commits zu in deinen Fork.
* Starte einen Pull-Request, in dem du auf `http://deingithubname.github.io/curry-club-augsburg.de/` verlinkst.

[wiki]: https://github.com/curry-club-aux/curry-club-augsburg.de/wiki
[issues]: https://github.com/curry-club-aux/curry-club-augsburg.de/issues
[gh-pages]: https://pages.github.com/
[circleci]: https://circleci.com/
[circleci-img]: https://img.shields.io/circleci/project/curry-club-aux/curry-club-augsburg.de/master.svg
[circleci-url]: https://circleci.com/gh/curry-club-aux/curry-club-augsburg.de/tree/master
[gh-webinterface]: https://help.github.com/articles/github-flow-in-the-browser/
[hakyll]: http://jaspervdj.be/hakyll/
[gh-pages-branch]: https://github.com/curry-club-aux/curry-club-augsburg.de/tree/gh-pages
[md]: https://daringfireball.net/projects/markdown/dingus
