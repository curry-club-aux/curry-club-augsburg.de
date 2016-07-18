#!/bin/bash

# configuration
TARGET_BRANCH=gh-pages
if hash curry-site 2>/dev/null; then
  SITE=curry-site
else
  SITE=./curry-site
fi

cd $(dirname "$0")
CURR_REPO=$(git rev-parse --show-toplevel)
CURR_ORIGIN=$(git config --get remote.origin.url)

function usage() {
  echo "Usage: ./deploy.sh [REMOTE-REPO-URL [BUILD-ARGS ...]]"
  echo ""
  echo "By default, REMOTE-REPO-URL is '$CURR_ORIGIN',"
  echo "the 'origin' of the git repository at '$CURR_REPO'."
  echo ""
  echo "BUILD-ARGS are passed along as arguments to '$SITE build'."
  echo "For example, './deploy.sh $CURR_ORIGIN --verbose' calls"
  echo "'$SITE build --verbose'."
  exit 0
}

if [ "$1" == "-h" -o "$1" == "--help" ]; then
  usage
fi

if [ $# -gt 0 ]; then
  ORIGIN="$1"
  shift
else
  ORIGIN="$CURR_ORIGIN"
fi
BUILD_ARGS="$@"

BUILD_DIR=$(mktemp -d builddir-XXXX)

function cleanup_build_dir() {
  rm -rf "$BUILD_DIR"
}

function onerr() {
  cleanup_build_dir
  exit 1
}
set -o errtrace # functions inherit the error trap
trap onerr ERR

function clone_remote_repo_to_build_dir() {
  # may fail if "$CURR_REPO" is a 'shallow' repository
  if git clone -b "$TARGET_BRANCH" --single-branch "$CURR_REPO" "$BUILD_DIR"; then
    pushd "$BUILD_DIR"
    git pull "$ORIGIN" "$TARGET_BRANCH"
    popd
  else
    git clone -b "$TARGET_BRANCH" --single-branch "$ORIGIN" "$BUILD_DIR"
  fi
}

function compile_static_site_in_build_dir() {
  echo "\$ $SITE clean"
  $SITE clean
  echo "\$ $SITE build $@"
  $SITE build $BUILD_ARGS
  cp -R ./_site/* "$BUILD_DIR"
  echo "\$ $SITE clean"
  $SITE clean
}

function commit_and_push_changes_to_remote_repo() {
  cd "$BUILD_DIR"
  git add --all
  if git commit -m "Updated website output $(date '+%m/%d/%y %H:%M')"; then
    git push "$ORIGIN" "$TARGET_BRANCH"
  else
    echo "No changes to generated website."
  fi
}

function main() {
  clone_remote_repo_to_build_dir
  compile_static_site_in_build_dir
  commit_and_push_changes_to_remote_repo
  cleanup_build_dir
}

main
