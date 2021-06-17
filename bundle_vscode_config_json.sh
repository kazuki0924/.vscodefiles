#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

DIR="$HOME/.vscodefiles"
mapfile -t FILES < <(fd settings.json "${1-$DIR}")

for FILE in "${FILES[@]}"; do
  strip-json-comments "$FILE" > "$FILE.output"
done

jq -rs 'reduce .[] as $item ({}; . * $item)' ./**/**/*.output > settings.json

mapfile -t OUTPUTS < <(fd .output "${1-$DIR}")

for OUTPUT in "${OUTPUTS[@]}"; do
  trash-put -v $OUTPUT
done