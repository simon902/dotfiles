#!/bin/bash

CONFIG_ROOT=$1
SHELL_DIR="$CONFIG_ROOT/.config/quickshell/caelestia"

git -C "$CONFIG_ROOT" submodule update --init .config/quickshell/caelestia
git -C "$SHELL_DIR" remote add upstream https://github.com/caelestia-dots/shell.git 2>/dev/null

cd "$SHELL_DIR"

# Without pacman (e.g. Ubuntu) quickshell comes from Nix and the plugin must be
# built against Nix's Qt, so the fork's flake is installed (or rebuilt) instead.
# Nix copies the QML into its store, so QML changes also need a rebuild.
if ! command -v pacman >/dev/null; then
  if ! command -v nix >/dev/null; then
    echo "caelestia: neither pacman nor nix found, skipping"
    exit 0
  fi
  if nix profile list --json | grep -q "git+file://$SHELL_DIR\""; then
    nix profile upgrade caelestia
  else
    nix profile install "$SHELL_DIR"
  fi
  exit 0
fi

# Arch: the QML in this repo needs the C++ plugin built from the same commit,
# so rebuild and reinstall it after every update of the fork.
# Only the plugin is installed, the QML is used straight from this repo.
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/ -DENABLE_MODULES="extras;plugin"
cmake --build build && sudo cmake --install build
