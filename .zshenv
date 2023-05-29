export ZDOTDIR=$HOME/.config/zsh

path+=('/home/simon/.local/bin')
path+=('/home/simon/.local/scripts')
path+=('/home/simon/.cabal/bin')
path+=('/home/simon/.ghcup/bin')
export PATH
#export PATH="/usr/lib/ccache/bin/:$PATH"

export QT_QPA_PLATFORMTHEME=qt5ct
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia

# Default Programs
export BROWSER=firefox
export TERMINAL=alacritty
export EDITOR=nvim
export READER=zathura
export IMAGE=sxiv
export VIDEO=mpv
