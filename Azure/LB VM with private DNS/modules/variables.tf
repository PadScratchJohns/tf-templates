#####
# shared
#####
variable "tags" {}
variable "location" {}
variable "environment" {}
variable "moniker" {}
# Resource Group Name
variable "resource_group_name" {}
variable "local_ip" {}
variable "saltmasterip" {}
variable "virtual_network" {}
variable "subnet" {}
variable "address_prefixes" {}
variable "service_endpoints" {}
variable "vnet_split" {}
variable "peered_vnet_split" {}
variable "virtual_network_name" {}
# DB pass pulled from secure library - not all boxes have this so setting a string var here so the automation can survive if this is not set. 
variable "dbpass" {}
# VM pass pulled from secure library 
variable "admin_password" {}
# Backup password pulled from secure library 
variable "bacpassword" {}
# Postgres pass pulled from secure library 
variable "pospassword" {}
# Replication pass pulled from secure library 
variable "reppassword" {}
# Salt Repo key pulled from secure library 
variable "saltrepokey" {}
# Subscription id 
variable "sub_id" {}
# Tenant id 
variable "ten_id" {}
# secret id from pipeline for service principal 
variable "sec_id" {}
# client id from pipeline for service principal 
variable "cli_id" {}
# backend RG for tfstate file storage:
variable "bk_resource_group_name" {}
# accountstorage name 
variable "bk_accountstorage" {}
# containerstorage name 
variable "bk_containerstorage" {}
# keynamestorage  
variable "bk_keynamestorage" {}
# accountstorage name 
variable "accountstorage" {}
# containerstorage name 
variable "containerstorage" {}
# Below if we have a blob in the same RG
# accountstorage name 
variable "accountname" {}
# containerstorage name 
variable "containername" {}
# keynamestorage  
variable "keynamestorage" {}
#####
# Box specific 
#####
# Carrier dbnode VM

# network_security_groups
variable "network_security_group" {}
# network_security_groups_rules
variable "dbnode_network_security_rule" {}
variable "haproxy_network_security_rule" {}
variable "homer_network_security_rule" {}
variable "saltmaster_network_security_rule" {}
# Public IP
variable "public_ip" {}
# managed_data_disks
variable "dbnode_managed_data_disk" {}
variable "haproxy_managed_data_disk" {} 
variable "homer_managed_data_disk" {}
# managed_data_disks_attachments - setting a null here as some VM's don't need one
variable "dbnode_managed_data_disks_attachment" {}
variable "haproxy_managed_data_disks_attachment" {}
variable "homer_managed_data_disks_attachment" {}
# Network Interface
#variable "network_interface" {}
# virtual machines
variable "dbnode_linux_virtual_machine" {}
variable "haproxy_linux_virtual_machine" {}
variable "homer_linux_virtual_machine" {}
variable "saltmaster_linux_virtual_machine" {}
# blob storage
variable "storage_account" {}
variable "storage_container" {}
variable "storage_network_rules" {}
# AV set 
variable "management_availability_set" {}
variable "remote_virtual_network_id" {}
variable "vnet_peering_name" {}
# DNS
variable "private_dns_zone" {} 
variable "dns_zone_peering" {}
variable "private_dns_a_record" {}
# LB
variable "load_balancer" {}
variable "load_balancer_backend_address_pool" {}
variable "load_balancer_backend_address_pool_association" {}
variable "load_balancer_probe" {}
variable "load_balancer_rule" {}
