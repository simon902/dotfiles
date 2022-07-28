#!/bin/bash

link_configs() {

  backup_dir $2 $3

  cd ${CONFIG_ROOT}${1}

  for file in * .[^.]*; do
    if [ -f "$file" ]; then
      ln -s "$(pwd)"/"$file" ${HOME}${2}${file}
    fi
  done

  cd $CONFIG_ROOT
}

backup_dir() {
  cd $HOME${1}
  
  if [[ $2 != "" ]]; then
    files=$2
    for file in "${files[@]}"; do
      if [[ $(find . -maxdepth 1 -name "$file") ]]; then
        mkdir -p ${CONFIG_ROOT}"/.backup/"$(basename $1)
        cp $file ${CONFIG_ROOT}"/.backup/"$(basename $1)
        rm $file
      fi
    done
  else
    cd ..
    cp -rL $(basename $1) ${CONFIG_ROOT}"/.backup/"$(basename $1)
    rm -r $(basename $1) && mkdir $(basename $1)
  fi
}



if [[ -d .backup ]]; then
  read -p "Backup from earlier install exists. Do you want do delete it y/N: " delete

  if [[ $delete = 'y' || $delete = 'Y' ]]; then
    rm -rf .backup
   else
    exit -1
  fi
fi


CONFIG_ROOT=$(pwd)
mkdir .backup

#### xinit ####
cp $HOME/.xinitrc ${CONFIG_ROOT}"/.backup/" && rm $HOME/.xinitrc
ln -s $CONFIG_ROOT/.xinitrc $HOME/.xinitrc


#### XDG Default Applications ####
xdg-mime default sxiv.desktop image/jpeg
xdg-mime default sxiv.desktop image/png
xdg-mime default mpv.desktop video/mp4
xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default vscodium.desktop text/plain


#### Alacritty ####
mkdir -p $HOME/.config/alacritty/

link_path="/.config/alacritty/"
link_configs $link_path $link_path


#### ZSH ####
mkdir -p $HOME/.config/zsh/
mkdir -p $HOME/.cache/zsh/
touch $CONFIG_ROOT/.config/zsh/aliases

cp $HOME/.zshenv ${CONFIG_ROOT}"/.backup/" && rm $HOME/.zshenv
ln -s $CONFIG_ROOT/.zshenv $HOME/.zshenv

link_path="/.config/zsh/"
link_configs $link_path $link_path


#### Starship ####

cp $HOME/.config/starship.toml ${CONFIG_ROOT}"/.backup/"starship.toml && rm $HOME/.config/starship.toml
ln -s $CONFIG_ROOT/.config/starship.toml $HOME/.config/starship.toml


#### BSPWM ####
mkdir -p $HOME/.config/bspwm/

link_path="/.config/bspwm/"
link_configs $link_path $link_path


#### SXHKD ####
mkdir -p $HOME/.config/sxhkd/

link_path="/.config/sxhkd/"

link_configs $link_path $link_path


#### POLYBAR ####
mkdir -p $HOME/.config/polybar/

link_path="/.config/polybar/"
link_configs $link_path"conf1" $link_path


#### .local/bin ####
mkdir -p $HOME/.local/bin

link_path="/.local/bin/"
link_configs $link_path $link_path


#### VSCodium ####

mkdir -p $HOME/.config/VSCodium/User

link_path="/.config/VSCodium/User/"
files=("keybindings.json" "settings.json")
link_configs $link_path $link_path "${files[@]}"


#### Rofi ####
mkdir -p $HOME/.config/rofi/{bin,themes}

link_path="/.config/rofi/bin/"
link_configs $link_path $link_path
link_path="/.config/rofi/themes/"
link_configs $link_path $link_path


#### mpd/ncmpcpp ####
mkdir -p $HOME/.config/{mpd,ncmpcpp}

link_path="/.config/mpd/"
link_configs $link_path $link_path


#### .local/bin ####
mkdir -p $HOME/.config/mpv

link_path="/.config/mpv/"
link_configs $link_path $link_path

