#!/bin/bash

# Define ANSI escape codes for bold, colors, and no color
RED='\033[1;31m'
BOLD='\033[1;32m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Print green header
echo -e "${GREEN}#########################################################################${NC}"
echo -e "${BOLD}                 
echo -e "${BOLD}                 AdoPisoft fail2ban install script${NC}"

# Bash ASCII logo with green text and no background color
echo -e "${GREEN}
        __                ___.                          __    
       |  | __ ____ _____ \\_ |__   _____ _____    _____|  | __
       |  |/ // ___\\__  \\ | __ \\ /     \\__  \\  /  ___/  |/ /
       |    <\\  \\___ / __ \\| \\_\\ \\  Y Y  \\/ __ \\_\\___ \\|    < 
       |__|_ \\___  >____  /___  /__|_|  (____  /____  >__|_ \\
           \\/    \\/     \\/    \\/      \\/     \\/     \\/     \\/
${NC}"

# Print green header
echo -e "${GREEN}#########################################################################${NC}"

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
echo -e "${BOLD}Installing fail2ban...${NC}"
sudo apt-get update  >/dev/null 2>&1
sudo apt-get install -y fail2ban  >/dev/null 2>&1
check_status

# Create or update the filter configuration
echo -e "${BOLD}Creating/updating Fail2ban filter configuration...${NC}"
sudo bash -c "cat > $FILTER_FILE <<EOF
[Definition]
failregex = \[\[ Failed%%20login%%20attempt%%3A%%20username%%3D\w+%%2C%%20ip%%3D<HOST> \]\]
ignoreregex =
EOF"
check_status

# Create or update the jail configuration
echo -e "${BOLD}Creating/updating Fail2ban jail configuration...${NC}"
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
echo -e "${BOLD}Enabling Fail2ban to start on boot...${NC}"
sudo systemctl enable fail2ban  >/dev/null 2>&1
check_status

# Restart Fail2ban
echo -e "${BOLD}Restarting Fail2ban...${NC}"
sudo systemctl restart fail2ban  >/dev/null 2>&1
check_status
sleep 5

# Check Fail2ban status
echo -e "${BOLD}Checking Fail2ban status...${NC}"
sudo fail2ban-client status adopisoft
sudo fail2ban-client status sshd
check_status

echo -e "${BOLD}Fail2ban setup completed successfully.${NC}"
