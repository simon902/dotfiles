#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Speed" -0.7
xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Profiles Available" flat
xinput set-prop "Logitech M705" "libinput Accel Speed" -0.7
xinput set-prop "Logitech M705" "libinput Accel Profiles Available" flat

$HOME/.config/polybar/launch.sh &


killall "sxhkd"
sxhkd &
#run picom --config $HOME/.config/bspwm/picom.conf

setxkbmap -layout de
xsetroot -cursor_name left_ptr &
numlockx on &

nitrogen --restore &
run redshift-gtk
run flameshot
run nm-applet

run volumeicon

run dunst
