#!/bin/bash
sudo mkdir /cfg/
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