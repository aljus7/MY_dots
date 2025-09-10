#!/bin/bash 
ID_FILE="/tmp/brightness-noti-id"
CLEANUP_FLAG="/tmp/brightness-noti-cleanup-flag"

BRIGHTNESS=$(brightnessctl g) 
MAX=$(brightnessctl m) 
PERCENT=$((BRIGHTNESS * 100 / MAX)) 
BARS=$(echo "$BRIGHTNESS * 17 / $MAX" | bc)
ASCI_BAR="" 

for ((i = 0; i < 17; i++)); do 
	if [ $i -lt $BARS ]; then 
		ASCI_BAR+="■" 
	else 
		ASCI_BAR+="▢" 
	fi 
done 

# Send a transient notification with swaync-client 
if [ -f "$ID_FILE" ]; then
    ID=$(cat "$ID_FILE")
    if ! [[ "$ID" =~ ^[0-9]+$ ]]; then
        ID=$(notify-send -u low -t 2000 -p -e "Brightness: [ ${ASCI_BAR}  ${PERCENT}% ]")
    else
    	ID=$(notify-send -u low -t 2000 -p -r "$ID" -e "Brightness: [ ${ASCI_BAR}  ${PERCENT}% ]")
    fi
else
    ID=$(notify-send -u low -t 2000 -p -e "Brightness: [ ${ASCI_BAR}  ${PERCENT}% ]")
fi

if [[ "$ID" =~ ^[0-9]+$ ]]; then
    echo "$ID" > "$ID_FILE"
else
    echo "Warning: notify-send failed or no ID returned"
fi

# Check if the flag exists ## id's always inrement after every notification
#if [ ! -f "$CLEANUP_FLAG" ]; then
#    touch "$CLEANUP_FLAG"
#    (/home/aljosa/.config/myScripts/BrightnessPopup/brightnessPopupDelete.sh && rm -f "$CLEANUP_FLAG") &
#fi
