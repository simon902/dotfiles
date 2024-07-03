#!/bin/sh

CONFIG_ROOT=$1

if [[ ! -f "$CONFIG_ROOT/.config/bspwm/screen.json" ]]; then
  echo "SCREEN TEMPLATE"
  SCREEN_CONF_DIR="$CONFIG_ROOT/.config/bspwm/screen.json"
  cp "$CONFIG_ROOT/.config/bspwm/template/screen.json" $SCREEN_CONF_DIR

  monitor_sequence=$(xrandr -q | awk '$2 == "connected" {print "\""$1}' ORS='", ')

  jq -r '.monitor_primary='"$(echo $monitor_sequence | cut -d',' -f 1)" $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
  jq -r '.monitor_sequence=['"${monitor_sequence::-2}"']' $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
  jq -r '.bspwm_sequence=['"${monitor_sequence::-2}"']' $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
fi