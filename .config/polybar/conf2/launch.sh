#!/bin/bash


#MONITOR="eDP" polybar -c ~/.config/polybar/config.ini main &
#MONITOR="HDMI-A-0" polybar -c ~/.config/polybar/config.ini main &

killall polybar
	# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for monitor in $(xrandr -q | grep " connected" | cut -d' ' -f1); do
  echo "Starting Bar on monitor $monitor"
  MONITOR=$monitor polybar -c ~/.config/polybar/config.ini main &
done

