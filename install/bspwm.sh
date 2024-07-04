#!/bin/sh
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si PKGBUILD
cd ..
rm -rf yay/


sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))

yay -S xclicker vimix-icon-theme ccat vscodium-bin nerd-fonts-jetbrains-mono nerd-fonts-roboto-mono ttf-material-design-icons nordic-darker-theme bibata-cursor-theme paper-icon-theme lscolors-git 
