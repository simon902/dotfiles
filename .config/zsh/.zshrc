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
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Autocomplete
zmodload zsh/complist

# use completion menu from fzf-tab
zstyle ':completion:*' menu no
# Auto complete with case insenstivity
 zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# for all completions: color
export LS_COLORS="$(vivid generate molokai)" # https://github.com/sharkdp/vivid
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Man Pages
# FZF: F1/F2 to cycle through groups
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man.*' menu yes select

# preview directory's content with eza when completing with cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'


autoload -Uz compinit && compinit -d ~/.cache/zsh/.zcompdump 
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
source "$HOME/.config/zsh/aliases"

alias vim='nvim'
alias rg='source ranger'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 'Exa': Replacement for 'ls'
alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first'
alias l.='eza -a | grep "^\."'

# Pacman
alias pkglist='pacman -Qqen'
alias aurlist='pacman -Qqem'

# Misc
alias memdir='du . -hd 1 | sort -hr'
alias mirrors='sudo reflector --verbose -c AT -c DE -c CH -c IT -c FR -a 12 -p https --sort rate -n 10 --save /etc/pacman.d/mirrorlist'
alias fp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" --print0 | xargs -0 -o nvim'



# Plugins
#
ZVM_INIT_MODE=sourcing
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh 2>/dev/null

source "$HOME/.config/zsh/scripts/fzf-tab/fzf-tab.plugin.zsh"
# fzf keybindings (history search) + completions
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
source "$HOME/.config/zsh/scripts/colored-man-pages.zsh"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null



# Starship Prompt
case $(tty) in
	(/dev/tty[1-9]) ;;
	(*) 		eval "$(starship init zsh)";;
esac

