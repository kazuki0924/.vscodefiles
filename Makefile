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

all: gitpull symlink

gitpull:
> @ echo git pull .dotfiles, .nvimfiles, .zshfiles, and .dotscripts:
> @ cd ~/.dotfiles && git pull
> @ [[ ! -d ~/.nvimfiles ]] && git clone https://github.com/kazuki0924/.nvimfiles ~/.nvimfiles
> @ cd ~/.nvimfiles && git pull
> @ [[ ! -d ~/.zshfiles ]] && git clone https://github.com/kazuki0924/.zshfiles ~/.zshfiles
> @ cd ~/.zshfiles && git pull
> @ [[ ! -d ~/.dotscripts ]] && git clone https://github.com/kazuki0924/.dotscripts ~/.dotscripts
> @ cd ~/.dotscripts && git pull
> @ cd

symlink:
> @ cd ~/.dotscripts && make symlink

.PHONY: gitpull symlink
