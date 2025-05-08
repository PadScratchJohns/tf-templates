#!/bin/bash
# hostname work done in config
sudo mkdir /cfg/
# Installs
apt update
sudo apt install -y salt-master
# Set the path for repo and auto accept minions. 
# For v3004 only
sed -i '331 s/#auto_accept: False/auto_accept: True/g' /etc/salt/master
sed -i '677 s/#file_roots:/file_roots:/g' /etc/salt/master
sed -i '678 s/#  base:/  base:/g' /etc/salt/master
sed -i '679 s/#    - \/srv\/salt/    - \/srv\/salt\/states/g' /etc/salt/master
sed -i '849 s/#pillar_roots:/pillar_roots:/g' /etc/salt/master
sed -i '850 s/#  base:/  base:/g' /etc/salt/master
sed -i '851 s/#    - \/srv\/pillar/    - \/srv\/salt\/pillar/g' /etc/salt/master
# Guac access
echo "HostKeyAlgorithms +ssh-rsa" >> /etc/ssh/sshd_config
# SSH race condition mitigation cve-2024-6387 - 2minute connection grace to 10 seconds
sed -i 's/#LoginGraceTime 2m/LoginGraceTime 10/g' /etc/ssh/sshd_config
sed -i 's/#MaxStartups 10/MaxStartups 5/g' /etc/ssh/sshd_config
# Restart the services
systemctl restart sshd.service
systemctl restart ssh.service
# Finally reboot to set the Hostname
reboot