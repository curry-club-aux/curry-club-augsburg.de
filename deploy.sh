#!/bin/bash
TMP=$(mktemp -d)

cd $(dirname "$0")

./site clean || exit 1
./site build || exit 1

cp -R ./_site/* "$TMP" || exit 1

./site clean || exit 1

git checkout gh-pages || exit 1


cp -R "$TMP/"* ./ || exit 1

git add --all | exit 1

git commit -m "updated website output" || exit 1

git push origin gh-pages || exit 1

git checkout master || exit 1

rm -rf "$TMP" || exit 1
