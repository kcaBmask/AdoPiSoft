#!/bin/bash

# Variables
FILTER_FILE="/etc/fail2ban/filter.d/adopisoft.conf"
JAIL_FILE="/etc/fail2ban/jail.local"
LOG_FILE="/opt/adopisoft/adopisoft.log"
BAN_TIME=600

# Function to check if a command was successful
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error occurred. Exiting."
        exit 1
    fi
}

# Install Fail2ban
echo "Installing Fail2ban..."
sudo apt-get update
sudo apt-get install -y fail2ban
check_status

# Create or update the filter configuration
echo "Creating/updating Fail2ban filter configuration..."
sudo bash -c "cat > $FILTER_FILE <<EOF
[Definition]
failregex = \[\[ Failed%%20login%%20attempt%%3A%%20username%%3D\w+%%2C%%20ip%%3D<HOST> \]\]
ignoreregex =
EOF"
check_status

# Create or update the jail configuration
echo "Creating/updating Fail2ban jail configuration..."
sudo bash -c "cat > $JAIL_FILE <<EOF
[adopisoft]
enabled = true
filter = adopisoft
logpath = $LOG_FILE
maxretry = 3
bantime = $BAN_TIME

[sshd]
enabled = true
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = $BAN_TIME
EOF"
check_status

# Enable Fail2ban to start on boot
echo "Enabling Fail2ban to start on boot..."
sudo systemctl enable fail2ban
check_status

# Restart Fail2ban
echo "Restarting Fail2ban..."
sudo systemctl restart fail2ban
check_status
sleep 5

# Check Fail2ban status
echo "Checking Fail2ban status..."
sudo fail2ban-client status adopisoft
sudo fail2ban-client status sshd
check_status

echo "Fail2ban setup completed successfully."
