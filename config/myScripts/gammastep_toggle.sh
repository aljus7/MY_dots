#!/bin/bash

gammastep_statusjoza=$(systemctl --user is-active gammastep.service) # Check if the service is running

if [ "$gammastep_statusjoza" == "active" ]; then
  # Stop the service
  systemctl --user stop gammastep.service
  # hyprctl notify -1 5000 "rgb(ffbf00)" "Nightlight Deactivated."
  pkill -RTMIN+2 waybar
else
  # Start the service
  systemctl --user start gammastep.service
  # hyprctl notify -1 5000 "rgb(ffbf00)" "Nightlight Activated."
  pkill -RTMIN+2 waybar
fi

