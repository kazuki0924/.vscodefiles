#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: install extensions

FILE=${1:-$HOME/.vscodefiles/.vscode-extensions}

while read -r LINE; do
  LINE="$(echo "${LINE%%#*}" | tr -d ' ')"
	[ -z "$LINE" ] && continue
	EXTENSION="$(echo "$LINE" | awk -F "itemName=" '{print $NF}')"
  ARGS="--force --install-extension $EXTENSION"
  if which code &>/dev/null; then
    code "${ARGS[@]}"
  elif which code-insiders &>/dev/null;  then
    code-insiders "${ARGS[@]}"
  fi
	echo installed "$EXTENSION"
done < "$FILE"
