#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: uninstall extensions

bash $HOME.vscodefiles/scripts/vscode_export_extentions_list.sh

FILE=${1:-$HOME/.vscodefiles/extensions-list.txt}

while read -r LINE; do
  LINE="$(echo "${LINE%%#*}" | tr -d ' ')"
  [ -z "$LINE" ] && continue
  EXTENSION="$(echo "$LINE" | awk -F "itemName=" '{print $NF}')"
  ARGS="--uninstall-extension $EXTENSION"
  if which code &>/dev/null; then
    code "${ARGS[@]}"
  elif which code-insiders &>/dev/null; then
    code-insiders "${ARGS[@]}"
  fi
  echo uninstalled "$EXTENSION"
done <"$FILE"
