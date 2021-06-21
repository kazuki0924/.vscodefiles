#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: export extensions as .txt file

FILE=${1:-$HOME/.vscodefiles/extensions-list.txt}
ARGS="--list-extensions >"$FILE""
if which code &>/dev/null; then
  code "${ARGS[@]}"
elif which code-insiders &>/dev/null;  then
  code-insiders "${ARGS[@]}"
fi
echo exported "$FILE"
