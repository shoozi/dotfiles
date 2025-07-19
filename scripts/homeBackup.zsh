#!/bin/zsh 

USER_HOME="/home/shoozi"
BACKUP_DIR="/run/media/shoozi/Dreamin/archBackup"

HOME_BACKUP_DIR="$BACKUP_DIR/home"
SYSTEM_ETC_DIR="$BACKUP_DIR/system/etc"
SYSTEM_BOOT_DIR="$BACKUP_DIR/system/boot"
SYSTEM_EFI_DIR="$BACKUP_DIR/system/efi"
DOTFILES_DIR="$BACKUP_DIR/dotfiles"
LOGFILE="$BACKUP_DIR/backup.log"

EXCLUDES=(
    ".cache"
    ".npm"
    ".local/share/Trash"
)

# check if backup drive is mounted
if [ ! -d "/run/media/shoozi/Dreamin/" ]; then
    echo "Backup directory not found: /run/media/shoozi/Dreamin/"
    echo "Is the external drive mounted?"
    echo "Aborting..."
    exit 1
fi 

#create log file if it doesn't exist
if [ ! -f "$LOGFILE" ]; then
    echo "Creating log file at $LOGFILE"
    touch "$LOGFILE"
fi

# log start 
echo "=== Backup started: $(date) ===" >> "$LOGFILE"

# home backup 
if [ ! -d "$HOME_BACKUP_DIR" ]; then
    echo "Creating home backup directory at $HOME_BACKUP_DIR"
    mkdir -p "$HOME_BACKUP_DIR"
fi

echo "Backing up home directory..."
for item in "${EXCLUDES[@]}"; do 
    EXCLUDE_ARGS+=(--exclude="$item")
done 

sudo rsync -aAXv --delete "${EXCLUDE_ARGS[@]}" "$USER_HOME/" "$HOME_BACKUP_DIR/" >> "$LOGFILE" 2>&1

# /etc backup
if [ ! -d "$SYSTEM_ETC_DIR" ]; then
    echo "Creating system /etc backup directory at $SYSTEM_ETC_DIR"
    mkdir -p "$SYSTEM_ETC_DIR"
fi

echo "Backing up /etc..."
sudo rsync -aAXv --delete /etc/ "$SYSTEM_ETC_DIR/" >> "$LOGFILE" 2>&1

#/boot backup
if [ ! -d "$SYSTEM_BOOT_DIR" ]; then
    echo "Creating system /boot backup directory at $SYSTEM_BOOT_DIR"
    mkdir -p "$SYSTEM_BOOT_DIR"
fi

echo "Backing up /boot..."
sudo rsync -aAXv --delete /boot/ "$SYSTEM_BOOT_DIR/" >> "$LOGFILE" 2>&1

# /boot/efi backup
if [ ! -d "$SYSTEM_EFI_DIR" ]; then
    echo "Creating system /boot/efi backup directory at $SYSTEM_EFI_DIR"
    mkdir -p "$SYSTEM_EFI_DIR"
fi

echo "Backing up /boot/efi..."
sudo rsync -aAXv --delete /boot/efi/ "$SYSTEM_EFI_DIR/" >> "$LOGFILE" 2>&1

# package lists
echo "Saving package lists..."
pacman -Qqe > "$BACKUP_DIR/pkglist.txt"
pacman -Qqm > "$BACKUP_DIR/aurPkglist.txt"

# log end 
echo "=== Backup completed: $(date) ===" >> "$LOGFILE"
echo "Wrote data to backup.log"
echo "Backup completed"
