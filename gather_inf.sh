#!/bin/bash

# Define the output file path (adjust the path to the actual user's desktop if needed)
OUTPUT_FILE="$HOME/Desktop/system_info.txt"

echo "Gathering system information for Ubuntu 22.04 and saving it to $OUTPUT_FILE..."

# Redirect all output to a file on the Desktop
{
    # System Identity and Operating System
    echo "Hostname and OS:"
    hostnamectl

    # CPU details
    echo "CPU Information:"
    lscpu

    # Memory details
    echo "Memory Information:"
    free -m

    # Disk usage
    echo "Disk Usage:"
    df -h

    # Mounted file systems
    echo "Mounted File Systems:"
    lsblk

    # Network interfaces and IP addresses
    echo "Network Interfaces:"
    ip a

    # System uptime
    echo "System Uptime:"
    uptime

    # List running services
    echo "Running Services:"
    systemctl list-units --type=service --state=running

    # Firewall status
    echo "Firewall Status:"
    sudo ufw status verbose

    # System Users
    echo "System Users:"
    cut -d: -f1 /etc/passwd

    echo "System information gathering complete."
} > "$OUTPUT_FILE"

echo "Information saved to $OUTPUT_FILE"
