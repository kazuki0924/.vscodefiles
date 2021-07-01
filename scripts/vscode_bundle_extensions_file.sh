#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: install extensions

REQUIREMENTS=(
  fd
)

for REQUIREMENT in "${REQUIREMENTS[@]}"; do
  which "$REQUIREMENT" &>/dev/null || brew install "$REQUIREMENT"
done

EXTENSIONSDIR="${1-$HOME/.vscodefiles}"

mapfile -t FILES < <(fd -H "(.vscode-extensions)" "$EXTENSIONSDIR")

TARGET=${1:-$HOME/.vscodefiles/.vscode-extensions}

for FILE in "${FILES[@]}"; do
  while read -r LINE; do
    LINE="$(echo "${LINE%%#*}" | tr -d ' ')"
    [ -z "$LINE" ] && continue
    EXTENSION="$(echo "$LINE" | awk -F "itemName=" '{print $NF}')"
    echo "$EXTENSION" >>"$TARGET"
  done <"$FILE"
done
