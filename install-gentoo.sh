#!/bin/bash
drive=/dev/sda
hostname=new-gentoo-box
user=alex
passwd=password
echo "--------------------------"
echo "-  Welcome to            -"
echo "-  Alex Kinch's          -"
echo "-  Gentoo Install        -"
echo "-  script!               -"
echo "--------------------------"
sleep 1
echo -e "\nYou will need to know what drive to install Gentoo Linux on."
echo "If it is not /dev/sda, you will need to change the script."
sleep 1
fdisk ${drive} << EOF
  o
  n
  p
  1
    
  -2G
  n
  p
  2
   
   
  a
  1
  t
  2
  82
  p
  w
  q
EOF
echo -e "\nDrive $drive was formatted!"
mkfs.ext4 ${drive}1
mkswap ${drive}2
swapon ${drive}2
mkdir /mnt/gentoo
mount ${drive}1 /mnt/gentoo
echo -e "\nSwap activated and drive mounted!"
chronyd -q
echo -e "\nTime and date set!"
echo -e "\nDownloading latest stage 3 tarball..."
sleep 1
cd /mnt/gentoo
wget https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-desktop-openrc.txt
stage3=`cat latest-stage3-amd64-desktop-openrc.txt | grep -wo 'stage3-amd64-desktop-openrc-.*.tar.xz'`
wget https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-desktop-openrc/$stage3
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo -e "\nStage 3 downloaded and extracted!"
cp install-gentoo2.sh /mnt/gentoo
echo -e "\nYou will have to type ./install-gentoo2.sh to continue. Also, set CFLAGS and MAKEOPTS in /etc/portage/make.conf"
arch-chroot /mnt/gentoo

