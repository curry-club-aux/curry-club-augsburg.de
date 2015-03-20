#!/bin/bash

set -e

ORIGIN=${1:origin}

TMP=$(mktemp -d)

cd $(dirname "$0")

./site clean
./site build

cp -R ./_site/* "$TMP"

./site clean
echo "\ngit status:"
git status

# test if branch 'gh-pages' exists; if not, create it
if ! git rev-parse --verify gh-pages; then
  git branch gh-pages
fi
git checkout gh-pages
git pull "$ORIGIN" gh-pages

cp -R "$TMP/"* ./

git add --all
git commit -m "updated website output $(date '+%m/%d/%y %H:%M')"
git push "$ORIGIN" gh-pages
git checkout master

rm -rf "$TMP"
