#!/bin/bash

# Get the current layout
CURRENT_LAYOUT=$(hyprctl getoption general:layout | grep -o 'dwindle\|master\|scrolling')

# Toggle between dwindle and master layouts
if [ "$CURRENT_LAYOUT" = "dwindle" ]; then
    echo '{"alt": "default", "tooltip": "Dwindle active"}'
elif [ "$CURRENT_LAYOUT" = "master" ]; then
    echo '{"alt": "master", "tooltip": "Master active"}'
else 
    echo '{"alt": "hyprscroller", "tooltip": "HyprScroller active"}'
fi
