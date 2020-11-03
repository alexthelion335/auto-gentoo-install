#!/bin/bash
drive=/dev/sda
hostname=new-arch-box
user=alex
passwd=password
echo -e "\nContinuing installation..."
ln -sf /usr/share/zoneinfo/America/New_York
hwclock --systohc
echo $hostname >> /etc/hostname
rm /etc/hosts
echo -e "127.0.0.1    localhost\n::1        localhost\n127.0.1.1    ${hostname}.localdomain ${hostname}" >> /etc/hosts
echo -e "\nHostname set!"
passwd << EOF
$passwd
$passwd
EOF
useradd -m $user
passwd $user << EOF
$passwd
$passwd
EOF
usermod -aG wheel,audio,video,optical,storage $user
printf "\n%%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "exec i3" >> /home/$user/.xinitrc
echo -e "\nUser settings set!"
grub-install $drive
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\nGrub installed!"
echo -e "\nArch Linux configuration complete!\nRebooting..."
sleep 3
reboot


