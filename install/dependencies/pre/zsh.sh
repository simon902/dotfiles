#!/bin/bash

CONFIG_ROOT=$1

touch "$CONFIG_ROOT/.config/zsh/aliases" # if file already existed touch doesn't override

# Plugins are git submodules in .config/zsh/plugins
git -C "$CONFIG_ROOT" submodule update --init .config/zsh/plugins
