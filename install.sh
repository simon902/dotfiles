#!/bin/sh

curr_path=$(pwd)

ln -s $curr_path/.zshenv $HOME/.zshenv

mkdir -p $HOME/.config/zsh

ln -s $curr_path/.config/zsh/.zcompdump $HOME/.config/zsh/.zcompdump
ln -s $curr_path/.config/zsh/.zprofile $HOME/.config/zsh/.zprofile
ln -s $curr_path/.config/zsh/.zshrc $HOME/.config/zsh/.zshrc
ln -s $curr_path/.config/starship.toml $HOME/.config/starship.toml

