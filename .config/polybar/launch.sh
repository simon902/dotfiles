#!/bin/sh

killall polybar
alias poly="polybar -c ~/.config/polybar/config.ini"

poly status &
poly status2 &
poly workspaces-1 &
poly workspaces-2 &

#poly status-laptop &
#poly workspaces-laptop &:wq
