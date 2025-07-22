#!/bin/zsh

THEME_NAME="$1"
THEME_DIR="$HOME/.config/themes/$THEME_NAME"
WALLPAPER=($THEME_DIR/wallpaper.*)
LOGO=($THEME_DIR/logo.*)
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"

# Check if theme exists
if [[ ! -d "$THEME_DIR" ]]; then
  echo "Theme '$THEME_NAME' does not exist."
  exit 1
fi

# Set wallpaper
if [[ -n $WALLPAPER && -f "$WALLPAPER" ]]; then
  swww img "$WALLPAPER" --transition-type any --transition-duration 1 --transition-fps 60
  wal -i "$WALLPAPER"
else
  echo "Wallpaper not found in $WALLPAPER"
fi

# Update Fastfetch config to point to new logo
if [[ -f "$LOGO" && -f "$FASTFETCH_CONFIG" ]]; then
  sed -i "s|\"source\": \".*\"|\"source\": \"$LOGO\"|" "$FASTFETCH_CONFIG"
  sleep 0.3
  swaync-client -rs
  clear
  fastfetch
else
  echo "Logo or Fastfetch config not found."
fi

