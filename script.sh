#!/bin/bash

echo "Enter the username to install dwm for (or press enter to install for root):"
read USERNAME

if [ -z "$USERNAME" ]; then
  USERNAME="root"
fi

pacman -S base-devel git xorg-server xorg-xinit xorg-xrandr libx11 libxinerama libxft webkit2gtk

mkdir -p /home/$USERNAME/suckless
cd /home/$USERNAME/suckless
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/slstatus

cd /home/$USERNAME/suckless/st
make clean install
cd /home/$USERNAME/suckless/dwm
make clean install
cd /home/$USERNAME/suckless/dmenu
make clean install
cd /home/$USERNAME/suckless/slstatus
make clean install

echo "slstatus &" >> /home/$USERNAME/.xinitrc
echo "exec dwm" >> /home/$USERNAME/.xinitrc

echo "startx" >> /home/$USERNAME/.bash_profile

reboot now
