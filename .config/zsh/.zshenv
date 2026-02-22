path=($HOME"/.local/bin" $path)
path=($HOME"/.local/scripts" $path)
path+=($HOME"/.cabal/bin")
path+=($HOME"/.ghcup/bin")
path+=($HOME"/.cargo/bin")
export PATH
#export PATH="/usr/lib/ccache/bin/:$PATH"

export QT_QPA_PLATFORMTHEME=qt5ct
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia

# Default Programs
export BROWSER=firefox
export TERMINAL=alacritty
export VISUAL=nvim
export EDITOR=nvim
export READER=zathura
export IMAGE=nsxiv
export VIDEO=mpv

export JDK_HOME=/usr/lib/jvm/java-11-openjdk

# To fix colored man pages
export GROFF_NO_SGR=1

export PYTHON_HISTORY="$HOME/.local/state/python_history"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

