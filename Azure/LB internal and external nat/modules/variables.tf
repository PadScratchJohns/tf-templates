#####
# shared
#####
variable "tags" {}
variable "maxc_ssh_address_list" {}
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
# Carrier rtpengine VM

# network_security_groups
variable "network_security_group" {}
# network_security_groups_rules
variable "rtpengine_network_security_rule" {}
variable "registrar_network_security_rule" {}
# Public IP
variable "public_ip" {}
# managed_data_disks
variable "rtpengine_managed_data_disk" {}
variable "registrar_managed_data_disk" {} 
# managed_data_disks_attachments - setting a null here as some VM's don't need one
variable "rtpengine_managed_data_disks_attachment" {}
variable "registrar_managed_data_disks_attachment" {}
# Network Interface
#variable "network_interface" {}
# virtual machines
variable "rtpengine_linux_virtual_machine" {}
variable "registrar_linux_virtual_machine" {}
# blob storage
variable "storage_account" {}
variable "storage_container" {}
variable "storage_network_rules" {}
# AV set 
variable "management_availability_set" {}
# Peering
variable "virtual_network_peering" {}
# DNS
variable "dns_zone_peering" {}
# LB
variable "load_balancer" {}
variable "load_balancer_backend_address_pool" {}
variable "load_balancer_backend_address_pool_association" {}
variable "load_balancer_probe" {}
variable "load_balancer_rule" {}
