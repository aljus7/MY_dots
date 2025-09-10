#!/bin/bash

WAL_CACHE="$HOME/.cache/wal/colors-waybar.css"
DEFAULT_COLORS="$HOME/.config/waybar/colors-default.css"
STYLE_FILE="$HOME/.config/waybar/waybar.css"
OUTPUT_FILE="$HOME/.config/waybar/style.css"

# Check if colors-waybar.css exists, then apply the correct color source
if [ -f "$WAL_CACHE" ]; then
    cat "$WAL_CACHE" "$STYLE_FILE" >> "$OUTPUT_FILE"
else
    cat "$DEFAULT_COLORS" "$STYLE_FILE" >> "$OUTPUT_FILE"
fi

