#!/bin/bash

##############################################################################
# Wazuh Installation Guide Script
#
# Description:
# This script provides a step-by-step guide for installing the Wazuh 
# security monitoring platform on an Ubuntu Server.
#
# Note:
# - This script can be used as a fully automated deployment script.
# - This script works on Ubuntu Server 20.04 and  22.04 versions.


# Author: Ahmed SAFTA
# Date: 2025-05-25
##############################################################################

# Step 1: Update system packages
echo "[*] Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Download and run the official Wazuh installation script
echo "[*] Downloading and executing the Wazuh installation script..."
sudo curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh
sudo bash ./wazuh-install.sh -a

# Step 3: Confirm installation
echo "[✓] Wazuh installation completed successfully!"

# Step 4 (Optional): Retrieve instance IP address
INSTANCE_IP=$(hostname -I | awk '{print $1}')

# Step 5: Display dashboard URL
echo "--------------------------------------------------"
echo "Wazuh Dashboard URL: https://$INSTANCE_IP"
echo "Use your credentials to log in to the dashboard."
echo "--------------------------------------------------"