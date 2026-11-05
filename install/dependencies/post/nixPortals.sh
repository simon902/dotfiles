#!/bin/sh
# Let the distro's xdg-desktop-portal use Nix's Hyprland portal (screenshots, screen sharing).
# hyprland-session points XDG_DESKTOP_PORTAL_DIR at the dir set up here. Only on Nix hosts, not Arch.

command -v pacman >/dev/null && exit 0
command -v nix >/dev/null || exit 0

NIX_SHARE="$HOME/.nix-profile/share"
[ -e "$NIX_SHARE/xdg-desktop-portal/portals/hyprland.portal" ] || exit 0

PORTAL_DIR="$HOME/.local/share/xdg-desktop-portal/portals"
mkdir -p "$PORTAL_DIR" "$HOME/.local/share/dbus-1/services" "$HOME/.local/share/systemd/user"

# Distro backends and configs plus Hyprland's; the portal reads its config from this dir too
for portal in /usr/share/xdg-desktop-portal/portals/*.portal /usr/share/xdg-desktop-portal/*-portals.conf; do
  [ -e "$portal" ] && ln -sfn "$portal" "$PORTAL_DIR/"
done
ln -sfn "$NIX_SHARE/xdg-desktop-portal/portals/hyprland.portal" "$PORTAL_DIR/"
ln -sfn "$HOME/.config/xdg-desktop-portal/hyprland-portals.conf" "$PORTAL_DIR/"

# So D-Bus/systemd can start the Hyprland portal
ln -sfn "$NIX_SHARE/dbus-1/services/org.freedesktop.impl.portal.desktop.hyprland.service" \
  "$HOME/.local/share/dbus-1/services/"
ln -sfn "$NIX_SHARE/systemd/user/xdg-desktop-portal-hyprland.service" \
  "$HOME/.local/share/systemd/user/"

systemctl --user daemon-reload
