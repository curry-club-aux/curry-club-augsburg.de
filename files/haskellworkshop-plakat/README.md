Aus der Webseite kann mit [wkhtmltopdf](http://wkhtmltopdf.org/) ein druckfertiges PDF erzeugt werden:

```bash
$ python2 -m SimpleHTTPServer 8000 &
$ wkhtmltopdf --print-media-type --background -B 0 -L 0 -R 0 -T 0 http://localhost:8000/workshop1.html ../haskellworkshop-plakat.pdf
```

Die mit Ubuntu mitgelieferte Version von wkhtmltopdf ist zu alt. Auf der
Webseite gibt es aber ein funktionsfähiges Binärpaket, dass die Optionen in
obigem Aufruf unterstützt.

Trotzdem produzierte das nicht zufriedenstellende Ergebnisse. Schlussendlich
hielt Chromium mit dem Tipp von
https://stackoverflow.com/questions/9540990/using-chromes-element-inspector-in-print-preview-mode
her.
