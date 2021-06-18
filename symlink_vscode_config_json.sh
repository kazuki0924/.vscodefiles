#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

DOTDIR="${1-$HOME/.vscodefiles}"

JSON_FILES=(
  settings
  keybindings
)

DIRS=(
  "$HOME/Library/Application Support/Code - Insiders/User/"
  "$HOME/Library/Application Support/Code/User/"
)

for JSON in "${JSON_FILES[@]}"; do
  for DIR in "${DIRS[@]}"; do
    SOURCE="$DOTDIR/$JSON.json"
    LINK="$DIR/$JSON.json"
    [[ -f $SOURCE ]] && mv "$SOURCE" "$DOTDIR/automatic_backups/$JSON/$JSON_$(date +"%Y_%m_%d").json"
    if [[ ! -L "$LINK" ]]; then
      ln -sfnv "$SOURCE" "$LINK"
    fi
  done
done


