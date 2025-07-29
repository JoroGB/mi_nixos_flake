#! /bin/bash
set -euo pipefail
lsblk;
echo "Por favor escriba el nombre de un disco";
read -r disco;

echo "Borrando tabla de particiones existentes"
#Parted disk

#Create table
parted /dev/"$disco" -- mklabel gpt

# ESP EFI
parted /dev/"$disco"  -- mkpart ESP fat32 1MB 512MB
parted /dev/"$disco"  -- set 1 esp on
# root partition
parted /dev/"$disco" -- mkpart root ext4 512MB 100%

echo "Particion exitosa"



echo "Formateando"
mkfs.fat -F 32 -n boot /dev/"$disco"1
mkfs.ext4 -L nixos /dev/"$disco"2
echo
echo "Formateo exitoso"
echo
echo
echo "Montando particiones"
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
echo "particiones montadas"
echo
echo "Escriba el nombre de la configuracion flake"
read -r configuration;

nixos-install --flake .#$configuration

echo "instalacion finalizada posiblemente exitosa"
