#           _
#   _______| |__
#  |_  / __|  _ \
#   / /\__ \ | | |
#  /___|___/_| |_|
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

nitch
#neofetch
#colorscript random

autoload -U colors && colors

# History
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTFILE=~/.cache/zsh/history

# man 1 zshoptions
setopt SHARE_HISTORY # includes INC_APPEND_HISTORY, EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Autocomplete
zmodload zsh/complist

zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# for all completions: color
#eval "$(dircolors)"
export LS_COLORS="$(vivid generate molokai)" # https://github.com/sharkdp/vivid
#. /usr/share/LS_COLORS/dircolors.sh
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Man Pages
# FZF: F1/F2 to cycle through groups
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man.*' menu yes select


autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.


# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;} 


# Copies the contents of a given file to the system or X Windows clipboard
function copyfile {
  emulate -L zsh
  xclip -in -selection clipboard < "${1:-/dev/stdin}"
}


# Aliases
#
source $HOME/repos/dotfiles/.config/zsh/aliases

alias vim='nvim'
alias rg='source ranger'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 'Exa': Replacement for 'ls'
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | grep "^\."'

# Pacman
alias pkglist='pacman -Qqe | grep -v "$(pacman -Qqm)"'
alias aurlist='pacman -Qqe | grep "$(pacman -Qqm)"'

# Misc
alias memdir='du . -hd 1 | sort -hr'
alias mirrors='sudo reflector --verbose -c AT -c DE -c CH -c IT -c FR -a 12 -p https --sort rate -n 10 --save /etc/pacman.d/mirrorlist'
alias fp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'



# Plugins
#
ZVM_INIT_MODE=sourcing
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh 2>/dev/null
# Remove keybinding in order to use ^R of the zsh-fzf-history-search plugin
bindkey -r "^R"

source $HOME/repos/dotfiles/.config/zsh/scripts/fzf-tab/fzf-tab.plugin.zsh
source $HOME/repos/dotfiles/.config/zsh/scripts/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh 2> /dev/null
eval "$(lua $HOME/repos/dotfiles/.config/zsh/scripts/z.lua/z.lua --init zsh)"
source $HOME/repos/dotfiles/.config/zsh/scripts/colored-man-pages.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null



# Starship Prompt
case $(tty) in
	(/dev/tty[1-9]) ;;
	(*) 		eval "$(starship init zsh)";;
esac

