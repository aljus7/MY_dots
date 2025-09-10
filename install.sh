#!/bin/bash

echo "Are you runing that sctipt from base arch install? [N/y]"
read baseCheck
if [ "$baseCheck" == "y" ] || [ "$baseCheck" == "Y" ]
then
    echo "Welcome to MY_dots install script!\nWizard will guide you through install. "
else
    echo "Arch base install is needed. Use ARCHINSTALL to do that or do it MANUALLY."
    exit 0
fi

#Location of a script
cd "$(dirname "$0")"

echo ""
echo "###############################"
echo "### Installing hyprland ... ###"
echo "###############################"

echo "\nroot password needed (if not root)"
sudo pacman -Syu --noconfirm
sudo pacman -S hyprcursor hyprgraphics hypridle hyprland hyprland-qt-support hyprland-qtutils hyprlang hyprlock hyprpaper hyprpicker hyprutils hyprwayland-scanner xdg-desktop-portal-hyprland kitty --noconfirm

echo ""
echo "#######################################"
echo "### Installing sddm,chaotic,yay ... ###"
echo "#######################################"

#Sddm and tee and others install
sudo pacman -S sddm tee polkit-kde-agent polkit uwsm grim slurp swappy tesseract wl-clip-persist wl-clipboard gammastep swaync rofi rofi-emoji waybar xorg-xwayland networkmanager sed awk pipewire pipewire-pulse pavucontrol brightnessctl cups hplip firefox --noconfirm

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
sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

#Update arch
sudo pacman -Syu --noconfirm

echo ""
echo "###################################"
echo "### Setting up moded NWG Drawer ###"
echo "###################################"

sudo cp ./usr_bin/nwg-drawer /usr/bin/
sudo cp -r ./usr_share/nwg-drawer /usr/share

echo ""
echo "###################################"
echo "### Installing from chaotic AUR ###"
echo "###################################"

sudo pacman -S waypaper-git trivalent-bin --noconfirm

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

sudo pacman -S qbittorrent nautilus nwg-look zsh curl --noconfirm

# oh my zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#wget https://raw.githubusercontent.com/moarram/headline/main/headline.zsh-theme 

cp -r ./zsh_theme/headline.zsh-theme ~/.oh-my-zsh/custom/themes

cp ./.zshrc ~

echo ""
echo "#################################"
echo "### Getting .config ready ... ###"
echo "#################################"

cp -r ./config/* $HOME/.config

echo ""
echo "###############################"
echo "### Turning on services ... ###"
echo "###############################"

sudo systemctl enable --user cliphist.service
sudo systemctl enable --user hyprpm.service
sudo systemctl enable --user kde-polkit.service
sudo systemctl enable --user waypaper-restore.service
sudo systemctl enable --user wl-clip-persist.service

sudo systemctl enable --user hyprpaper
sudo systemctl enable --user waybar
sudo systemctl enable --user swaync

echo "Input string to set up monitors in hyprland.conf (leave empty for automagic):"
read moniSetUp
sed -i "s/##_monitor_configuration_##/$moniSetUp/" "$HOME/.config/hypr/hyprland.conf"

sudo usermod -aG video,render,scanner "$USER"

echo "!!! USE UWSM HYPRLAND OPTION AT LOGIN (top left corner in sddm)"