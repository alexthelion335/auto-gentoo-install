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
mkdir -p /home/$user/.config/openbox
touch /home/$user/.config/openbox/autostart
printf "\npicom &\nnitrogen --restore &\ntint2 &" >> /home/$user/.config/openbox/autostart
echo -e "\nexec openbox" >> /home/$user/.xinitrc
rm /var/lib/AccountsService/users/$user
echo -e "[User]\nLanguage=\nSession=\nXSession=openbox\nIcon=/home/$user/.face\nSystemAccount=false\n" >> /var/lib/AccountsService/users/$user
echo -e "\nUser settings set!"
grub-install --target=i386-pc $drive
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\nGrub installed!"
systemctl enable dhcpcd
systemctl enable gdm
systemctl enable NetworkManager
echo -e "\nServices enabled!"
echo -e "\nArch Linux configuration complete!\nYou will have to reboot."
sleep 3
exit


