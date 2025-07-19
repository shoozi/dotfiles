#!/bin/zsh

#This script is used for backing up home directory and a list of explicitly instlaled packages

#Home directory backup
sudo rsync -aAXv /home/shoozi/ /run/media/shoozi/Dreamin/andromeda\ backup/

#Pacman pkglist
pacman -Qqe > /run/media/shoozi/Dreamin/andromeda\ backup/pkglist.txt

#AUR pkglist
pacman -Qqm > /run/media/shoozi/Dreamin/andromeda\ backup/aur-pkglist.txt
