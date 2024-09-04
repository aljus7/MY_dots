#!/bin/bash

gammastep_statusjoza=$(pgrep gammastep) # Check if gammastep is running
if [ ! -z "$gammastep_statusjoza" ]; then
 # Terminate gammastep
 pkill gammastep
else
 # Start gammastep
 gammastep -O 2700 &
fi
