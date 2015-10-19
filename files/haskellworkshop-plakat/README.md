Aus der Webseite kann mit [wkhtmltopdf](http://wkhtmltopdf.org/) ein druckfertiges PDF erzeugt werden:

```bash
$ python2 -m SimpleHTTPServer 8000 &
$ wkhtmltopdf --print-media-type --background -B 0 -L 0 -R 0 -T 0
http://localhost:8000/index.html ../haskellworkshop-plakat.pdf
```
