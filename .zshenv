export ZDOTDIR=$HOME/.config/zsh

path+=($HOME"/.local/bin")
path+=($HOME"/.local/scripts")
path+=($HOME"/.cabal/bin")
path+=($HOME"/.ghcup/bin")
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

export JDK_HOME=/usr/lib/jvm/java-11-openjdk

