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


# Get connected display name (e.g., eDP-1, HDMI-1)
DISPLAY_NAME=$(xrandr | grep " connected" | cut -f1 -d " ")

# Define the mode name and parameters
MODE_NAME="1920x1080_60.00"
MODELINE=$(cvt 1920 1080 | grep Modeline | cut -d " " -f 2-)

# Check if mode already exists
xrandr | grep -q "$MODE_NAME"
if [ $? -ne 0 ]; then
    xrandr --newmode $MODELINE
    xrandr --addmode "$DISPLAY_NAME" "$MODE_NAME"
fi

# Apply the mode
xrandr --output "$DISPLAY_NAME" --mode "$MODE_NAME"

# Add to ~/.xprofile for persistence (if not already there)
XPROFILE="$HOME/.xprofile"
grep -q "$MODE_NAME" "$XPROFILE" 2>/dev/null || {
    echo "Saving to $XPROFILE for persistence..."
    {
        echo "xrandr --newmode $MODELINE"
        echo "xrandr --addmode $DISPLAY_NAME $MODE_NAME"
        echo "xrandr --output $DISPLAY_NAME --mode $MODE_NAME"
    } >> "$XPROFILE"
}

echo "Installation complete. Rebooting the system now..."
sudo reboot
