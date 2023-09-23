#!/bin/bash
drive=/dev/sda
hostname=new-gentoo-box
user=alex
passwd=password
echo -e "\nContinuing installation..."
echo -e "\nInstalling ebuild repository"
emerge-webrsync
echo -e "\nUpdating @world set"
emerge --verbose --update --deep --newuse @world
echo -e "\nAdding Eastern Timezone"
echo "America/New_York" > /etc/timezone
echo -e "\nAdding en_US locale"
rm /etc/locale.gen
echo -e "en_US ISO-8859-1\nen_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
eselect locale set 5
echo -e "Updating environment after locale change"
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
echo -e "Installing Linux kernel and firmware"
emerge sys-kernel/linux-firmware
emerge sys-kernel/installkernel-gentoo
emerge sys-kernel/gentoo-kernel
emerge --depclean
echo -e "Kernel install complete!"
echo -e "Writing /etc/fstab"
echo -e "/dev/sda1  /  ext4  defaults  0 1\n/dev/sda2  none  swap  sw  0 0" >> /etc/fstab
echo $hostname >> /etc/hostname
echo -e "Emerging dhcpcd and networkmanager"
emerge net-misc/dhcpcd net-misc/networkmanager
echo -e "Starting dhcpcd and networkmanager services"
rc-update add dhcpcd default
rc-service dhcpcd start
rc-update add networkmanager default
rc-service networkmanager start
rm /etc/hosts
echo -e "127.0.0.1    localhost\n::1        localhost\n127.0.1.1    ${hostname}.localdomain ${hostname}" >> /etc/hosts
echo -e "\nHostname set!"
passwd << EOF
$passwd
$passwd
EOF
mkdir -p /etc/portage/package.use
echo "acct-user/git -git -gitea -gitolite" >> /etc/portage/package.use/git
echo -e ">=dev-libs/libdbusmenu-16.04.0-r2 gtk3\n>=gnome-base/gnome-control-center-44.3 networkmanager\n>=media-libs/libcanberra-0.30-r7 pulseaudio\n>=media-plugins/alsa-plugins-1.2.7.1-r1 pulseaudio\n# required by www-client/firefox-102.15.1::gentoo[system-libvpx]\n# required by firefox (argument)\n>=media-libs/libvpx-1.13.0 postproc" >> /etc/portage/package.use/misc
echo -e "Emerging tools and programs"
emerge app-admin/sysklogd sys-process/cronie net-misc/chrony sys-block/io-scheduler-udev-rules nano vim sudo acct-user/git wget grub app-misc/screen elogind xorg-server xf86-video-vesa neofetch openbox tint2 nitrogen gdm firefox konsole xterm mpv thunar kde-apps/dolphin picom inkscape gimp cmatrix lynx cowsay
echo -e "Adding sysklogd, cronie, sshd, chronyd, and elogind services to startup"
rc-update add sysklogd default
rc-update add cronie default
rc-update add sshd default
rc-update add chronyd default
rc-update add elogind boot
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
echo -e "\nUser settings set!"
grub-install --target=i386-pc $drive
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\nGrub installed!"
echo -e "\nGentoo Linux configuration complete!\nYou will have to reboot."
sleep 3
exit


