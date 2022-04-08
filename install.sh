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


#### ZSH ####
mkdir -p $HOME/.config/zsh/
mkdir -p $HOME/.cache/zsh/

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
mkdir -p .local/bin

local_bin_path="/.local/bin/"

link_configs $local_bin_path


#### VSCodium ####

mkdir -p .config/VSCodium/User

vscodium_path="/.config/VSCodium/User/"

link_configs $vscodium_path
