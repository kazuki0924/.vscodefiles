SHELL := bash
.ONESHELL:
.DELETE_ON_ERROR:
.SHELLFLAGS := -Eeuo pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

all: gitpull symlink setup

gitpull:
> @ echo git pull .vscodefiles:
> @ [[ ! -d ~/.vscodefiles ]] && git clone https://github.com/kazuki0924/.vscodefiles ~/.vscodefiles
> @ cd ~/.vscodefiles && git pull

symlink:
> @ ./scripts/vscode_bundle_config_json.sh
> @ ./scripts/vscode_symlink_config_json.sh

setup: gitpull symlink
> @ ./scripts/vscode_setup.sh
# > @ ./"$HOME"/.dotscripts/tasks/chmod_dotscripts.sh "$HOME"/.vscodefiles

.PHONY: gitpull symlink setup
