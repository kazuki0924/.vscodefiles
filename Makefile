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

setup: symlink

.PHONY: setup

symlink:
> @ ./scripts/vscode_bundle_config_json.sh
> @ ./scripts/vscode_symlink_config_json.sh

.PHONY: symlink

uninstall/extension:
> @ ./scripts/vscode_symlink_config_json.sh

.PHONY: uninstall/extension

bundle/extension:
> @ ./scripts/vscode_bundle_extensions_file.sh
