#!/bin/bash

# Define ANSI escape code for bold, green color, and no color
RED='\033[1;31m'
BOLD='\033[1;32m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="/tmp/adopisoft_install.log"

# Function to print messages
print_message() {
    echo -e "$1$2${NC}"
    echo -e "$2" | sudo tee -a "$LOG_FILE"
}

# Function to check command success
check_success() {
    if [ $? -ne 0 ]; then
        print_message "$RED" "Error: $1"
        exit 1
    fi
}

# Capture start time
start_time=$(date +%s)

# Print green header
print_message "$GREEN" "#########################################################################\\n"
print_message "$BOLD" "                  AdoPisoft automatic install script"
print_message "$BOLD" " To avoid conflicts, use this script in a fresh install of Ubuntu 22.04"
print_message "$GREEN" "
        __                ___.                          __    
       |  | __ ____ _____ \\_ |__   _____ _____    _____|  | __
       |  |/ // ___\\__  \\ | __ \\ /     \\__  \\  /  ___/  |/ /
       |    <\\  \\___ / __ \\| \\_\\ \\  Y Y  \\/ __ \\_\\___ \\|    < 
       |__|_ \\___  >____  /___  /__|_|  (____  /____  >__|_ \\
           \\/    \\/     \\/    \\/      \\/     \\/     \\/     \\/
"
print_message "$GREEN" "#########################################################################\\n"

# Update and upgrade system
print_message "$BOLD" "Updating and upgrading system..."
sudo apt-get update >> "$LOG_FILE" 2>&1 && sudo apt-get upgrade -y >> "$LOG_FILE" 2>&1
check_success "System update and upgrade failed."

# Install required packages
install_packages=(
    "curl"
    "nodejs"
    "python2"
    "nginx"
    "bind9"
    "isc-dhcp-server"
    "iptables"
    "hostapd"
    "dmidecode"
    "build-essential"
    "openssh-server"
    "python-pip"
    "unzip"
    "bridge-utils"
    "git"
    "iputils-arping"
)

print_message "$BOLD" "Installing required packages..."
for package in "${install_packages[@]}"; do
    print_message "$BOLD" "Installing $package..."
    sudo apt-get install -y $package >> "$LOG_FILE" 2>&1
    check_success "$package installation failed."
done

# Install Node.js version 18.x
print_message "$BOLD" "Installing Node.js version 18.x..."
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - >> "$LOG_FILE" 2>&1
check_success "Node.js setup script failed. Check the log file for details."
sudo apt-get install -y nodejs >> "$LOG_FILE" 2>&1
check_success "Node.js installation failed. Check the log file for details."

# Download and install AdoPiSoft
print_message "$BOLD" "Downloading and installing AdoPiSoft..."
wget -O /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb https://github.com/AdoPiSoft/Releases/releases/download/v5.1.5/adopisoft-5.1.5-amd64-node-v16.4.0.deb >> "$LOG_FILE" 2>&1
check_success "AdoPiSoft download failed."
sudo apt-get install -y /tmp/adopisoft-5.1.5-amd64-node-v16.4.0.deb >> "$LOG_FILE" 2>&1
check_success "AdoPiSoft installation failed."

# Ask if user wants to install PostgreSQL
read -p "$(echo -e ${BOLD}${RED})Do you want to install PostgreSQL? (y/n): $(echo -e ${NC})" install_psql
if [ "$install_psql" == "y" ]; then
    # Download ado-psql-script.sh
    print_message "$BOLD" "Downloading ado-psql-script.sh..."
    wget -O ado-psql-script.sh https://gist.githubusercontent.com/alenteria/791dbe32175a01d1f1b602b25489ad22/raw/9a5aa879ac70d24bd9a7dd7f8ed97d7fe2c2f597/ado-psql-script.sh >> "$LOG_FILE" 2>&1
    check_success "ado-psql-script.sh download failed."

    # Set execute permissions
    print_message "$BOLD" "Setting execute permissions for ado-psql-script.sh..."
    sudo chmod a+x ./ado-psql-script.sh
    check_success "Setting execute permissions for ado-psql-script.sh failed."

    # Execute ado-psql-script.sh
    print_message "$BOLD" "Executing ado-psql-script.sh..."
    sudo ./ado-psql-script.sh >> "$LOG_FILE" 2>&1
    check_success "ado-psql-script.sh execution failed."

    print_message "$BOLD" "PostgreSQL installation completed."
else
    print_message "$BOLD" "PostgreSQL installation skipped."
fi

# Enable and start AdoPiSoft service
print_message "$BOLD" "Enabling AdoPiSoft service..."
sudo systemctl enable adopisoft >> "$LOG_FILE" 2>&1
check_success "Enabling AdoPiSoft service failed."
print_message "$BOLD" "Starting AdoPiSoft..."
sudo systemctl start adopisoft >> "$LOG_FILE" 2>&1
check_success "Starting AdoPiSoft service failed."

# Capture end time
end_time=$(date +%s)

# Calculate and print the total execution time in minutes and seconds
execution_time=$((end_time - start_time))
minutes=$((execution_time / 60))
seconds=$((execution_time % 60))
print_message "$BOLD" "Script execution completed in ${minutes} minutes and ${seconds} seconds."
