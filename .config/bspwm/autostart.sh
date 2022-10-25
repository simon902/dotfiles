#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Multiple Monitors

# --------
DuplicateScreen()
{
  echo "--- Duplicate Screen ---"
  first_monitor=$(echo $MONITORS | cut -d' ' -f 1)
  monitors=$(echo $MONITORS | cut -d' ' -f 2-)
  bspc monitor $first_monitor -d I II III IV V VI VII VIII

  while IFs= read -r monitor; do
    echo $monitor
    #bspc monitor $monitor -d I II III IV V VI VII VIII
    xrandr --output $monitor --primary --mode 1920x1080 --same-as $first_monitor
    
  done <<< "$monitors"
}

# --------
SplitScreen()
{
  echo "--- Split Screen ---"
  
  monitor_primary=$(grep -e "MONITOR_PRIMARY" $HOME"/.config/bspwm/screen.conf" | cut -d'=' -f2)
  monitor_sequence=$(grep -e "MONITOR_SEQUENCE" $HOME"/.config/bspwm/screen.conf" | cut -d'=' -f2)

  placing_left=True

  for monitor in $monitor_sequence; do
    
    echo "" ; echo "Settings for $monitor"

    if [[ $monitor = $monitor_primary ]]; then
      echo "Found primary monitor $monitor_primary"
      placing_left=False
      xrandr --output $monitor --primary --mode 1920x1080
      bspc monitor $monitor -d I II III IV
    elif [[ $placing_left = True ]]; then
      echo "Placing $monitor left of primary $monitor_primary"
      xrandr --output $monitor --mode 1920x1080 --left-of $monitor_primary
      bspc monitor $monitor -d V VI VII VIII 
    else
      echo "Placing $monitor right of primary $monitor_primary"
      xrandr --output $monitor --mode 1920x1080 --right-of $monitor_primary
      bspc monitor $monitor -d V VI VII VIII 
    fi
  done
     # bspc monitor -d '' '' '' '' '' '' '' ''
}



# ------- MAIN -------

MONITORS=$(xrandr | awk '$2 == "connected" { print $1 }')
echo $MONITORS

if [[ $(cat ${HOME}"/.config/bspwm/screen.conf" | awk '$1 == "duplicate" { print $2}') = "TRUE" ]]; then
 DuplicateScreen $MONITORS
else
  SplitScreen
fi



xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Speed" -0.7
xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Profiles Available" flat
xinput set-prop "Logitech M705" "libinput Accel Speed" -0.7
xinput set-prop "Logitech M705" "libinput Accel Profiles Available" flat

$HOME/.config/polybar/launch.sh


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

#xbacklight -set 40

if ! pgrep lxpolkit; then
	/usr/bin/lxpolkit &
fi

