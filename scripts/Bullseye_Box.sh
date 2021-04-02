#!/bin/bash

sudo apt update && sudo apt -y upgrade

default_user=$(logname 2>/dev/null || echo ${SUDO_USER:-${USER}})
HOME="/home/${default_user}"

mkdir ~/.scripts
sudo chmod -R 755 ~/.scripts

sudo chown -R $(logname):$(logname) /home/$(logname)/
find ~/Bullseye_Box -type d -exec chmod 755 {} \;
find ~/Bullseye_Box -type f -exec chmod 755 {} \;

sudo apt-get update

sudo apt install -y xorg lightdm openbox obconf tint2 lxappearance menu bleachbit mpd ncmpcpp geany synaptic doublecmd-common terminator rxvt-unicode ranger micro firmware-linux firmware-linux-nonfree firmware-misc-nonfree ttf-mscorefonts-installer mousepad apt-rdepends compton compton-conf firefox-esr xsel mirage pulseaudio numlockx pavucontrol mlocate vlc arandr apt-file xutils mesa-utils xarchiver htop sysstat acpi hardinfo hddtemp network-manager network-manager-gnome net-tools nmap dnsutils libglu1-mesa xfburn gnome-disk-utility python3-pip  fonts-ubuntu fonts-ubuntu-console suckless-tools simplescreenrecorder gdebi fbxkb mpv curl gmrun xscreensaver galternatives pnmixer sxiv scrot xsettingsd git wmctrl pm-utils arc-theme numix-icon-theme nitrogen policykit-1-gnome udiskie psmisc flameshot

sudo apt install -y pcmanfm-qt --no-install-recommends
sudo apt install -y qbittorrent --no-install-recommends

cp -Rp ~/Bullseye_Box/.config ~/

cp -p ~/Bullseye_Box/.Xresources ~/

cp -p ~/Bullseye_Box/keyboard.sh ~/

sudo cp -p ~/Bullseye_Box/rs.png /usr/share/fbxkb/images/rs.png

sudo cp ~/Bullseye_Box/ncmpcpp_48x48.png /usr/share/icons

#sudo chmod 777 /usr/share/icons/ncmpcpp_48x48.png


# korekcija autorizacije za gdebi
# sudo sed -i 's/<allow_active>auth_admin/<allow_active>yes/' /usr/share/polkit-1/actions/com.ubuntu.pkexec.gdebi-gtk.policy


# korekcija autorizacije za synaptic
# sudo sed -i 's/<allow_active>auth_admin/<allow_active>yes/' /usr/share/polkit-1/actions/com.ubuntu.pkexec.synaptic.policy

# korekcija autorizacije za doublecmd
# sudo sed -i 's/<allow_active>auth_admin_keep/<allow_active>yes/' /usr/share/polkit-1/actions/org.doublecmd.root.policy

## debinfo -- prikaz resursa pri otvaranju terminala
sudo cp ~/Bullseye_Box/scripts/debinfo /usr/bin
sudo chmod 777 /usr/bin/debinfo
echo debinfo >> ~/.bashrc

## instalacija comptona
cp ~/Bullseye_Box/scripts/install_compton.sh ~/.scripts
mkdir ~/bin
cp ~/Bullseye_Box/start-compton.sh ~/bin
sudo chmod -R 755 ~/bin

## instalacija ncmpcpp
cp -Rp ~/Bullseye_Box/.ncmpcpp ~/
cp -Rp ~/Bullseye_Box/.mpd ~/
echo "Exec=x-terminal-emulator -T 'ncmpcpp' -e ncmpcpp" > /tmp/ncmpcpp_replacement
sudo sed -i "s/^.*Exec=ncmpcpp.*$/$(cat /tmp/ncmpcpp_replacement)/" /usr/share/applications/ncmpcpp.desktop
sudo sed -i 's!Terminal=true!Terminal=false!' /usr/share/applications/ncmpcpp.desktop
echo "Icon=/usr/share/icons/ncmpcpp_48x48.png" >> /usr/share/applications/ncmpcpp.desktop

## screeny
cp -p ~/Bullseye_Box/scripts/screeny ~/.scripts

## script for reinstall youtube-dl
cp -p ~/Bullseye_Box/scripts/reinstall_youtube-dl.sh ~/.scripts

## obmenu-generator
cp -p ~/Bullseye_Box/scripts/obmenu-generator.sh ~/.scripts

cd /home/$(logname)/Bullseye_Box/scripts && sudo ./wps-office.sh
cd /home/$(logname)/Reports
sudo dpkg -i wps-office.deb
sudo apt-get -f install && rm wps-office.deb
cd /home/$(logname)/Bullseye_Box/scripts/
sudo ./install_missing_wps_fonts.sh

# dt-dark-theme
cp -pR /home/$(logname)/Bullseye_Box/.themes /home/$(logname)/

# Copy wallpapers folderes
sudo cp -r ~/Bullseye_Box/WALLPAPERS/Wallpapers_Debian /usr/share/backgrounds
sudo cp -r ~/Bullseye_Box/WALLPAPERS/wallpapers-pixabay /usr/share/backgrounds

sudo cp ~/Bullseye_Box/WALLPAPERS/Wallpapers_Debian/lightdm_login.jpg /usr/share/images/desktop-base
sudo chmod 777 /usr/share/images/desktop-base/lightdm_login.jpg
sudo sed -i 's!#background=!background=/usr/share/images/desktop-base/lightdm_login.jpg!' /etc/lightdm/lightdm-gtk-greeter.conf

## setting default text editor
xdg-mime default pcmanfm-qt.desktop inode/directory


## settings htop.desktop & ranger.desktop files
echo "Exec=x-terminal-emulator -T 'htop task manager' -e htop" > /tmp/htop_replacement

sudo sed -i "s/^.*Exec=htop.*$/$(cat /tmp/htop_replacement)/" /usr/share/applications/htop.desktop

sudo sed -i 's!Terminal=true!Terminal=false!' /usr/share/applications/htop.desktop

echo "Exec=x-terminal-emulator -T 'ranger task manager' -e ranger" > /tmp/ranger_replacement

sudo sed -i "s/^.*Exec=ranger.*$/$(cat /tmp/ranger_replacement)/" /usr/share/applications/ranger.desktop

sudo sed -i 's!Terminal=true!Terminal=false!' /usr/share/applications/ranger.desktop

mkdir -p ~/.urxvt/ext
cp -p ~/Bullseye_Box/ext/* ~/.urxvt/ext/
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/urxvtc 50
sudo update-alternatives --set x-terminal-emulator /usr/bin/terminator

cd ~/Bullseye_Box/scripts/openbox_conky
sudo ./install.sh

cd ~/Bullseye_Box/scripts/install_vim/
sudo ./install.sh

