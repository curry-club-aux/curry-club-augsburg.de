# Webseite des Curry Club Augsburg [![Build Status][github-actions-img]][github-actions-url]

Siehe auch: [Wiki][wiki], [Liste von Issues][issues]

Der `master`-Branch enthält den Inhalt der Webseite. Das Haskell-Programm `curry-site.hs` erzeugt aus den Inhalten eine statische Webseite. Es benutzt dafür die Haskell-Bibliothek [Hakyll][hakyll]. Die generierten statischen Dateien werden im [`gh-pages`][gh-pages-branch]-Branch hochgeladen und von [GitHub Pages][gh-pages] unter der URL [curry-club-augsburg.de](http://curry-club-augsburg.de/) verfügbar gemacht.

Der Continuous-Integration-Dienst [Github Actions][github-actions] wird dazu verwendet, die Seite bei Änderungen im `master`-Branch neu zu bauen und das Ergebnis in `gh-pages` zu veröffentlichen. Das Schild neben der Überschrift zeigt an, ob der letzte Buildvorgang erfolgreich war.

## Neuer Blogeintrag

Einträge schreiben wir mit [Markdown][md]. Ein Beispiel ist `posts/2015-03-17-hallo-welt.md`.

Links innerhalb der Seite müssen vom „root“ aus angegeben werden, also z.B. für Bilder `/images/foobar.png`.

Metadaten werden mit `---` eingeschlossen, am Anfang der Datei. Mögliche Felder sind:

- `title`: Titel
- `author`: Autor
- `image`: Bild am Anfang (optional)
- `image-alt`: Alt-Text für das Bild. Bitte bei Verwendung eines Bilds immer angeben (optional)
- `image-attr`: Bildquelle (optional)
- `meetup-announcement`: Datum des Treffens, für das der Post die Ankündigung ist (optional, muss nur gesetzt werden, wenn der Post eine Ankündigung ist)

Teilüberschriften starten mit `#` und dann für jede Ebene ein `#` mehr.

Eine Bildquelle im Text kann mit

    <figure>
    ![xkcd about regular expressions](/images/regular_expressions.png)
    <figcaption class="attribution"><cite><a href="https://xkcd.com/208/">xkcd 208</a></cite></figcaption>
    </figure>

angegeben werden. `cite` sollte gemäß der HTML-Spezifikation den vollen Titel der Quelle enthalten.

Der Post, dessen `meetup-announcement`-Datum am nähesten in der Zukunft liegt, wird auf der Hauptseite angezeigt und gibt das Datum des nächsten Treffens an.

## Änderungen am Inhalt

Kleinere Änderungen kann man gut im [GitHub Webinterface][gh-webinterface] vornehmen. Es vergehen ca. vier Minuten, bis Github Actions die Seite neu gebaut hat.

## Änderungen an `curry-site.hs`

Für Änderungen am Aufbau und Design der Seite empfiehlt es sich, lokal zu arbeiten, damit man Änderungen schneller sieht. Wenn man das Repo geklont hat, muss man zuerst die Abhängigkeiten installieren und `curry-site.hs` kompilieren.

Mit Stack:

```bash
$ stack install
```

Oder mit Nix:

```bash
$ nix-shell
[nix-shell] $ cabal build
```

Dann kann man `curry-site build` aufrufen. Das Programm generiert die Webseite neu und legt die statischen Dateien in den Ordner `_site`. Zum Debuggen kann man `curry-site build -v` verwenden.

Das benutzt standardmäßig `stack` zum Generieren des CSS, wenn `cabal` bevorzugt wird (z.B. weil `stack` durch nix überflüssig ist), kann das mittels Env-Variable festgelegt werden: `env backend=cabal curry-site build`.

Sobald man mit dem Ergebnis zufrieden ist, macht man einen Commit und pusht zum `master`-Branch. Dann wartet man, bis Github Actions die Webseite neu generiert hat.

## Potentiell kontroverse Änderungen

Wenn man den Anderen die Änderungen erst einmal zeigen möchte, kann man folgenden Workflow verwenden:

- Forke dieses Repository.
- Mache lokal deine Änderungen.
- Rufe `./deploy.sh git@github.com:deingithubname/curry-club-augsburg.de.git` auf. (Das baut die Seite und pusht das Ergebnis in den `gh-pages`-Branch von deinem Fork.)
- Committe deine Änderungen in einem speziellen Feature-Branch und push die Commits zu in deinen Fork.
- Starte einen Pull-Request, in dem du auf `http://deingithubname.github.io/curry-club-augsburg.de/` verlinkst.

[wiki]: https://github.com/curry-club-aux/curry-club-augsburg.de/wiki
[issues]: https://github.com/curry-club-aux/curry-club-augsburg.de/issues
[gh-pages]: https://pages.github.com/
[github-actions]: https://github.com/features/actions
[github-actions-img]: https://github.com/curry-club-aux/curry-club-augsburg.de/workflows/Build%20and%20deploy%20site/badge.svg
[github-actions-url]: https://github.com/curry-club-aux/curry-club-augsburg.de/actions
[gh-webinterface]: https://help.github.com/articles/github-flow-in-the-browser/
[hakyll]: http://jaspervdj.be/hakyll/
[gh-pages-branch]: https://github.com/curry-club-aux/curry-club-augsburg.de/tree/gh-pages
[md]: https://daringfireball.net/projects/markdown/dingus
