#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

REQUIREMENTS=(
  jq
  fd
)

for REQUIREMENT in "${REQUIREMENTS[@]}"; do
  which "$REQUIREMENT" &>/dev/null || brew install "$REQUIREMENT"
done

# https://github.com/sindresorhus/strip-json-comments-cli
which strip-json-comments &>/dev/null || npm i -g strip-json-comments-cli