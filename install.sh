#! /bin/bash
systemctl start wpa_supplicant;
wpa_cli;
lsblk;
echo "Por favor escriba el nombre de un disco";
read -r disco;

#Parted disk
parted /dev/"$disco" --mklabel gpt
parted /dev/"$disco" --mkpart root ext4 512MB 

parted /dev/"$disco"  -- mkpart ESP fat32 1MB 512MB
parted /dev/"$disco"  -- set 3 esp on
echo "Particion exitosa"
echo "Formateando"

mkfs.ext4 -L nixos /dev/"$disco"1
mkfs.fat -F 32 -n boot /dev/"$disco"2
echo "Formateo exitoso"

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

echo "Escriba el nombre de la configuracion"
read -r configuration;

nixos-install --flake ./flake.nix#$configuration




