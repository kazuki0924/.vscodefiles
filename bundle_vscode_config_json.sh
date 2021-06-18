#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
shopt -s globstar

DOTDIR="${1-$HOME/.vscodefiles}"

JSON_FILES=(
  settings
  keybindings
)

for JSON in "${JSON_FILES[@]}"; do
  DOT_FILE="$DOTDIR/$JSON.json"
  [[ -f $DOT_FILE ]] && trash-put -v $DOT_FILE
done

mapfile -t FILES < <(fd "(settings.json|keybindings.json)" "$DOTDIR")

for FILE in "${FILES[@]}"; do
  strip-json-comments "$FILE" > "$FILE.output"
done

jq -rsS 'reduce .[] as $item ({}; . * $item)' **/settings.json.output > settings.json
jq -rsS flatten **/keybindings.json.output > keybindings.json

mapfile -t OUTPUTS < <(fd .output "$DOTDIR")

for OUTPUT in "${OUTPUTS[@]}"; do
  trash-put -v $OUTPUT
done