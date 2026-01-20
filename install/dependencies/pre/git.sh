#!/bin/bash

CONFIG_ROOT=$1
TEMPLATE_PATH=$2


if [[ ! -f "$CONFIG_ROOT/.gitconfig-local" ]]; then
  cp "$TEMPLATE_PATH/.gitconfig-local" $CONFIG_ROOT/.gitconfig-local
fi

if [[ ! -f "$CONFIG_ROOT/.gitconfig-work" ]]; then
  cp "$TEMPLATE_PATH/.gitconfig-work" $CONFIG_ROOT/.gitconfig-work
fi