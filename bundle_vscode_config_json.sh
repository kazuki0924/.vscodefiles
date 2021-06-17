#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

jq -rs 'reduce .[] as $item ({}; . * $item)' **/settings.jsonc > settings.json
