#!/bin/bash

CONFIG_ROOT=$1

touch "$CONFIG_ROOT/.config/zsh/aliases" # if file already existed touch doesn't override
mkdir -p "$CONFIG_ROOT/.config/zsh/scripts/"
cd "$CONFIG_ROOT/.config/zsh/scripts/"

[ ! -d "fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab
