#!/bin/bash

link_configs() {
  cd ${CONFIG_ROOT}${1}

  for file in * .[^.]*; do
    if [ -f "$file" ]; then
      ln -s "$(pwd)"/"$file" ${HOME}${1}${file}
    fi
  done

  cd $CONFIG_ROOT
}



CONFIG_ROOT=$(pwd)


#### XDG Default Applications ###
 xdg-mime default sxiv.desktop image/jpeg
 xdg-mime default sxiv.desktop image/png
 xdg-mime default mpv.desktop video/mp4
 xdg-mime default org.pwmt.zathura.desktop application/pdf


#### Alacritty ####
mkdir -p $HOME/.config/alacritty/

alacritty_path="/.config/alacritty/"

link_configs $alacritty_path

#### ZSH ####
mkdir -p $HOME/.config/zsh/
mkdir -p $HOME/.cache/zsh/
touch $CONFIG_ROOT/.config/zsh/aliases

zsh_path="/.config/zsh/"

ln -s $CONFIG_ROOT/.zshenv $HOME/.zshenv

link_configs $zsh_path

#### Starship ####

ln -s $CONFIG_ROOT/.config/starship.toml $HOME/.config/starship.toml

#### BSPWM ####
mkdir -p $HOME/.config/bspwm/

bspw_path="/.config/bspwm/"

link_configs $bspw_path

#### SXHKD ####
mkdir -p $HOME/.config/sxhkd/

ln -s $CONFIG_ROOT/.config/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc

#### POLYBAR ####
mkdir -p $HOME/.config/polybar/

polybar_path="/.config/polybar/"
cd $CONFIG_ROOT$polybar_path"conf1"

for file in *; do
  if [ -f "$file" ]; then
    ln -s "$(pwd)"/"$file" $HOME$polybar_path$file
  fi
done


#### .local/bin ####
mkdir -p $HOME/.local/bin

local_bin_path="/.local/bin/"

link_configs $local_bin_path


#### VSCodium ####

mkdir -p $HOME/.config/VSCodium/User

vscodium_path="/.config/VSCodium/User/"

link_configs $vscodium_path


#### Rofi ####
mkdir -p $HOME/.config/rofi/{bin,themes}

rofi_bin_path="/.config/rofi/bin/"
rofi_themes="/.config/rofi/themes/"

link_configs $rofi_bin_path
link_configs $rofi_themes


#### .local/bin ####
mkdir -p $HOME/.config/mpv

mpv_path="/.config/mpv/"

link_configs $mpv_path

