#!/bin/bash

echo "Enter the username to install dwm for (or press enter to install for root):"
read USERNAME

if [ -z "$USERNAME" ]; then
  USERNAME="root"
fi

pacman -S base-devel git xorg-server xorg-xinit xorg-xrandr libx11 libxinerama libxft webkit2gtk --noconfirm

if [ "$USERNAME" == "root" ]; then
  HOME_DIR="/root"
else
  HOME_DIR="/home/$USERNAME"
fi

mkdir -p $HOME_DIR/suckless
cd $HOME_DIR/suckless
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/slstatus

cd $HOME_DIR/suckless/st
make clean install
cd $HOME_DIR/suckless/dwm
make clean install
cd $HOME_DIR/suckless/dmenu
make clean install
cd $HOME_DIR/suckless/slstatus
make clean install

echo "slstatus &" >> $HOME_DIR/.xinitrc
echo "exec dwm" >> $HOME_DIR/.xinitrc
echo "startx" >> $HOME_DIR/.bash_profile

if [ "$USERNAME" != "root" ]; then
  chown -R $USERNAME:$USERNAME $HOME_DIR/suckless
  chown $USERNAME:$USERNAME $HOME_DIR/.xinitrc
  chown $USERNAME:$USERNAME $HOME_DIR/.bash_profile
fi

reboot now
