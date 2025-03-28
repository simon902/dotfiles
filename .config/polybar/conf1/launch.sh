#!/bin/sh

killall polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

alias poly="polybar -c ~/.config/polybar/config.ini"

primary_monitor=$(jq -r '.monitor_primary' $HOME/.config/bspwm/screen.json)
secondary_monitor=$(jq -r '.monitor_sequence.[] | select(.!="'$primary_monitor'")' $HOME/.config/bspwm/screen.json | head -n 1)

MONITOR=$primary_monitor   poly status &
MONITOR=$secondary_monitor poly status2 &
MONITOR=$primary_monitor   poly workspaces-1 &
MONITOR=$secondary_monitor poly workspaces-2 &
