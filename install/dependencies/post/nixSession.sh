#!/bin/sh
# Add "Hyprland (Nix)" to the login screen, which only lists sessions from /usr/share/wayland-sessions.

command -v pacman >/dev/null && exit 0
command -v nix >/dev/null || exit 0

SESSION_FILE=/usr/share/wayland-sessions/hyprland-nix.desktop

# Display managers don't expand variables in Exec, so write the absolute path
ENTRY="[Desktop Entry]
Name=Hyprland (Nix)
Comment=Hyprland installed with Nix
Exec=$HOME/.local/scripts/hyprland-session
Type=Application
DesktopNames=Hyprland"

if [ "$(cat "$SESSION_FILE" 2>/dev/null)" != "$ENTRY" ]; then
  echo "$ENTRY" | sudo tee "$SESSION_FILE" >/dev/null
fi
