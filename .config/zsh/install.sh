#!/bin/sh

touch $CONFIG_ROOT/.config/zsh/aliases # if file already existed touch doesn't override

cd $CONFIG_ROOT"/.config/zsh/scripts/"

[ ! -d "fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab
[ ! -d "z.lua" ] && git clone https://github.com/skywind3000/z.lua.git
[ ! -d "zsh-fzf-history-search" ] && git clone https://github.com/joshskidmore/zsh-fzf-history-search.git

cd $CONFIG_ROOT
