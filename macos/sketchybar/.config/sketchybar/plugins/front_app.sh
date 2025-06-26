#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO" icon="$($CONFIG_DIR/icon_map_fn "$INFO")"
fi


# sketchybar --add item front_app left \
#            --set front_app       background.color=0x44550000\
#                                  icon.color=0x44550000 \
#                                  icon.font="Hack Nerd Font:Bold:17.0" \
#                                  label.color=0x44550000 \
#                                  script="$PLUGIN_DIR/front_app.sh"            \
#            --subscribe front_app front_app_switched
