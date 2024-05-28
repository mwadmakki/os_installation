#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Ubuntu Desktop
sudo apt install ubuntu-desktop -y

# Install necessary tools
sudo apt install wget gdebi-core -y

# Install OpenSSH client, server, and SFTP server
sudo apt install openssh-client openssh-server openssh-sftp-server -y

# Install AnyDesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install anydesk -y

# Install RustDesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.1.8/rustdesk-1.1.8.deb
sudo gdebi rustdesk-1.1.8.deb -n

# Prevent the system from going to sleep or suspending
#sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# Configure Netplan to use NetworkManager
    #echo -e "network:\n  version: 2\n  renderer: NetworkManager" | sudo tee /etc/netplan/00-installer-config.yaml

echo "Installation complete. Rebooting the system now..."
sudo reboot
