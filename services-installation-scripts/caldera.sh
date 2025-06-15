#!/bin/bash

##############################################################################
# Caldera Installation Guide for Ubuntu Server 20.04
#
# Description:
# This guide outlines the steps required to install MITRE Caldera 4.1.0
# on an Ubuntu system. Caldera is an automated adversary emulation system
# developed by MITRE.
#
# IMPORTANT:
# - This is a guided script. Do NOT run it blindly without reviewing each step.
# - Some steps (e.g., server startup) are meant to be executed manually.
#
# Author: Ahmed SAFTA
# Date: 2025-06-01
##############################################################################

# Step 1: Install required system dependencies
echo "[*] Installing required packages..."
sudo apt update && sudo apt install -y \
  python3 python3-pip git gcc python3-dev upx-ucl wget

# Step 2: Install Go (required for some Caldera plugins)
echo "[*] Installing Go 1.20.3..."
wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

# Step 3: Set Go environment variable
echo "[*] Configuring Go environment..."
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile

# Step 4: Clone Caldera repository
echo "[*] Cloning MITRE Caldera (branch 4.1.0)..."
git clone https://github.com/mitre/caldera.git --recursive --branch 4.1.0
cd caldera || { echo "[!] Failed to enter Caldera directory"; exit 1; }

# Step 5: Install Python dependencies
echo "[*] Installing Python requirements..."
pip3 install -r requirements.txt

echo
echo "[✓] Caldera installation completed."
echo
echo "===================================================="
echo "To start Caldera for the first time:"
echo
echo "1. Create and activate the virtual environment:"
echo "     python3 -m venv caldera_venv"
echo "     source caldera_venv/bin/activate"
echo
echo "2. Start Caldera (initial insecure build mode):"
echo "     python3 server.py --insecure --build"
echo
echo "3. Access the Caldera web interface at:"
echo "     https://<your-server-ip>:8888"
echo
echo "Default login credentials:"
echo "  - red   : admin"
echo "  - blue  : admin"
echo "  - admin : admin"
echo "===================================================="
