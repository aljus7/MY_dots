#!/bin/bash
wallust run "$HOME/wallpaper/wallpaper.png" && "$HOME/.config/myScripts/update-colors.sh"
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm update
hyprpm enable hyprbars
hyprpm enable hyprscrolling
hyprpm reload
sed -i '/^exec-once = .*init-hyprpm.*/d' "$HOME/.config/hypr/hyprland.conf"
