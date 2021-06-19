#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

# VS Code / VS Code Insiders: install extensions

# EXTENSIONS=(
# 	766b.go-outliner
# 	aaron-bond.better-comments
# 	ahmadawais.shades-of-purple
# 	akamud.vscode-theme-onedark
# 	aslamanver.vsc-export
# 	asvetliakov.vscode-neovim
# 	bierner.color-info
# 	bierner.docs-view
# 	bierner.emojisense
# 	bierner.markdown-checkbox
# 	bierner.markdown-emoji
# 	bierner.markdown-footnotes
# 	bierner.markdown-preview-github-styles
# 	bierner.markdown-yaml-preamble
# 	bmalehorn.shell-syntax
# 	bpruitt-goddard.mermaid-markdown-syntax-highlighting
# 	christian-kohler.npm-intellisense
# 	christian-kohler.path-intellisense
# 	CodeStream.codestream
# 	codezombiech.gitignore
# 	CoenraadS.bracket-pair-colorizer-2
# 	darkriszty.markdown-table-prettify
# 	DavidAnson.vscode-markdownlint
# 	dbaeumer.vscode-eslint
# 	dracula-theme.theme-dracula
# 	eamodio.gitlens
# 	edgarjs.next-js-commands
# 	EditorConfig.EditorConfig
# 	eg2.vscode-npm-script
# 	esbenp.prettier-vscode
# 	formulahendry.auto-close-tag
# 	formulahendry.auto-rename-tag
# 	GitHub.github-vscode-theme
# 	gizak.shortcuts
# 	golang.go
# 	Gruntfuggly.bettercomment
# 	IBM.output-colorizer
# 	imagio.vscode-dimmer-block
# 	ipatalas.vscode-postfix-ts
# 	jdinhlife.gruvbox
# 	jeff-hykin.better-shellscript-syntax
# 	johnpapa.winteriscoming
# 	jolaleye.horizon-theme-vscode
# 	kaisun.vscodevimacademy
# 	kevinmcgowan.TypeScriptImport
# 	kisstkondoros.vscode-gutter-preview
# 	leizongmin.node-module-intellisense
# 	MaxMedia.go-prof
# 	mgmeyers.markdown-writer-theme
# 	mhutchie.git-graph
# 	miclo.sort-typescript-imports
# 	mike-co.import-sorter
# 	mikestead.dotenv
# 	mishkinf.goto-next-previous-member
# 	ms-azuretools.vscode-docker
# 	ms-vscode.Theme-MarkdownKit
# 	nhoizey.gremlins
# 	Noctarya.terminals
# 	oderwat.indent-rainbow
# 	ohanedan.lowlight-go-errors
# 	pflannery.vscode-versionlens
# 	PKief.material-icon-theme
# 	pmneo.tsimporter
# 	premparihar.gotestexplorer
# 	PulkitGangwar.nextjs-snippets
# 	redhat.vscode-yaml
# 	RedVanWorkshop.explorer-exclude-vscode-extension
# 	richie5um2.vscode-sort-json
# 	ryu1kn.partial-diff
# 	sainnhe.gruvbox-material
# 	sdras.night-owl
# 	shd101wyy.markdown-preview-enhanced
# 	sortafreel.markdown-edit-theme
# 	streetsidesoftware.code-spell-checker
# 	stylelint.vscode-stylelint
# 	svipas.control-snippets
# 	TabNine.tabnine-vscode
# 	timonwong.shellcheck
# 	tombonnike.vscode-status-bar-format-toggle
# 	tomphilbin.gruvbox-themes
# 	trixnz.go-to-method
# 	usernamehw.errorlens
# 	VisualStudioExptTeam.vscodeintellicode
# 	vstirbu.vscode-mermaid-preview
# 	Wattenberger.footsteps
# 	wix.vscode-import-cost
# 	wwm.better-align
# 	XadillaX.viml
# 	yzhang.markdown-all-in-one
# 	zhuangtongfa.material-theme

# 	# Horizon Theme
# 	# https://github.com/jolaleye/horizon-theme-vscode
# 	https://marketplace.visualstudio.com/items?itemName=jolaleye.horizon-theme-vscode

#   # Live Server
#   # https://github.com/ritwickdey/vscode-live-server
#   # https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer
# )

FILE=${1:-$HOME/.vscodefiles/.vscode-extensions}

while read -r LINE; do
  LINE="$(echo "${LINE%%#*}" | tr -d ' ')"
	[ -z "$LINE" ] && continue
	EXTENSION="$(echo "$LINE" | awk -F "itemName=" '{print $NF}')"
  ARGS="--force --install-extension $EXTENSION"
  if which code &>/dev/null; then
    code "${ARGS[@]}"
  elif which code-insiders &>/dev/null;  then
    code-insiders "${ARGS[@]}"
  fi
	echo installed "$EXTENSION"
done < "$FILE"
