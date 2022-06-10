# eval $(ssh-agent)

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep bspwm || startx
fi
