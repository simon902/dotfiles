#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Multiple Monitors

function getScreenRatio() {
	#echo $(xrandr | grep $1 -A 1 | sed '2q;d' | awk '{ print $1}')
  echo "1920x1080"
}

# --------
function DuplicateScreen()
{
  echo "--- Duplicate Screen ---" ; echo ""

  monitor_primary=$(jq -r '.monitor_primary' $SCREEN_CONFIG)
  monitor_sequence=($(jq -r '.monitor_sequence.[]' $SCREEN_CONFIG))

  for monitor in "${monitor_sequence[@]}"; do
    monitor_ratio=$(getScreenRatio $monitor)

    if [[ "$monitor" = "$monitor_primary" ]]; then
      echo "Found primary monitor $monitor_primary with ratio $monitor_ratio"
      xrandr --output "$monitor_primary" --primary --mode "$monitor_ratio"
      bspc monitor "$monitor" -d I II III IV V VI VII VIII
    else
      echo "Found $monitor with ratio $monitor_ratio"
      #bspc monitor $monitor -d I II III IV V VI VII VIII
      xrandr --output "$monitor" --mode "$monitor_ratio" --same-as "$monitor_primary"
    fi
  done
  echo ""
}

# --------
function SplitScreen()
{
  echo "--- Split Screen ---"
  
  monitor_primary=$(jq -r '.monitor_primary' $SCREEN_CONFIG)
  monitor_sequence=($(jq -r '.monitor_sequence.[]' $SCREEN_CONFIG))

  placing_left=true

  for monitor in "${monitor_sequence[@]}"; do
    
    echo "" ; echo "Settings for $monitor"
    monitor_ratio=$(getScreenRatio $monitor)

    if [[ "$monitor" = "$monitor_primary" ]]; then
      echo "Found primary monitor $monitor_primary with ratio $monitor_ratio"
      placing_left=False
      xrandr --output "$monitor" --primary --mode "$monitor_ratio"
      bspc monitor "$monitor" -d I II III IV
    elif [[ "$placing_left" = true ]]; then
      echo "Placing $monitor left of primary $monitor_primary with ratio $monitor_ratio"
      xrandr --output "$monitor" --mode "$monitor_ratio" --left-of "$monitor_primary"
      bspc monitor "$monitor" -d V VI VII VIII 
    else
      echo "Placing $monitor right of primary $monitor_primary with ratio $monitor_ratio"
      xrandr --output "$monitor" --mode "$monitor_ratio" --right-of "$monitor_primary"
      bspc monitor "$monitor" -d V VI VII VIII 
    fi
  done
  echo ""
     # bspc monitor -d '' '' '' '' '' '' '' ''
}



# ------- MAIN -------

MONITORS=$(xrandr | awk '$2 == "connected" { print $1 }')
echo $MONITORS

SCREEN_CONFIG="$HOME/.config/bspwm/screen.json"

do_mirror=$(jq -r '.duplicate' $SCREEN_CONFIG ) 


case $do_mirror in
  true) DuplicateScreen $MONITORS;;
  false) SplitScreen $MONITORS;;
  *) SplitScreen $MONITORS;;
esac


xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Speed" -0.7
xinput set-prop "ROCCAT ROCCAT Kone Aimo Mouse" "libinput Accel Profiles Available" flat
xinput set-prop "Logitech M705" "libinput Accel Speed" -0.7
xinput set-prop "Logitech M705" "libinput Accel Profiles Available" flat


# reset top padding: needed if polybar margin-bottom is changed
bspc config top_padding 0
# Do not ignore space allocation requests from e.g. polybar
bspc config ignore_ewmh_struts false


killall "sxhkd"
sxhkd &
#run picom --config $HOME/.config/bspwm/picom.conf

setxkbmap -layout de
xsetroot -cursor_name left_ptr &
# numlockx on &

nitrogen --restore &
run redshift-gtk
run flameshot
run nm-applet

run volumeicon

run dunst

pgrep bspswallow || ~/.local/scripts/bspswallow &

if ! pgrep lxpolkit; then
	/usr/bin/lxpolkit &
fi


$HOME/.config/polybar/launch.sh

killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# Launch picom
picom &

# Somehow after polybar top_padding is set to 34
# If top_padding is not reset to 0, for not currently active workspaces the windows overlap the bar
for monitor in $(bspc query -M); do
    bspc config -m $monitor top_padding 0
done
