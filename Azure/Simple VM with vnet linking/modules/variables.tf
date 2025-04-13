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
# DB pass pulled from secure library 
variable "dbpass" {}
# VM pass pulled from secure library 
variable "admin_password" {}
# Subscription id 
variable "sub_id" {}
# Subscription id 
variable "ten_id" {}
# backend RG for tfstate file storage:
variable "bk_resource_group_name" {}
# accountstorage name 
variable "bk_accountstorage" {}
# containerstorage name 
variable "bk_containerstorage" {}
# keynamestorage  
variable "bk_keynamestorage" {}
# Below if we have a blob in the same RG
# accountstorage name 
variable "accountstorage" {}
# containerstorage name 
variable "containerstorage" {}
# keynamestorage  
variable "keynamestorage" {}
#####
# Box specific 
#####
# simple Proxy VM

# network_security_groups
variable "network_security_group" {}
# network_security_groups_rules
variable "network_security_rule" {}
# Public IP
variable "public_ip" {}
# managed_data_disks
variable "managed_data_disk" {}
# managed_data_disks_attachments - setting a null here as some VM's don't need one
variable "managed_data_disks_attachment" {}
# Network Interface
#variable "network_interface" {}
# virtual machines
variable "linux_virtual_machine" {}
# AV set 
variable "management_availability_set" {}
variable "vnet_peering_link" {}
variable "dns_zone_peering" {}