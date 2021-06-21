#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: setups

# create symlink for shell integration
VSC_INSIDERS_DIR="/Applications/Visual Studio Code - Insiders.app"
VSC_APP_BIN="/Applications/Visual Studio Code/Contents/Resources/app/bin/code"
VSC_USR_BIN="/usr/local/bin/code"
if [[ -d $VSC_INSIDERS_DIR ]]; then
  VSC_INSIDERS_USR_BIN="/usr/local/bin/code-insiders"
  VSC_APP_BIN="/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin/code"
  if [[ ! -L "$VSC_INSIDERS_USR_BIN" ]]; then
    ln -s "$VSC_APP_BIN" "$VSC_INSIDERS_USR_BIN"
  fi
fi
if [[ ! -L "$VSC_USR_BIN" ]]; then
  ln -s "$VSC_APP_BIN" "$VSC_USR_BIN"
fi
