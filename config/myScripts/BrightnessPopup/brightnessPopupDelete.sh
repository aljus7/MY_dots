#!/bin/bash

FILE="/tmp/brightness-noti-id"
THRESHOLD=2  # seconds

while true; do
    if [ -f "$FILE" ]; then
        MOD_TIME=$(stat -c %Y "$FILE")
        NOW=$(date +%s)
        AGE=$((NOW - MOD_TIME))

        if [ "$AGE" -gt "$THRESHOLD" ]; then
            echo "Deleting stale file: $FILE"
            rm -f "$FILE"
            exit 1
        fi
    fi
    sleep 1
done

