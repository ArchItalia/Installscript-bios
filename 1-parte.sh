#!/bin/bash
# Part 1/2
# Author Jonathan Sanfilippo - 18 Jul 2023
# Another installation method programmed through a custom script 
# prepared for File System BIOS-mbr
# architalialinux@gmail.com



# settings script 1

country="us" # Mirror region
age="6" # Age server mirrors
editor="vim" # choose a editor 
kernel="linux" # kernel
FM="linux-firmware" # firmware
tools="intel-ucode btrfs-progs" # tools
base="base base-devel" # base packages

# --- nomenclatura --- nomenclature

#nvme - M2
#p1="/dev/nvme0n1p1"
#p2="/dev/nvme0n1p2"


#vda - Virtual Machine
#p1="/dev/vda1"
#p2="/dev/vda2"


#sda - SSD
#p1="/dev/sda1"
#p2="/dev/sda2"



# end settings -----------------------------------------------


#Formattazione delle partizioni - EFI, ROOT, HOME

mkswap $p1 
mkfs.ext4 $p2

#Montaggio e sottovolumi - partizione /home separata
mount $p2 /mnt           
swapon $p1  


# reflector
reflector --verbose -c $country -a $age --sort rate --save /etc/pacman.d/mirrorlist

#pacstrap
pacstrap -K /mnt $base $FM $kernel $tools $editor

#fstab
genfstab -Up /mnt > /mnt/etc/fstab


cp 2-parte.sh /mnt/home/
arch-chroot /mnt 
  



