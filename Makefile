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

all: setup

gitpull:
> @ echo git pull .vscodefiles:
> @ [[ ! -d ~/.vscodefiles ]] && git clone https://github.com/kazuki0924/.vscodefiles ~/.vscodefiles
> @ cd ~/.vscodefiles && git pull

symlink:
> @ ./scripts/vscode_bundle_config_json.sh
> @ ./scripts/vscode_symlink_config_json.sh

uninstall/extension:
> @ ./scripts/vscode_symlink_config_json.sh

bundle/extension:
> @ ./scripts/vscode_bundle_extensions_file.sh

setup: gitpull symlink
> @ ./scripts/vscode_uninstall_extensions.sh

chmod:
> @ bash ~/.dotscripts/tasks/chmod_dotscripts.sh ~/.vscodefiles

.PHONY: gitpull symlink setup uninstall/extension
