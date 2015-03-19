#!/bin/bash

set -e

TMP=$(mktemp -d)

cd $(dirname "$0")

./site clean
./site build

cp -R ./_site/* "$TMP"

./site clean

git checkout gh-pages

cp -R "$TMP/"* ./

git add --all
git commit -m "updated website output"
git push origin gh-pages
git checkout master

rm -rf "$TMP"
