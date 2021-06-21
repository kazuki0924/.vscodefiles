#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: setups

# create symlink for shell integration
ln -s "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin/code" "/usr/local/bin/code-insiders"
ln -s "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin/code" "/usr/local/bin/code"
