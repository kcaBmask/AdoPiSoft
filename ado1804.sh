#!/bin/bash

# Define ANSI escape codes for colors and bold text
RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to print messages in bold green
print_bold() {
    echo -e "${BOLD_GREEN}$1${NC}"
}

# Function to print error messages in red
print_error() {
    echo -e "${RED}$1${NC}"
}

# Capture start time
start_time=$(date +%s)

# Print script header
echo -e "${GREEN}#########################################################################${NC}\n"
print_bold                          "AdoPiSoft Automatic Install Script"
echo -e "${GREEN}
        __                ___.                          __    
       |  | __ ____ _____ \\_ |__   _____ _____    _____|  | __
       |  |/ // ___\\__  \\ | __ \\ /     \\__  \\  /  ___/  |/ /
       |    <\\  \\___ / __ \\| \\_\\ \\  Y Y  \\/ __ \\_\\___ \\|    < 
       |__|_ \\___  >____  /___  /__|_|  (____  /____  >__|_ \\
           \\/    \\/     \\/    \\/      \\/     \\/     \\/     \\/
${NC}"
echo -e "${GREEN}#########################################################################${NC}\n"

# Check Ubuntu version
os_version=$(lsb_release -r | awk '{print $2}')

if [ "$os_version" == "18.04" ]; then
    echo -e "${GREEN}Running Ubuntu 18.04 specific installation script...${NC}\n"

    # Update and upgrade system
    print_bold "Updating and upgrading system..."
    if sudo apt update >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1; then
        print_bold "System updated and upgraded successfully."
    else
        print_error "Failed to update and upgrade the system."
        exit 1
    fi

    # Install required packages
    print_bold "Installing curl..."
    if sudo apt install curl -y >/dev/null 2>&1; then
        print_bold "Curl installed successfully."
    else
        print_error "Failed to install curl."
        exit 1
    fi

    # Install Node.js version 16.4.0
    print_bold "Installing Node.js version 16.4.0..."
    if curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - >/dev/null 2>&1 && sudo apt install -y nodejs >/dev/null 2>&1; then
        print_bold "Node.js installed successfully."
    else
        print_error "Failed to install Node.js."
        exit 1
    fi

    print_bold "Installing Python ..."
    if sudo apt install -y python >/dev/null 2>&1; then
        print_bold "Python installed successfully."
    else
        print_error "Failed to install Python."
        exit 1
    fi

    print_bold "Installing Nginx..."
    if sudo apt install -y nginx >/dev/null 2>&1; then
        print_bold "Nginx installed successfully."
    else
        print_error "Failed to install Nginx."
        exit 1
    fi

    print_bold "Installing Bind9..."
    if sudo apt install -y bind9 >/dev/null 2>&1; then
        print_bold "Bind9 installed successfully."
    else
        print_error "Failed to install Bind9."
        exit 1
    fi

    print_bold "Installing ISC DHCP Server..."
    if sudo apt install -y isc-dhcp-server >/dev/null 2>&1; then
        print_bold "ISC DHCP Server installed successfully."
    else
        print_error "Failed to install ISC DHCP Server."
        exit 1
    fi

    print_bold "Installing iptables..."
    if sudo apt install -y iptables >/dev/null 2>&1; then
        print_bold "iptables installed successfully."
    else
        print_error "Failed to install iptables."
        exit 1
    fi

    print_bold "Installing hostapd..."
    if sudo apt install -y hostapd >/dev/null 2>&1; then
        print_bold "hostapd installed successfully."
    else
        print_error "Failed to install hostapd."
        exit 1
    fi

    print_bold "Installing dmidecode..."
    if sudo apt install -y dmidecode >/dev/null 2>&1; then
        print_bold "dmidecode installed successfully."
    else
        print_error "Failed to install dmidecode."
        exit 1
    fi

    print_bold "Installing build-essential..."
    if sudo apt install -y build-essential >/dev/null 2>&1; then
        print_bold "build-essential installed successfully."
    else
        print_error "Failed to install build-essential."
        exit 1
    fi

    print_bold "Installing OpenSSH Server..."
    if sudo apt install -y openssh-server >/dev/null 2>&1; then
        print_bold "OpenSSH Server installed successfully."
    else
        print_error "Failed to install OpenSSH Server."
        exit 1
    fi

    print_bold "Installing Python pip..."
    if sudo apt install -y python-pip >/dev/null 2>&1; then
        print_bold "Python pip installed successfully."
    else
        print_error "Failed to install Python pip."
        exit 1
    fi

    print_bold "Installing unzip..."
    if sudo apt install -y unzip >/dev/null 2>&1; then
        print_bold "unzip installed successfully."
    else
        print_error "Failed to install unzip."
        exit 1
    fi

    print_bold "Installing bridge-utils..."
    if sudo apt install -y bridge-utils >/dev/null 2>&1; then
        print_bold "bridge-utils installed successfully."
    else
        print_error "Failed to install bridge-utils."
        exit 1
    fi

    print_bold "Installing git..."
    if sudo apt install -y git >/dev/null 2>&1; then
        print_bold "git installed successfully."
    else
        print_error "Failed to install git."
        exit 1
    fi

    print_bold "Installing arping..."
    if sudo apt install -y iputils-arping >/dev/null 2>&1; then
        print_bold "arping installed successfully."
    else
        print_error "Failed to install arping."
        exit 1
    fi

    # Download and install AdoPiSoft
print_bold "Downloading and installing AdoPiSoft..."
if sudo wget -O /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb https://github.com/AdoPiSoft/Releases/releases/download/v5.1.5/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1 && sudo apt install -y /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1; then
    print_bold "AdoPiSoft installed successfully."
else
    print_error "Failed to install AdoPiSoft."
    exit 1
fi


    # Install PostgreSQL
    print_bold "Installing PostgreSQL..."
    if wget -O ado-psql-script.sh https://raw.githubusercontent.com/kcaBmask/PostgreSQL/main/ado18.04-psql.sh >/dev/null 2>&1; then
        print_bold "Setting execute permissions for ado-psql-script.sh..."
        sudo chmod a+x ./ado-psql-script.sh

        print_bold "Executing ado-psql-script.sh..."
        if sudo ./ado-psql-script.sh >/dev/null 2>&1; then
            print_bold "PostgreSQL installation completed."
        else
            print_error "Failed to execute ado-psql-script.sh."
            exit 1
        fi
    else
        print_error "Failed to download ado-psql-script.sh."
        exit 1
    fi

    # Enable and start AdoPiSoft service
    print_bold "Enabling AdoPiSoft service..."
    if sudo systemctl enable adopisoft && sudo systemctl start adopisoft; then
        print_bold "AdoPiSoft service enabled and started successfully."
    else
        print_error "Failed to enable or start AdoPiSoft service."
        exit 1
    fi

elif [ "$os_version" == "22.04" ]; then
    echo -e "${GREEN}Running Ubuntu 22.04 specific installation script...${NC}\n"

    # Update and upgrade system
    print_bold "Updating and upgrading system..."
    if sudo apt update >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1; then
        print_bold "System updated and upgraded successfully."
    else
        print_error "Failed to update and upgrade the system."
        exit 1
    fi

    # Install required packages
    print_bold "Installing curl..."
    if sudo apt install curl -y >/dev/null 2>&1; then
        print_bold "Curl installed successfully."
    else
        print_error "Failed to install curl."
        exit 1
    fi

    # Install Node.js version 16.4.0
    print_bold "Installing Node.js version 16.4.0..."
    if curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - >/dev/null 2>&1 && sudo apt install -y nodejs >/dev/null 2>&1; then
        print_bold "Node.js installed successfully."
    else
        print_error "Failed to install Node.js."
        exit 1
    fi

    print_bold "Installing Python 2..."
    if sudo apt install -y python2 >/dev/null 2>&1; then
        sudo ln -s $(which python2) /usr/bin/python >/dev/null 2>&1
        print_bold "Python 2 installed successfully."
    else
        print_error "Failed to install Python 2."
        exit 1
    fi

    print_bold "Installing Nginx..."
    if sudo apt install -y nginx >/dev/null 2>&1; then
        print_bold "Nginx installed successfully."
    else
        print_error "Failed to install Nginx."
        exit 1
    fi

    print_bold "Installing Bind9..."
    if sudo apt install -y bind9 >/dev/null 2>&1; then
        print_bold "Bind9 installed successfully."
    else
        print_error "Failed to install Bind9."
        exit 1
    fi

    print_bold "Installing ISC DHCP Server..."
    if sudo apt install -y isc-dhcp-server >/dev/null 2>&1; then
        print_bold "ISC DHCP Server installed successfully."
    else
        print_error "Failed to install ISC DHCP Server."
        exit 1
    fi

    print_bold "Installing iptables..."
    if sudo apt install -y iptables >/dev/null 2>&1; then
        print_bold "iptables installed successfully."
    else
        print_error "Failed to install iptables."
        exit 1
    fi

    print_bold "Installing hostapd..."
    if sudo apt install -y hostapd >/dev/null 2>&1; then
        print_bold "hostapd installed successfully."
    else
        print_error "Failed to install hostapd."
        exit 1
    fi

    print_bold "Installing dmidecode..."
    if sudo apt install -y dmidecode >/dev/null 2>&1; then
        print_bold "dmidecode installed successfully."
    else
        print_error "Failed to install dmidecode."
        exit 1
    fi

    print_bold "Installing build-essential..."
    if sudo apt install -y build-essential >/dev/null 2>&1; then
        print_bold "build-essential installed successfully."
    else
        print_error "Failed to install build-essential."
        exit 1
    fi

    print_bold "Installing OpenSSH Server..."
    if sudo apt install -y openssh-server >/dev/null 2>&1; then
        print_bold "OpenSSH Server installed successfully."
    else
        print_error "Failed to install OpenSSH Server."
        exit 1
    fi

    print_bold "Installing Python pip..."
    if sudo apt install -y python-pip >/dev/null 2>&1; then
        print_bold "Python pip installed successfully."
    else
        print_error "Failed to install Python pip."
        exit 1
    fi

    print_bold "Installing unzip..."
    if sudo apt install -y unzip >/dev/null 2>&1; then
        print_bold "unzip installed successfully."
    else
        print_error "Failed to install unzip."
        exit 1
    fi

    print_bold "Installing bridge-utils..."
    if sudo apt install -y bridge-utils >/dev/null 2>&1; then
        print_bold "bridge-utils installed successfully."
    else
        print_error "Failed to install bridge-utils."
        exit 1
    fi

    print_bold "Installing git..."
    if sudo apt install -y git >/dev/null 2>&1; then
        print_bold "git installed successfully."
    else
        print_error "Failed to install git."
        exit 1
    fi

    print_bold "Installing arping..."
    if sudo apt install -y iputils-arping >/dev/null 2>&1; then
        print_bold "arping installed successfully."
    else
        print_error "Failed to install arping."
        exit 1
    fi

    # Download and install AdoPiSoft
    print_bold "Downloading and installing AdoPiSoft..."
    if wget -O /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb https://github.com/AdoPiSoft/Releases/releases/download/v5.1.5/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1 sudo apt install -y /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb >/dev/null 2>&1; then
        print_bold "AdoPiSoft installed successfully."
    else
        print_error "Failed to install AdoPiSoft."
        exit 1
    fi

    # Install PostgreSQL
    print_bold "Installing PostgreSQL..."
    if wget -O ado-psql-script.sh https://gist.githubusercontent.com/kcaBmask/77292e0f47d3e2b66ad06021b42226cf/raw/b7817048e21483a82c50bf89a3affabb8d2e6c4b/ado-psql-script.sh >/dev/null 2>&1; then
        print_bold "Setting execute permissions for ado-psql-script.sh..."
        sudo chmod a+x ./ado-psql-script.sh

        print_bold "Executing ado-psql-script.sh..."
        if sudo ./ado-psql-script.sh >/dev/null 2>&1; then
            print_bold "PostgreSQL installation completed."
        else
            print_error "Failed to execute ado-psql-script.sh."
            exit 1
        fi
    else
        print_error "Failed to download ado-psql-script.sh."
        exit 1
    fi

    # Enable and start AdoPiSoft service
    print_bold "Enabling AdoPiSoft service..."
    if sudo systemctl enable adopisoft && sudo systemctl start adopisoft; then
        print_bold "AdoPiSoft service enabled and started successfully."
    else
        print_error "Failed to enable or start AdoPiSoft service."
        exit 1
    fi

else
    print_error "Unsupported Ubuntu version $os_version. This script supports Ubuntu 18.04 and 22.04 only."
    exit 1
fi

# Capture end time
end_time=$(date +%s)

# Calculate and print the total execution time in minutes and seconds
execution_time=$((end_time - start_time))
minutes=$((execution_time / 60))
seconds=$((execution_time % 60))
print_bold "Script execution completed in ${minutes} minutes and ${seconds} seconds."
