#!/bin/bash

# Get the current layout
CURRENT_LAYOUT=$(hyprctl getoption general:layout | grep -o 'dwindle\|master\|scrolling')

# Toggle between dwindle and master layouts
if [ "$CURRENT_LAYOUT" = "dwindle" ]; then
    hyprctl keyword general:layout master
    #hyprctl notify -1 5000 "rgb(ff1ea3)" "Switched to Master Layout."
    pkill -RTMIN+3 waybar
elif [ "$CURRENT_LAYOUT" = "master" ]; then
    hyprctl keyword general:layout scrolling
    #hyprctl notify -1 5000 "rgb(ff1ea3)" "Switched to Dwindle Layout."
    pkill -RTMIN+3 waybar
else
    hyprctl keyword general:layout dwindle
    #hyprctl notify -1 5000 "rgb(ff1ea3)" "Switched to Scrolling Layout."
    pkill -RTMIN+3 waybar
fi
