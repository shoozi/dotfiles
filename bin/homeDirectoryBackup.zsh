#!/bin/bash

# === User Variables ===
SRC="/home/shoozi/"
DEST="/backup/arch"
EXCLUDES=(
  ".cache/"
  ".pki/"
  ".zcompdump"
  ".cargo/registry/"
  ".yarn/cache/"
  ".local/share/Trash/"
)

if ! mountpoint -q /backup; then
    echo "Backup destination not found."
    echo "Aborting backup process."
    exit 1
fi

find /backup/arch/ -mindepth 1 -maxdpeth 1 -type d mtime +30 -exec rm -rf {} +

# === Create destination if it doesn't exist ===
mkdir -p "$DEST"

# === Build rsync exclude arguments ===
EXCLUDE_ARGS=()
for item in "${EXCLUDES[@]}"; do
  EXCLUDE_ARGS+=(--exclude="$item")
done

# === Run rsync ===
rsync -aAXv --delete "${EXCLUDE_ARGS[@]}" "$SRC" "$DEST"

# === Notify completion ===
echo "Backup completed at $(date)"

