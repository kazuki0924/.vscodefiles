#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code Insiders: install extensions from .txt file

FILE="$HOME/.dotfiles/.config/vs-code/extensions.txt"

# install extensions
while read -r LINE; do
  code-insiders --force --install-extension "$LINE"
done <"$FILE"
