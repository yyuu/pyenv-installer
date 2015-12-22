#!/usr/bin/env bash

checkout() {
  [ -d "$2" ] && $(cd "$2"; git clone "$1")
}

if [ -z "$PYENV_PACKAGE_ARCHIVE" ]; then
  PYENV_PACKAGE_ARCHIVE="$(cd $(dirname "$0") && pwd)/pyenv-package.tar.gz"
fi

TMP_DIR=$(mktemp -d)

if [ -n "${USE_HTTPS}" ]; then
  GITHUB="https://github.com"
else
  GITHUB="git://github.com"
fi

# checkout to temporary directory.
checkout "${GITHUB}/yyuu/pyenv.git"            "$TMP_DIR"
checkout "${GITHUB}/yyuu/pyenv-doctor.git"     "$TMP_DIR"
checkout "${GITHUB}/yyuu/pyenv-installer.git"  "$TMP_DIR"
checkout "${GITHUB}/yyuu/pyenv-update.git"     "$TMP_DIR"
checkout "${GITHUB}/yyuu/pyenv-virtualenv.git" "$TMP_DIR"
checkout "${GITHUB}/yyuu/pyenv-which-ext.git"  "$TMP_DIR"

# create archive.
tar -zcf "$PYENV_PACKAGE_ARCHIVE" -C "$TMP_DIR" .

rm -rf $TMP_DIR
