#!/bin/sh
# Nix's PAM (caelestia lock screen) runs its password helper from /run/wrappers/bin/unix_chkpwd,
# which only exists on NixOS, so every password is rejected. Link it to the distro's helper on every boot.

command -v pacman >/dev/null && exit 0
command -v nix >/dev/null || exit 0
[ -x /usr/sbin/unix_chkpwd ] || exit 0

RULE_FILE=/etc/tmpfiles.d/nix-unix-chkpwd.conf
RULE="L+ /run/wrappers/bin/unix_chkpwd - - - - /usr/sbin/unix_chkpwd"

if [ "$(cat "$RULE_FILE" 2>/dev/null)" != "$RULE" ]; then
  echo "$RULE" | sudo tee "$RULE_FILE" >/dev/null
fi
sudo systemd-tmpfiles --create "$RULE_FILE"
