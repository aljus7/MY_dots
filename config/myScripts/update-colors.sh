#!/bin/bash

WAL_GTK="$HOME/.cache/wallust/gtk.css"
WAL_GTK_ALPHA="$HOME/.cache/wallust/gtk_rgba.css"
WAL_RASI="$HOME/.cache/wallust/rasi.rasi"
WAL_HYPR="$HOME/.cache/wallust/hyprlandColors.conf"

STYLE_FILE_WAYBAR="$HOME/.config/waybar/waybar.css"
STYLE_FILE_NVGDRAWER="$HOME/.config/nwg-drawer/drawer_ginny.css"
STYLE_FILE_SWAYNC="$HOME/.config/swaync/styleGinny.css"
STYLE_FILE_ROFI="$HOME/.config/rofi/configGinny.rasi"

OUTPUT_FILE_WAYBAR="$HOME/.config/waybar/style.css"
OUTPUT_FILE_NVGDRAWER="$HOME/.config/nwg-drawer/drawer.css"
OUTPUT_FILE_SWAYNC="$HOME/.config/swaync/style.css"
OUTPUT_FILE_ROFI="$HOME/.config/rofi/config.rasi"
OUTPUT_FILE_HYPR="$HOME/.cache/walHyprColors.conf"

DEFAULT_COLORS_GTK="$HOME/.config/colors-default-gtk.css"
DEFAULT_COLORS_ROFI="$HOME/.config/rofi/defaultColor.rasi"
DEFAULT_COLORS_HYPR="$HOME/.config/hyprDefaultColors.conf"

# Set waybar colors
if [ -f "$WAL_GTK" ]; then
    cat "$WAL_GTK" "$STYLE_FILE_WAYBAR" >> "$OUTPUT_FILE_WAYBAR"
else
    cat "$DEFAULT_COLORS_GTK" "$STYLE_FILE_WAYBAR" >> "$OUTPUT_FILE_WAYBAR"
fi
systemctl --user restart waybar

# Set nwg-drawer colors
if [ -f "$WAL_GTK" ]; then
    cat "$WAL_GTK" "$WAL_GTK_ALPHA" "$STYLE_FILE_NVGDRAWER" >> "$OUTPUT_FILE_NVGDRAWER"
else
    cat "$DEFAULT_COLORS_GTK" "$STYLE_FILE_NVGDRAWER" >> "$OUTPUT_FILE_NVGDRAWER"
fi

# Set swaync drawer colors
if [ -f "$WAL_GTK" ]; then
    cat "$WAL_GTK" "$WAL_GTK_ALPHA" "$STYLE_FILE_SWAYNC" >> "$OUTPUT_FILE_SWAYNC"
else
    cat "$DEFAULT_COLORS_GTK" "$STYLE_FILE_SWAYNC" >> "$OUTPUT_FILE_SWAYNC"
fi
swaync-client -rs

# Set rofi colors
if [ -f "$WAL_RASI" ]; then
    cat "$WAL_RASI" "$STYLE_FILE_ROFI" >> "$OUTPUT_FILE_ROFI"
else
    cat "$DEFAULT_COLORS_ROFI" "$STYLE_FILE_ROFI" >> "$OUTPUT_FILE_ROFI"
fi

# set hyprland file colors
if [ -f "$WAL_HYPR" ]; then
     cat "$WAL_HYPR" >> "$OUTPUT_FILE_HYPR"
else
     cat "$DEFAULT_COLORS_HYPR" >> "$OUTPUT_FILE_HYPR"
fi
