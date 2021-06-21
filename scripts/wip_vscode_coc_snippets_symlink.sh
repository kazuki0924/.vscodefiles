#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# coc.nivm: symlink vscode snippets to coc

VS_CODE_SNIPPETS_DIR="$HOME/.dotfiles/Library/Application Support/Code - Insiders/User/snippets"
COC_SNIPPETS_DIR="$HOME/.config/coc/vsc-snippets"

mkdir -p "$COC_SNIPPETS_DIR"

VS_CODE_SOURCE_FILE_NAMES=(
	shellscript
)

COC_LINK_NAMES=(
	sh
)

SOURCE_FILES_COUNT=${#VS_CODE_SOURCE_FILE_NAMES[@]}
LINK_NAMES_COUNT=${#COC_LINK_NAMES[@]}

if [[ ! "$SOURCE_FILES_COUNT" = "$LINK_NAMES_COUNT" ]]; then
	echo numbr of source files and link names must match.
	exit 1
fi

for IDX in $(seq 1 "$SOURCE_FILES_COUNT"); do
	SOURCE="$VS_CODE_SNIPPETS_DIR/${VS_CODE_SOURCE_FILE_NAMES[$(("$IDX" - 1))]}.json"
	LINK="$COC_SNIPPETS_DIR/${COC_LINK_NAMES[$(("$IDX" - 1))]}.json"

	if [[ ! -L "$LINK" ]]; then
		ln -sfnv "$SOURCE" "$LINK"
	fi
done
