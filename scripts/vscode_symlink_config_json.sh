#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

DOTDIR="${1-$HOME/.vscodefiles}"

JSON_FILES=(
  settings
  keybindings
)

DIRS=(
  "$HOME/Library/Application Support/Code - Insiders/User"
  "$HOME/Library/Application Support/Code/User"
)

for JSON in "${JSON_FILES[@]}"; do
  for DIR in "${DIRS[@]}"; do
    [[ ! -d $DIR ]] && continue
    SOURCE="$DOTDIR/$JSON.json"
    LINK="$DIR/$JSON.json"
    BACKUP_FILE="$DOTDIR/automatic_backups/$JSON/"$JSON"_$(date +"%Y_%m_%d").json"
    if [[ -f BACKUP_FILE ]]; then
      [[ -f $SOURCE ]] && mv "$LINK" "$DOTDIR/automatic_backups/$JSON/"$JSON"_$(date +"%Y_%m_%d_%H%M%S").json"
    else
      [[ -f $SOURCE ]] && mv "$LINK" "$BACKUP_FILE"
    fi
    if [[ ! -L "$LINK" ]]; then
      ln -sfnv "$SOURCE" "$LINK"
    fi
  done
done


