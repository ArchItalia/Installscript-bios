#!/bin/bash
# Part 2/2
# Author Jonathan Sanfilippo - 18 Jul 2023
# Another installation method programmed through a custom script 
# prepared for File System Bios 
# architalialinux@gmail.com


# settings script 2

localhost="localhost" # nome machina - hostname
user="username"    # nome utente [solo minuscolo] -- username [only lowercase]
realname="realname" # nome reale [minuscolo/maiuscolo] - real name [uppercase/lowercase]
rootpw="password" # password per root -- root password
userpw="password" # password per utente -- user password
localegen="en_US.UTF-8 UTF-8" # locale encoding
localeconf="LANG=en_US.UTF-8"  # lingua locale -- local language
km="us" # lingua della tastiera -- keyboard layout
localtime="Europe/Italy" # localtime
groups="wheel" # aggiungi gruppi all'utente - add groups for user
Ntools="wpa_supplicant wireless_tools netctl net-tools iw networkmanager" # set network tools
Audio="alsa-utils pipewire-pulse" # Audio packages
Utils="mtools dosfstools exfatprogs fuse" # tools 
PKGS="firewalld acpi cronie git reflector bluez bluez-utils" #general packages
DE="xorg gnome-shell nautilus gnome-console gvfs gnome-control-center xdg-user-dirs-gtk  gnome-text-editor gnome-keyring gnome-system-monitor" #GNOME [Minimal installation]
DM="gdm" # Display Manager
Service="gdm NetworkManager firewalld bluetooth cronie reflector" # Service



# end setting ----------------------------------------------





ln -sf /usr/share/zoneinfo/$localtime /etc/localtime 
hwclock --systohc
echo "$localegen" > /etc/locale.gen
locale-gen
echo "$localeconf" >> /etc/locale.conf
echo "KEYMAP=$km" >> /etc/vconsole.conf  
echo "$localhost" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1       localhost" >> /etc/hosts
echo root:$rootpw | chpasswd
useradd -m $user
echo $user:$userpw | chpasswd
usermod -aG $groups $user
usermod -c "$realname" $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user



#Grub Bios version

pacman -S grub --noconfirm
grub-install --target=i386-pc /dev/your-nomenclature 
grub-mkconfig -o /boot/grub/grub.cfg




pacman -S $Ntools $Utils $Audio $PKGS $DE $DM --noconfirm

systemctl enable $Service

rm -r /home/2-parte.sh #clear








