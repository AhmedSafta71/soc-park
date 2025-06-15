##############################################################################
# OpenCTI Installation Guide for Ubuntu Server 20.04
#
# Description:
# This file is a step-by-step installation guide for deploying OpenCTI 
# (Open Cyber Threat Intelligence) on an Ubuntu Server 20.04 system.
#
# Important:
# - This is NOT an executable script; it is intended to be followed manually.
# - Do NOT execute this file as a whole—it will not function as an automated installer.
# - Carefully follow each step in sequence to ensure a successful installation.
#
# Author: Ahmed SAFTA
# Date: 2025-05-15
##############################################################################

# Requirements :  8Go - 6 cpu cores - ubuntu-server-20.04
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io docker-compose jq -y
sudo systemctl enable docker
sudo systemctl start docker

# verify the docker and docker-compose version 
docker --version
docker-compose --version
# Here we will notice that the downloaded version is 1.5 or the nedded  version  to complete the installation is minimum 3
# What we will need to do is to reinstall docker-compose
sudo apt-get remove docker-compose
# re-install docker-compose  packages
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# check installed version
docker-compose --version

# Download the  opencti packages
mkdir -p /opt/opencti && cd /opt/opencti
git clone https://github.com/OpenCTI-Platform/docker.git
cd docker

# OpenCTI requires adjustments to ElasticSearch settings.
sudo sysctl -w vm.max_map_count=1048575
# To make this change permanent:
echo "vm.max_map_count=1048575" | sudo tee -a /etc/sysctl.conf
# verify if everything  is  configured correctly 
sudo sysctl -p
# Set up env variables //
     # Here I made some changements on the password opencti 
     # http://localhost:8080 >> http://opencti_server_ip:8080
     # RABBITMQ_DEFAULT_USER=opencti
     # RABBITMQ_DEFAULT_PASS=opencti
     
(cat << EOF
OPENCTI_ADMIN_EMAIL=admin@opencti.io
OPENCTI_ADMIN_PASSWORD=ChangeMePlease
OPENCTI_ADMIN_TOKEN=$(cat /proc/sys/kernel/random/uuid)
OPENCTI_BASE_URL=http://localhost:8080
OPENCTI_HEALTHCHECK_ACCESS_KEY=$(cat /proc/sys/kernel/random/uuid)
MINIO_ROOT_USER=$(cat /proc/sys/kernel/random/uuid)
MINIO_ROOT_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
RABBITMQ_DEFAULT_USER=guest
RABBITMQ_DEFAULT_PASS=guest
ELASTIC_MEMORY_SIZE=4G
CONNECTOR_HISTORY_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_EXPORT_FILE_STIX_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_EXPORT_FILE_CSV_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_IMPORT_FILE_STIX_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_EXPORT_FILE_TXT_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_IMPORT_DOCUMENT_ID=$(cat /proc/sys/kernel/random/uuid)
CONNECTOR_ANALYSIS_ID=$(cat /proc/sys/kernel/random/uuid)
SMTP_HOSTNAME=localhost
EOF
) > .env

# confirm that .env file is  genrated 
cat .env
# Add  some adjusments on  docker-compose.yml 
nano docker-compose.yml
# You may need to add the  version line at the top of the yml file 
version: "3" 
# For rabbitmq section try to add these lines if  not found 
    environment:
      - RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS=-rabbit consumer_timeout 86400000
    command: >
      rabbitmq-server
      --rabbitmq-management
      --limit max_message_size 536870912
      
 # For elsaticsearch  section try to add these lines if  not found 
 # to me it was set correctly  >>  no changes to be add  
    environment:
      - "thread_pool.search.queue_size=5000"
      
 # launch container installation with docker-compose up command  
docker-compose up -d
# Check if containers are  running correctly 
docker ps 
# visit the website dashbord 
http://192.168.210 
login user-name: admin@opencti.io
password: ChangeMePlease // if you don't change it  for me I modified it to opencti