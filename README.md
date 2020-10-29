# auto-arch-install
These are my scripts to automatically install Arch Linux.
# How to install
1. Install git to the Arch live CD by typing ```sudo pacman -S git```
2. Type ```git clone https://wwe.github.com/alexthelion335/auto-arch-install.git``` to download the scripts.
3. Edit the variables at the top of both scripts to change the drive you want to install on, user, and password.
3. Type ```sh ./install-arch.sh``` to start part one of the installation.
4. When the script pauses and tells you to type something, type ```sh ./install-arch2.sh``` to do the last part of the installation.
5. Type ```reboot``` to reboot.
# Defaults
The scripts will install Arch Linux on ```/dev/sda``` by default. The username is ```alex``` and the default password is ```password```.
