#!/bin/bash

cd $(dirname "$0")
CURR_REPO=$(git rev-parse --show-toplevel)
CURR_ORIGIN=$(git config --get remote.origin.url)

if [ "$1" == "-h" -o "$1" == "--help" -o $# -gt 1 ]; then
  echo "Usage: ./deploy.sh [REMOTE-REPO-URL]"
  echo ""
  echo "By default, REMOTE-REPO-URL is '$CURR_ORIGIN',"
  echo "the 'origin' of the git repository at '$CURR_REPO'."
  exit 0
fi

ORIGIN=${1:-$CURR_ORIGIN}
BUILD_DIR=$(mktemp -d builddir-XXXX)

function onerr() {
  rm -rf "$BUILD_DIR"
  exit 1
}
trap onerr ERR

git clone -b gh-pages --single-branch "$CURR_REPO" "$BUILD_DIR"
pushd "$BUILD_DIR"
git pull "$ORIGIN" gh-pages
popd

./site clean
./site build
cp -R ./_site/* "$BUILD_DIR"
./site clean

cd "$BUILD_DIR"
git add --all
if git commit -m "Travis: updated website output $(date '+%m/%d/%y %H:%M')"; then
  git push "$ORIGIN" gh-pages
else
  echo "No changes to generated website."
fi

rm -rf "$BUILD_DIR"
