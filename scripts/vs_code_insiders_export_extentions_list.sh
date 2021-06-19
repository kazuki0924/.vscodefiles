#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code Insiders; export extensions as .txt file

DIR=$HOME/.dotfiles/.config/vs-code
FILENAME="extensions.txt"
FILE="$DIR/$FILENAME"

mkdir -p "$DIR"
code-insiders --list-extensions >"$FILE"
