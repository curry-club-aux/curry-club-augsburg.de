#!/bin/bash

# configuration
TARGET_BRANCH=gh-pages
SITE=./site

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

# may fail if "$CURR_REPO" is a 'shallow' repository
if git clone -b "$TARGET_BRANCH" --single-branch "$CURR_REPO" "$BUILD_DIR"; then
  pushd "$BUILD_DIR"
  git pull "$ORIGIN" "$TARGET_BRANCH"
  popd
else
  git clone -b "$TARGET_BRANCH" --single-branch "$ORIGIN" "$BUILD_DIR"
fi

$SITE clean
if hash stack 2>/dev/null; then
  $SITE build --use-stack
else
  $SITE build
fi
cp -R ./_site/* "$BUILD_DIR"
$SITE clean

cd "$BUILD_DIR"
git add --all
if git commit -m "Updated website output $(date '+%m/%d/%y %H:%M')"; then
  git push "$ORIGIN" "$TARGET_BRANCH"
else
  echo "No changes to generated website."
fi

rm -rf "$BUILD_DIR"
