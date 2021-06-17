#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
shopt -s globstar

# TODO: requirements, backup original and copy files, extensions, extensions install etc

DIR="$HOME/.vscodefiles"
mapfile -t FILES < <(fd settings.json "${1-$DIR}")

for FILE in "${FILES[@]}"; do
  strip-json-comments "$FILE" > "$FILE.output"
done

jq -rs 'reduce .[] as $item ({}; . * $item)' **/*.output > settings.json

mapfile -t OUTPUTS < <(fd .output "${1-$DIR}")

for OUTPUT in "${OUTPUTS[@]}"; do
  trash-put -v $OUTPUT
done

jq -rs flatten **/keybindings.json > keybindings.json