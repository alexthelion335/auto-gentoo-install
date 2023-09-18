# auto-gentoo-install
These are my scripts to automatically install Gentoo Linux. This is currently a work in progress.

# How to install
1. Git can't be installed easily on the Gentoo LiveCD, go we have to use wget
2. Type ```wget https://www.github.com/alexthelion335/auto-gentoo-install/raw/main/install-gentoo.sh && wget https://www.github.com/alexthelion335/auto-gentoo-install/raw/main/install-gentoo2.sh``` to download the scripts.
3. Edit the variables at the top of both scripts to change the drive you want to install on, user, and password.
4. Type ```sh ./install-gentoo.sh``` to start part one of the installation.
5. When the script pauses and tells you to type something, type ```sh ./install-gentoo2.sh``` to do the last part of the installation.
6. Type ```reboot``` to reboot.
# Defaults
The scripts will install Gentoo Linux on ```/dev/sda``` by default. The username is ```alex``` and the default password is ```password```.
