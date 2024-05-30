#!/bin/bash

export CONFIG_ROOT=$(pwd)


#### XDG Default Applications ####
xdg-mime default nsxiv-rifle.desktop image/jpeg
xdg-mime default nsxiv-rifle.desktop image/jpg
xdg-mime default nsxiv-rifle.desktop image/png
xdg-mime default nsxiv-rifle.desktop image/gif

xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska

xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default org.pwmt.zathura.desktop image/vnd.djvu
xdg-mime default foliate.desktop application/epub+zip

xdg-mime default nvim.desktop text/plain
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https




# before python script
# after folder creation
# or change bspw/install.sh such that screen.conf is not in repo and only in ~/.config/bspwm
# ./.config/bspwm/install.sh
# ./.config/zsh/install.sh

# TODO:  
# call dependenceis in linkconfigs.py


python3 linkconfigs.py

# in python install script
xrdb -load $HOME/.Xresources