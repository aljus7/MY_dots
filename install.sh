#!/bin/bash

#Location of a script
cd "$(dirname "$0")"
pwd

echo "Are you runing that sctipt from base arch install? [N/y]"
read baseCheck
if [ "$baseCheck" == "y" ] || [ "$baseCheck" == "Y" ]
then
    echo "Welcome to MY_dots install script!\nWizard will guide you through install. "
else
    echo "Arch base install is needed. Use ARCHINSTALL to do that or do it MANUALLY."
    exit 0
fi

echo ""
echo "###############################"
echo "### Installing hyprland ... ###"
echo "###############################"

echo "\nroot password needed (if not root)"
sudo pacman -Syu --noconfirm
sudo pacman -S util-linux hyprcursor hypridle hyprland hyprlang hyprlock hyprpaper hyprpicker hyprutils hyprwayland-scanner xdg-desktop-portal-hyprland kitty sddm polkit-kde-agent polkit uwsm grim slurp swappy tesseract cliphist wl-clipboard gammastep swaync rofi rofi-emoji waybar xorg-xwayland networkmanager sed awk pipewire pipewire-pulse wireplumber pavucontrol brightnessctl cups hplip firefox jq git base-devel cmake meson cpio --noconfirm && echo "Packages successfully installed!" || sleep 180

echo ""
echo "#######################################"
echo "### Installing sddm,chaotic,yay ... ###"
echo "#######################################"

#Chaotic install
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

echo '
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf

#Update arch
sudo pacman -Syu --noconfirm

#Install YAY
sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si --noconfirm

if [[ "$(pwd)" == *yay-bin* ]]; then
    cd .. || { echo "Error: Failed to change to parent directory"; exit 1; }
    echo "Changed to parent directory: $(pwd)"
else
    echo "Current directory ($(pwd)) does not contain 'yay-bin', staying here"
fi

cd "$(dirname "$0")"
pwd

#Update arch
sudo pacman -Syu --noconfirm

echo ""
echo "###################################"
echo "### Setting up moded NWG Drawer ###"
echo "###################################"

cd "$(dirname "$0")"
pwd
sudo cp ./usr_bin/nwg-drawer /usr/bin/
sudo cp -r ./usr_share/nwg-drawer /usr/share

echo ""
echo "###################################"
echo "### Installing from chaotic AUR ###"
echo "###################################"

sudo pacman -S chaotic-aur/waypaper-git --noconfirm

echo ""
echo "###########################"
echo "### Installing from AUR ###"
echo "###########################"

yay -S trivalent-bin --noconfirm

echo ""
echo "#######################################"
echo "### Installing Flatpak with Flathub ###"
echo "#######################################"

sudo pacman -S flatpak --noconfirm

echo ""
echo "#########################################"
echo "### Installing Flatpak MY picked apps ###"
echo "#########################################"

flatpak install flathub com.bitwarden.desktop net.cozic.joplin_desktop org.strawberrymusicplayer.strawberry it.mijorus.gearlever com.usebottles.bottles -y

echo ""
echo "#################################################"
echo "### Installing other software from arch repos ###"
echo "#################################################"

sudo pacman -S qbittorrent nautilus nwg-look zsh curl gnome-text-editor otf-font-awesome ttf-liberation ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common --noconfirm

#wget https://raw.githubusercontent.com/moarram/headline/main/headline.zsh-theme 

cd "$(dirname "$0")"
pwd

cp -r ./zsh_theme/headline.zsh-theme "$HOME/.oh-my-zsh/custom/themes"

cp ./.zshrc "$HOME"

echo ""
echo "#################################"
echo "### Getting .config ready ... ###"
echo "#################################"

cp -r ./config/* "$HOME/.config"

cp ./wallpaper.png "$HOME/wallpaper"

wallust run "$HOME/wallpaper" && "$HOME/.config/myScripts/update-colors.sh"

echo ""
echo "###############################"
echo "### Turning on services ... ###"
echo "###############################"

sudo systemctl daemon-reload
sudo systemctl enable sddm NetworkManager cups
sudo systemctl daemon-reload
systemctl daemon-reload --user
systemctl enable --user cliphist.service
systemctl enable --user hyprpm.service
systemctl enable --user kde-polkit.service
systemctl enable --user waypaper-restore.service
systemctl enable --user wl-clip-persist.service


systemctl enable --user hyprpaper
systemctl enable --user waybar
systemctl enable --user swaync

echo "Input string to set up monitors in hyprland.conf (leave empty for automagic):"
read moniSetUp
sed -i "s/##_monitor_configuration_##/$moniSetUp/" "$HOME/.config/hypr/hyprland.conf"

sudo usermod -aG video,render,scanner "$USER"

# oh my zsh install
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

echo "!!! USE UWSM HYPRLAND OPTION AT LOGIN (top left corner in sddm)"

echo "SYSTEM WILL REBOOT IN 5 SEC"
sleep 5 && sudo reboot