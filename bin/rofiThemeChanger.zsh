#!/bin/zsh

THEME_DIR="$HOME/.config/themes/"
THEMES=($THEME_DIR/*(:t))

SELECTED=$(printf "%s\n" $THEMES | rofi -dmenu -p "Select Theme")

if [[ -n "$SELECTED" ]]; then 
  ~/bin/themeChanger.zsh "$SELECTED"
fi 
