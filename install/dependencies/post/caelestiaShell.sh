#!/bin/bash

CONFIG_ROOT=$1
SHELL_DIR="$CONFIG_ROOT/.config/quickshell/caelestia"

git -C "$CONFIG_ROOT" submodule update --init .config/quickshell/caelestia
git -C "$SHELL_DIR" remote add upstream https://github.com/caelestia-dots/shell.git 2>/dev/null

# The QML in this repo needs the C++ plugin built from the same commit,
# so rebuild and reinstall it after every update of the fork.
# Only the plugin is installed, the QML is used straight from this repo.
cd "$SHELL_DIR"
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/ -DENABLE_MODULES="extras;plugin"
cmake --build build && sudo cmake --install build
