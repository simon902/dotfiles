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

# TODO: rewrite such that .backup stores correct path of files starting in $HOME
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
    find $(basename $1) -maxdepth 1 -type f,l -delete
    #rm -rv $(basename $1) && mkdir $(basename $1)
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
cp $HOME/.xinitrc ${CONFIG_ROOT}"/.backup/"
rm $HOME/.xinitrc
ln -s $CONFIG_ROOT/.xinitrc $HOME/.xinitrc

cp $HOME/.Xresources ${CONFIG_ROOT}"/.backup/"
rm $HOME/.Xresources
ln -s $CONFIG_ROOT/.Xresources $HOME/.Xresources
xrdb -load $HOME/.Xresources


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


#### Alacritty ####
mkdir -p $HOME/.config/alacritty/

link_path="/.config/alacritty/"
link_configs $link_path $link_path


#### ZSH ####
mkdir -p $HOME/.config/zsh/
mkdir -p $HOME/.cache/zsh/
touch $CONFIG_ROOT/.config/zsh/aliases # if file already existed touch doesn't override

cp $HOME/.zshenv ${CONFIG_ROOT}"/.backup/"
rm $HOME/.zshenv
ln -s $CONFIG_ROOT/.zshenv $HOME/.zshenv

link_path="/.config/zsh/"
link_configs $link_path $link_path

cd $CONFIG_ROOT"/.config/zsh/scripts/"
[ ! -d "fzf-tab" ] && git clone https://github.com/Aloxaf/fzf-tab
[ ! -d "z.lua" ] && git clone https://github.com/skywind3000/z.lua.git
[ ! -d "zsh-fzf-history-search" ] && git clone https://github.com/joshskidmore/zsh-fzf-history-search.git

cd $CONFIG_ROOT


#### Starship ####

cp $HOME/.config/starship.toml ${CONFIG_ROOT}"/.backup/"starship.toml
rm $HOME/.config/starship.toml
ln -s $CONFIG_ROOT/.config/starship.toml $HOME/.config/starship.toml


#### BSPWM ####
mkdir -p $HOME/.config/bspwm/


if [[ ! -f "$CONFIG_ROOT/.config/bspwm/screen.json" ]]; then
  echo "SCREEN TEMPLATE"
  SCREEN_CONF_DIR="$CONFIG_ROOT/.config/bspwm/screen.json"
  cp "$CONFIG_ROOT/.config/bspwm/template/screen.json" $SCREEN_CONF_DIR

  monitor_sequence=$(xrandr -q | awk '$2 ~ /(dis)?connected/ {print "\""$1}' ORS='", ')

  jq -r '.monitor_primary='"$(echo $monitor_sequence | cut -d',' -f 1)" $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
  jq -r '.monitor_sequence=['"${monitor_sequence::-2}"']' $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
  jq -r '.bspwm_sequence=['"${monitor_sequence::-2}"']' $SCREEN_CONF_DIR | sponge $SCREEN_CONF_DIR
fi

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


#### .local/scripts ####
mkdir -p $HOME/.local/scripts

link_path="/.local/scripts/"
link_configs $link_path $link_path

ln -s $(which alacritty) $HOME/.local/scripts/xterm


#### .local/share/applications ####
mkdir -p $HOME/.local/share/applications

link_path="/.local/share/applications/"
# TODO: Fix file noit saved and rewrite backup_dir function 
files=("nsxiv-rifle.desktop")
link_configs $link_path $link_path "${files[@]}"

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
mkdir -p $HOME/.local/share/mpd
mkdir -p $HOME/.local/share/mpd/playlists

link_path="/.config/mpd/"
link_configs $link_path $link_path


#### mpv ####
mkdir -p $HOME/.config/mpv

link_path="/.config/mpv/"
link_configs $link_path $link_path


#### redshift ####
mkdir -p $HOME/.config/redshift

link_path="/.config/redshift/"
link_configs $link_path $link_path


#### gdb ####
cp $HOME/.gdbinit ${CONFIG_ROOT}"/.backup/".gdbinit
rm $HOME/.gdbinit
ln -s $CONFIG_ROOT/.gdbinit $HOME/.gdbinit


#### git ####
cp $HOME/.gitconfig ${CONFIG_ROOT}"/.backup/"
rm $HOME/.gitconfig
ln -s $CONFIG_ROOT/.gitconfig $HOME/.gitconfig


#### ranger ####
mkdir -p $HOME/.config/ranger

link_path="/.config/ranger/"
link_configs $link_path $link_path
