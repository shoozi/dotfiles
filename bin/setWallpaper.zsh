
#!/bin/zsh

if [[ -z "$1" ]]; then
    echo "Usage: setWal path/to/image"
    exit 1
fi 

if [[ ! -f "$1" ]]; then
    echo "Error: there is no image at file path '$1'."
    exit 1
fi 

WALLPAPER="$1"
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"
MINARCH_PATH="$HOME/.config/fastfetch/ascii/minarch.txt"

swww img "$WALLPAPER"
wal -i "$WALLPAPER"

# Set Fastfetch logo type to 'file' and source to minarch ascii file
sed -i 's|"type": "builtin"|"type": "file"|' "$FASTFETCH_CONFIG"
sed -i "s|\"source\": \".*\"|\"source\": \"$MINARCH_PATH\"|" "$FASTFETCH_CONFIG"

killall swaync
swaync &

sleep 1

clear
fastfetch

