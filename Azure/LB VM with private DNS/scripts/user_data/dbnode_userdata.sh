#!/bin/bash
# mkdirs for the creds and pw dumps
sudo mkdir /cfg/
sudo touch /cfg/pospassword
sudo touch /cfg/moniker
sudo touch /cfg/reppassword
sudo touch /cfg/bacpassword
sudo echo "${pospassword}" > /cfg/pospassword
sudo echo "${moniker}" > /cfg/moniker
sudo echo "${reppassword}" > /cfg/reppassword
sudo echo "${bacpassword}" > /cfg/bacpassword
# Fuse Blob 2 API for direct blob linking. 
sudo touch /cfg/accname
sudo touch /cfg/conname
sudo echo "${accountname}" > /cfg/accname
sudo echo "${containername}" > /cfg/conname
sudo touch /cfg/cli_id
sudo echo "${cli_id}" > /cfg/cli_id
sudo touch /cfg/sec_id
sudo echo "${sec_id}" > /cfg/sec_id
sudo touch /cfg/ten_id
sudo echo "${ten_id}" > /cfg/ten_id
apt update
# Salt minion install
sudo apt install -y salt-minion jq
# Make sure to set and store the saltmaster IP for use here
echo "master: ${saltmasterip}" > /etc/salt/minion.d/99-master-address.conf
# echo "gb-dev-coturn-1-a.test-azu" > /etc/salt/minion_id
echo $HOSTNAME > /etc/salt/minion_id
# SSH race condition mitigation cve-2024-6387 - 2minute connection grace to 10 seconds
sed -i 's/#LoginGraceTime 2m/LoginGraceTime 10/g' /etc/ssh/sshd_config
sed -i 's/#MaxStartups 10/MaxStartups 5/g' /etc/ssh/sshd_config
# Restart the services
systemctl restart sshd.service
systemctl restart ssh.service
systemctl restart salt-minion.service
# Finally reboot to set the Hostname
reboot