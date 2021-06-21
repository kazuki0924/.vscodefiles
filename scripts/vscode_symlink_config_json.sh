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

generate_backup_filename() {
	echo "$DOTDIR"/automatic_backups/"$JSON"/"$JSON"_"${1-$(date +"%Y_%m_%d")}".json
}

for JSON in "${JSON_FILES[@]}"; do
	for DIR in "${DIRS[@]}"; do
		[[ ! -d $DIR ]] && continue
		SOURCE="$DOTDIR/$JSON.json"
		LINK="$DIR/$JSON.json"
		BACKUP_FILE="$(generate_backup_filename)"
		if [[ ! -L "$LINK" ]]; then
			if [[ -f $LINK ]]; then
				if [[ -f $BACKUP_FILE ]]; then
					BACKUP_FILE="$(generate_backup_filename "$(date +"%Y_%m_%d_%H%M%S")")"
				fi
				mv -v "$LINK" "$BACKUP_FILE"
			fi
			ln -sfnv "$SOURCE" "$LINK"
		fi
	done
done
