#!/bin/bash
sleep 0.1
gammastep_status=$(systemctl --user is-active gammastep.service) # Check if the service is running

if [ "$gammastep_status" == "active" ]; then
  echo '{"class": "on", "tooltip": "Nightlight Active"}'
else
  echo '{"class": "", "tooltip": "Nightlight Not Active"}'
fi

