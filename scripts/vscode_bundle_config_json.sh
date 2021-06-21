#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
shopt -s globstar

# VS Code / VS Code Insiders: bundle all json files

REQUIREMENTS=(
  jq
  fd
  node
)

for REQUIREMENT in "${REQUIREMENTS[@]}"; do
  which "$REQUIREMENT" &>/dev/null || brew install "$REQUIREMENT"
done

# https://github.com/sindresorhus/strip-json-comments-cli
which strip-json-comments &>/dev/null || npm i -g strip-json-comments-cli

DOTDIR="$HOME/.vscodefiles"

JSON_FILES=(
  settings
  keybindings
)

for JSON in "${JSON_FILES[@]}"; do
  DOT_FILE="$DOTDIR/$JSON.json"
  [[ -f $DOT_FILE ]] && trash-put -v $DOT_FILE
done

EXTENSIONSDIR="${1-$HOME/.vscodefiles}"

mapfile -t FILES < <(fd "(settings.json|keybindings.json)" "$EXTENSIONSDIR")

for FILE in "${FILES[@]}"; do
  strip-json-comments "$FILE" > "$FILE.output"
done

cd $EXTENSIONSDIR
jq -rsS 'reduce .[] as $item ({}; . * $item)' **/settings.json.output > settings.json
jq -rsS flatten **/keybindings.json.output > keybindings.json

mapfile -t OUTPUTS < <(fd .output "$DOTDIR")

for OUTPUT in "${OUTPUTS[@]}"; do
  trash-put $OUTPUT
done
