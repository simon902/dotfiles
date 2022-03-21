# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#neofetch
colorscript random

autoload -U colors && colors

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.cache/zsh/history

# Autocomplete
#zstyle ':completion:*' completer _expand _complete _ignored
#zstyle :compinstall filename '/home/simon/.zshrc'

zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# for all completions: color
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Man Pages
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' insert-sections true

zmodload zsh/complist
autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.


# VI mode
bindkey -v
export KEYTIMEOUT=1

bindkey '^[[3~' vi-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Aliases
alias vim='nvim'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 'Exa': Replacement for 'ls'
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | grep "^\."'

alias mirrors='sudo reflector --verbose -c AT -c DE -c CH -c IT -c FR -a 12 -p https --sort rate -n 10 --save /etc/pacman.d/mirrorlist'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 2>/dev/null

# Starship Prompt
case $(tty) in
	(/dev/tty[1-9]) ;;
	(*) 		eval "$(starship init zsh)";;
esac

