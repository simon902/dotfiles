#!/bin/sh

curr_path=$(pwd)

ln -s $curr_path/.zshenv $HOME/.zshenv

#### ZSH ####
mkdir -p $HOME/.config/zsh/
mkdir -p $HOME/.cache/zsh/

ln -s $curr_path/.config/zsh/.zcompdump $HOME/.config/zsh/.zcompdump
ln -s $curr_path/.config/zsh/.zprofile $HOME/.config/zsh/.zprofile
ln -s $curr_path/.config/zsh/.zshrc $HOME/.config/zsh/.zshrc
ln -s $curr_path/.config/starship.toml $HOME/.config/starship.toml

#### BSPWM ####
mkdir -p $HOME/.config/bspwm/

ln -s $curr_path/.config/bspwm/autostart.sh $HOME/.config/bspwm/autostart.sh
ln -s $curr_path/.config/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -s $curr_path/.config/bspwm/picom.conf $HOME/.config/bspwm/picom.conf

#### SXHKD ####
mkdir -p $HOME/.config/sxhkd/

ln -s $curr_path/.config/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

#### POLYBAR ####
mkdir -p $HOME/.config/polybar/

polybar_path="/.config/polybar/"
cd $curr_path$polybar_path"conf1"

for file in *; do
  if [ -f "$file" ]; then
    ln -s "$(pwd)"/"$file" $HOME$polybar_path$file
  fi
done
