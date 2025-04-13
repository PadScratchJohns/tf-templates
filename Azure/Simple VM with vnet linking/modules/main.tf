provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers. As per azurerm v4.x onwards this is deprecated so use: "resource_provider_registrations = none" if using version ~>4.0
  features {}
}
# Backend config - comment the below to run locally as init doesn't like backend config in the main.tf due to variables not being allowed?
terraform {
  backend "azurerm" {
      resource_group_name  = var.bk_resource_group_name
      storage_account_name = var.bk_accountstorage
      container_name       = var.bk_containerstorage
      key                  = var.bk_keynamestorage
      use_msi              = true
      subscription_id      = var.sub_id
      tenant_id            = var.ten_id
  }
  required_providers { # should probably be in versions.tf but not sure we can have two terraform blocks
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "=3.74.0"
      }
  }
}

module "resource_group" {
  source = "./resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "virtual_network" {
  source = "./virtual_network"

  virtual_network_name = var.virtual_network.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  address_space        = var.virtual_network.address_space
  tags                 = var.tags
}

module "subnet" {
  source = "./subnet"

  subnet_name          = var.subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
}

module "network_security_group" {
  source = "./network_security_group"

  for_each = var.network_security_group

  network_security_group_name = each.value.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tags                        = var.tags
}

module "network_security_rule" {
  source = "./network_security_rule"

  for_each = var.network_security_rule

  network_security_rule_name                 = each.value.name
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = each.value.network_security_group_name
  description                                = each.value.description
  protocol                                   = each.value.protocol
  source_port_range                          = try(each.value.source_port_range, null)
  source_port_ranges                         = try(each.value.source_port_ranges, null)
  destination_port_range                     = try(each.value.destination_port_range, null)
  destination_port_ranges                    = try(each.value.destination_port_ranges, null)
  source_address_prefix                      = try(each.value.source_address_prefix, null)
  source_address_prefixes                    = try(each.value.source_address_prefixes, null)
  source_application_security_group_ids      = try(each.value.source_application_security_group_ids, null)
  destination_address_prefix                 = try(each.value.destination_address_prefix, null)
  destination_address_prefixes               = try(each.value.destination_address_prefixes, null)
  destination_application_security_group_ids = try(each.value.destination_application_security_group_ids, null)
  access                                     = each.value.access
  priority                                   = each.value.priority
  direction                                  = each.value.direction
}
module "network_interface_security_group_association" {
  source = "./network_interface_security_group_association"
  for_each = var.linux_virtual_machine

  network_interface_id      = each.value.nic_id
  network_security_group_id = each.value.nsg_id
}
module "public_ip" {
  source = "./public_ip"
  for_each = var.public_ip

  public_ip_name      = each.value.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  sku_tier            = each.value.sku_tier
  domain_name_label   = each.value.domain_name_label
  zones               = each.value.zones
  tags                = var.tags
}

module "network_interface" {
  source = "./network_interface"

  for_each = var.linux_virtual_machine

  ip_configuration        = each.value.ip_configuration
  location                = var.location
  name                    = each.value.nic_name
  resource_group_name     = var.resource_group_name
  internal_dns_name_label = each.value.internal_dns_name_label
  tags                    = var.tags
}
module "linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = var.linux_virtual_machine

  admin_username                  = each.value.admin_username
  availability_set_id             = module.management_availability_set.availability_set.id
  user_data                       = each.value.user_data
  disable_password_authentication = each.value.disable_password_authentication
  location                        = var.location
  linux_virtual_machine_name      = each.value.name
  computer_name                   = each.value.computer_name # Hostname
  network_interface_ids           = [each.value.nic_name]
  os_disk                         = each.value.os_disk
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  admin_ssh_key                   = try(each.value.admin_ssh_key, null)
  admin_password                  = var.admin_password # passed from the pipeline
  source_image_reference          = each.value.source_image_reference
  tags                            = var.tags
  dbpass                          = var.dbpass
  saltmasterip                    = var.saltmasterip
  vnet_split                      = var.vnet_split
  peered_vnet_split               = var.peered_vnet_split
  zone                            = each.value.zone
}

module "managed_disk" {
  source = "./managed_disk"

  for_each = var.managed_data_disk

  managed_disk_name             = each.value.disk_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = each.value.storage_account_type
  create_option                 = each.value.create_option
  disk_size_gb                  = each.value.disk_size_gb
  zone                          = each.value.zone
  tags                          = var.tags
  #on_demand_bursting_enabled    = each.value.on_demand_bursting_enabled
  #public_network_access_enabled = each.value.public_network_access_enabled
  #trusted_launch_enabled        = each.value.trusted_launch_enabled
  #upload_size_bytes             = each.value.upload_size_bytes
}
module "virtual_machine_data_disk_attachment" {
  source = "./virtual_machine_data_disk_attachment"

  for_each = var.managed_data_disks_attachment
  virtual_machine_id        = each.value.virtual_machine_id
  managed_disk_id           = each.value.managed_disk_id
  lun                       = each.value.lun
  caching                   = each.value.caching
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
# boilerplate
module "management_availability_set" {
  source = "./availability_set"

  availability_set_name       = var.management_availability_set.name
  resource_group_name         = var.resource_group_name
  platform_fault_domain_count = var.management_availability_set.platform_fault_domain_count
  location                    = var.location
  tags                        = var.tags
}
module "virtual_network_peering" {
  source = "./virtual_network_peering"
  for_each = var.vnet_peering_link

  vnet_peering_name                = each.value.vnet_peering_name
  resource_group_name              = each.value.resource_group_name
  virtual_network_name             = each.value.virtual_network_name
  remote_virtual_network_id        = each.value.remote_virtual_network_id
}
module "dns_zone_peering" {
  source = "./dns_zone_peering"
  for_each = var.dns_zone_peering

  name                             = each.value.name
  resource_group_name              = each.value.resource_group_name
  private_dns_zone_name            = each.value.private_dns_zone_name
  virtual_network_id               = each.value.virtual_network_id
}