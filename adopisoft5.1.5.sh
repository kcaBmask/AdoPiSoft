#!/bin/bash

# Define ANSI escape code for bold, green color, and no color
BOLD='\033[1;32m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Print green header
echo -e "${GREEN}#########################################################################${NC}\\n"
echo -e "${BOLD}                  AdoPisoft automatic install script${NC}"

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
echo -e "${GREEN}#########################################################################${NC}\\n"

# Update and upgrade system
echo -e "${BOLD}Updating and upgrading system...${NC}"
sudo apt-get update >/dev/null 2>&1 && sudo apt-get upgrade -y >/dev/null 2>&1

# Install required packages
echo -e "${BOLD}Installing curl...${NC}"
sudo apt-get install curl -y >/dev/null 2>&1

# Install Node.js version 16.4.0
echo -e "${BOLD}Installing Node.js version 16.4.0...${NC}"
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - >/dev/null 2>&1
sudo apt-get install -y nodejs >/dev/null 2>&1

echo -e "${BOLD}Installing other packages...${NC}"
sudo apt-get install -y python2 nginx bind9 isc-dhcp-server >/dev/null 2>&1
sudo ln -s $(which python2) /usr/bin/python >/dev/null 2>&1

sudo apt-get install -y iptables hostapd dmidecode build-essential openssh-server python-pip unzip bridge-utils git iputils-arping >/dev/null 2>&1

# Download and install AdoPiSoft
echo -e "${BOLD}Downloading and installing AdoPiSoft...${NC}"
wget -O /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb https://github.com/AdoPiSoft/Releases/releases/download/v5.1.5/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1
sudo apt-get install /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1

# Ask if user wants to install PostgreSQL
read -p "Do you want to install PostgreSQL? (y/n):" install_psql
if [ "$install_psql" == "y" ]; then
    # Download ado-psql-script.sh
    echo -e "${BOLD}Downloading ado-psql-script.sh...${NC}"
    wget -O ado-psql-script.sh https://gist.githubusercontent.com/alenteria/791dbe32175a01d1f1b602b25489ad22/raw/9a5aa879ac70d24bd9a7dd7f8ed97d7fe2c2f597/ado-psql-script.sh >/dev/null 2>&1

    # Set execute permissions
    echo -e "${BOLD}Setting execute permissions for ado-psql-script.sh...${NC}"
    sudo chmod a+x ./ado-psql-script.sh

    # Execute ado-psql-script.sh
    echo -e "${BOLD}Executing ado-psql-script.sh...${NC}"
    sudo ./ado-psql-script.sh >/dev/null 2>&1

    echo -e "${BOLD}PostgreSQL installation completed.${NC}"
else
    echo -e "${BOLD}PostgreSQL installation skipped.${NC}"
fi

# Enable and start AdoPiSoft service
echo -e "${BOLD}Enabling AdoPiSoft service...${NC}"
sudo systemctl enable adopisoft
echo -e "${BOLD}Restarting AdoPisoft...${NC}"

sudo systemctl start adopisoft

echo -e "${BOLD}Script execution completed.${NC}"
