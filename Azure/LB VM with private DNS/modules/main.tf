# Modules are activated with -target=module.${module_name} 
# When you add more VM types, this will add more modules! 
# TODO - JH - README.md needed
provider "azurerm" { # Needs this otherwise the init errors
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers. As per azurerm v4.x onwards this is deprecated so use: "resource_provider_registrations = none" if using version ~>4.0
  features {}
  storage_use_azuread = true
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


module "dbnode_network_security_rule" {
  source = "./network_security_rule"

  for_each = var.dbnode_network_security_rule

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
module "haproxy_network_security_rule" {
  source = "./network_security_rule"

  for_each = var.haproxy_network_security_rule

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
module "homer_network_security_rule" {
  source = "./network_security_rule"

  for_each = var.homer_network_security_rule

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
module "saltmaster_network_security_rule" {
  source = "./network_security_rule"

  for_each = var.saltmaster_network_security_rule

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
# Change the modual names for additional NSG associations 
#module "internal_nsg_subnet_network_security_group_association" {
#  source = "./subnet_network_security_group_association"

#  network_security_group_id = module.network_security_group.nsg_id
#  subnet_id                 = module.subnet.subnet.id
#}
module "dbnode_network_interface_security_group_association" {
  source = "./network_interface_security_group_association"
  for_each = var.dbnode_linux_virtual_machine

  network_interface_id      = each.value.nic_id
  network_security_group_id = each.value.nsg_id
}
module "haproxy_network_interface_security_group_association" {
  source = "./network_interface_security_group_association"
  for_each = var.haproxy_linux_virtual_machine

  network_interface_id      = each.value.nic_id
  network_security_group_id = each.value.nsg_id
}
module "homer_network_interface_security_group_association" {
  source = "./network_interface_security_group_association"
  for_each = var.homer_linux_virtual_machine

  network_interface_id      = each.value.nic_id
  network_security_group_id = each.value.nsg_id
}
module "saltmaster_network_interface_security_group_association" {
  source = "./network_interface_security_group_association"
  for_each = var.saltmaster_linux_virtual_machine

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

module "dbnode_network_interface" {
  source = "./network_interface"

  for_each = var.dbnode_linux_virtual_machine

  ip_configuration        = each.value.ip_configuration
  location                = var.location
  name                    = each.value.nic_name
  resource_group_name     = var.resource_group_name
  internal_dns_name_label = each.value.internal_dns_name_label
  tags                    = var.tags
}
module "haproxy_network_interface" {
  source = "./network_interface"

  for_each = var.haproxy_linux_virtual_machine

  ip_configuration        = each.value.ip_configuration
  location                = var.location
  name                    = each.value.nic_name
  resource_group_name     = var.resource_group_name
  internal_dns_name_label = each.value.internal_dns_name_label
  tags                    = var.tags
}
module "homer_network_interface" {
  source = "./network_interface"

  for_each = var.homer_linux_virtual_machine

  ip_configuration        = each.value.ip_configuration
  location                = var.location
  name                    = each.value.nic_name
  resource_group_name     = var.resource_group_name
  internal_dns_name_label = each.value.internal_dns_name_label
  tags                    = var.tags
}
module "saltmaster_network_interface" {
  source = "./network_interface"

  for_each = var.saltmaster_linux_virtual_machine

  ip_configuration        = each.value.ip_configuration
  location                = var.location
  name                    = each.value.nic_name
  resource_group_name     = var.resource_group_name
  internal_dns_name_label = each.value.internal_dns_name_label
  tags                    = var.tags
}
module "dbnode_linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = var.dbnode_linux_virtual_machine

  admin_username                  = each.value.admin_username
  availability_set_id             = module.management_availability_set.availability_set.id
  boot_diagnostics                = try(each.value.boot_diagnostics, null)
  identity                        = each.value.identity 
  user_data                       = each.value.user_data
  disable_password_authentication = each.value.disable_password_authentication
  location                        = var.location
  linux_virtual_machine_name      = each.value.name
  computer_name                   = each.value.computer_name # Hostname
  network_interface_ids           = [each.value.nic_id]
  os_disk                         = each.value.os_disk
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  admin_ssh_key                   = try(each.value.admin_ssh_key, null)
  admin_password                  = var.admin_password # passed from the pipeline
  source_image_reference          = each.value.source_image_reference
  tags                            = var.tags
  moniker                         = var.moniker
  saltmasterip                    = var.saltmasterip
  vnet_split                      = var.vnet_split
  peered_vnet_split               = var.peered_vnet_split
  environment                     = var.environment
  cli_id                          = var.cli_id
  sec_id                          = var.sec_id
  ten_id                          = var.ten_id
  bacpassword                     = var.bacpassword
  pospassword                     = var.pospassword
  reppassword                     = var.reppassword
  accountname                     = var.accountname 
  containername                   = var.containername
  zone                            = each.value.zone
}
module "haproxy_linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = var.haproxy_linux_virtual_machine

  admin_username                  = each.value.admin_username
  availability_set_id             = module.management_availability_set.availability_set.id
  boot_diagnostics                = try(each.value.boot_diagnostics, null)
  identity                        = each.value.identity 
  user_data                       = each.value.user_data
  disable_password_authentication = each.value.disable_password_authentication
  location                        = var.location
  linux_virtual_machine_name      = each.value.name
  computer_name                   = each.value.computer_name # Hostname
  network_interface_ids           = [each.value.nic_id]
  os_disk                         = each.value.os_disk
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  admin_ssh_key                   = try(each.value.admin_ssh_key, null)
  admin_password                  = var.admin_password # passed from the pipeline
  source_image_reference          = each.value.source_image_reference
  tags                            = var.tags
  moniker                         = var.moniker
  saltmasterip                    = var.saltmasterip
  vnet_split                      = var.vnet_split
  peered_vnet_split               = var.peered_vnet_split
  environment                     = var.environment
  cli_id                          = var.cli_id
  sec_id                          = var.sec_id
  ten_id                          = var.ten_id
  accountname                     = var.accountname 
  containername                   = var.containername
  zone                            = each.value.zone
}
module "homer_linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = var.homer_linux_virtual_machine

  admin_username                  = each.value.admin_username
  availability_set_id             = module.management_availability_set.availability_set.id
  boot_diagnostics                = try(each.value.boot_diagnostics, null)
  identity                        = each.value.identity 
  user_data                       = each.value.user_data
  disable_password_authentication = each.value.disable_password_authentication
  location                        = var.location
  linux_virtual_machine_name      = each.value.name
  computer_name                   = each.value.computer_name # Hostname
  network_interface_ids           = [each.value.nic_id]
  os_disk                         = each.value.os_disk
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  admin_ssh_key                   = try(each.value.admin_ssh_key, null)
  admin_password                  = var.admin_password # passed from the pipeline
  source_image_reference          = each.value.source_image_reference
  tags                            = var.tags
  moniker                         = var.moniker
  saltmasterip                    = var.saltmasterip
  vnet_split                      = var.vnet_split
  peered_vnet_split               = var.peered_vnet_split
  environment                     = var.environment
  cli_id                          = var.cli_id
  sec_id                          = var.sec_id
  ten_id                          = var.ten_id
  accountname                     = var.accountname 
  containername                   = var.containername
  zone                            = each.value.zone
}
module "saltmaster_linux_virtual_machine" {
  source = "./linux_virtual_machine"

  for_each = var.saltmaster_linux_virtual_machine

  admin_username                  = each.value.admin_username
  availability_set_id             = module.management_availability_set.availability_set.id
  boot_diagnostics                = try(each.value.boot_diagnostics, null)
  identity                        = each.value.identity 
  user_data                       = each.value.user_data
  disable_password_authentication = each.value.disable_password_authentication
  location                        = var.location
  linux_virtual_machine_name      = each.value.name
  computer_name                   = each.value.computer_name # Hostname
  network_interface_ids           = [each.value.nic_id]
  os_disk                         = each.value.os_disk
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  admin_ssh_key                   = try(each.value.admin_ssh_key, null)
  admin_password                  = var.admin_password # passed from the pipeline
  source_image_reference          = each.value.source_image_reference
  tags                            = var.tags
  moniker                         = var.moniker
  saltmasterip                    = var.saltmasterip
  vnet_split                      = var.vnet_split
  peered_vnet_split               = var.peered_vnet_split
  environment                     = var.environment
  cli_id                          = var.cli_id
  sec_id                          = var.sec_id
  ten_id                          = var.ten_id
  saltrepokey                     = var.saltrepokey
  accountname                     = var.accountname 
  containername                   = var.containername
  zone                            = each.value.zone
}
# data disks
module "dbnode_managed_data_disk" {
  source = "./managed_disk"

  for_each = var.dbnode_managed_data_disk

  managed_disk_name             = each.value.disk_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = each.value.storage_account_type
  create_option                 = each.value.create_option
  disk_size_gb                  = each.value.disk_size_gb
  zone                          = each.value.zone
  tags                          = var.tags
  on_demand_bursting_enabled    = each.value.on_demand_bursting_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  trusted_launch_enabled        = each.value.trusted_launch_enabled
  upload_size_bytes             = each.value.upload_size_bytes
}
module "haproxy_managed_data_disk" {
  source = "./managed_disk"

  for_each = var.haproxy_managed_data_disk

  managed_disk_name             = each.value.disk_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = each.value.storage_account_type
  create_option                 = each.value.create_option
  disk_size_gb                  = each.value.disk_size_gb
  zone                          = each.value.zone
  tags                          = var.tags
  on_demand_bursting_enabled    = each.value.on_demand_bursting_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  trusted_launch_enabled        = each.value.trusted_launch_enabled
  upload_size_bytes             = each.value.upload_size_bytes
}
module "homer_managed_data_disk" {
  source = "./managed_disk"

  for_each = var.homer_managed_data_disk

  managed_disk_name             = each.value.disk_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  storage_account_type          = each.value.storage_account_type
  create_option                 = each.value.create_option
  disk_size_gb                  = each.value.disk_size_gb
  zone                          = each.value.zone
  tags                          = var.tags
  on_demand_bursting_enabled    = each.value.on_demand_bursting_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  trusted_launch_enabled        = each.value.trusted_launch_enabled
  upload_size_bytes             = each.value.upload_size_bytes
}
# Data disk attachment
module "dbnode_virtual_machine_data_disk_attachment" {
  source = "./virtual_machine_data_disk_attachment"

  for_each = var.dbnode_managed_data_disks_attachment
  virtual_machine_id        = each.value.virtual_machine_id
  managed_disk_id           = each.value.managed_disk_id
  lun                       = each.value.lun
  caching                   = each.value.caching
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
module "haproxy_virtual_machine_data_disk_attachment" {
  source = "./virtual_machine_data_disk_attachment"

  for_each = var.haproxy_managed_data_disks_attachment
  virtual_machine_id        = each.value.virtual_machine_id
  managed_disk_id           = each.value.managed_disk_id
  lun                       = each.value.lun
  caching                   = each.value.caching
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
module "homer_virtual_machine_data_disk_attachment" {
  source = "./virtual_machine_data_disk_attachment"

  for_each = var.homer_managed_data_disks_attachment
  virtual_machine_id        = each.value.virtual_machine_id
  managed_disk_id           = each.value.managed_disk_id
  lun                       = each.value.lun
  caching                   = each.value.caching
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
# boilerplate AV
module "management_availability_set" {
  source = "./availability_set"

  availability_set_name       = var.management_availability_set.name
  resource_group_name         = var.resource_group_name
  platform_fault_domain_count = var.management_availability_set.platform_fault_domain_count
  location                    = var.location
  tags                        = var.tags
}
# DNS Zone linking:
module "dns_zone_peering" {
  source = "./dns_zone_peering"
  for_each = var.dns_zone_peering

  name                             = each.value.name
  resource_group_name              = each.value.resource_group_name
  private_dns_zone_name            = each.value.private_dns_zone_name
  virtual_network_id               = each.value.virtual_network_id
}

# Blob account for this RG - mainly for recordings or backups. Not needed in the carrier proxy, but used to test in DEV
module "storage_account" {
  source = "./storage_account"
  for_each = var.storage_account

  storage_account_name             = each.value.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  access_tier                      = each.value.access_tier
  min_tls_version                  = each.value.min_tls_version
  default_to_oauth_authentication  = each.value.default_to_oauth_authentication
  blob_properties                  = each.value.blob_properties
  allow_nested_items_to_be_public  = each.value.allow_nested_items_to_be_public
  cross_tenant_replication_enabled = each.value.cross_tenant_replication_enabled
  shared_access_key_enabled        = each.value.shared_access_key_enabled
#  network_rules                    = each.value.network_rules # handled in its own module
} 
# Containers for blobs above
module "storage_container" { # storage_account_name deprecated in later versions, use the id variant below. 
  source = "./storage_container"
  for_each = var.storage_container

  container_name        = each.value.container_name
  storage_account_name  = each.value.storage_account_name
  #storage_account_id    = each.value.storage_account_id 
  container_access_type = each.value.container_access_type
}
module "storage_network_rules" { # storage_account_name deprecated in later versions, use the id variant below. 
  source = "./storage_network_rules"
  depends_on = [module.storage_container]
  for_each = var.storage_network_rules

  storage_account_id         = each.value.storage_account_id
  #resource_group_name        = var.resource_group_name
  #storage_account_name       = each.value.storage_account_name
  default_action             = each.value.default_action
  bypass                     = each.value.bypass
  ip_rules                   = each.value.ip_rules
  virtual_network_subnet_ids = each.value.virtual_network_subnet_ids
  private_link_access        = each.value.private_link_access
}

# DNS
module "private_dns_zone" {
  source = "./private_dns_zone"

  private_dns_zone_name = var.private_dns_zone.name
  resource_group_name   = var.resource_group_name
  soa_record            = var.private_dns_zone.soa_record
  tags                  = var.tags
}

module "private_dns_a_record" {
  source = "./private_dns_a_record"

  for_each = var.private_dns_a_record

  private_dns_a_record_name = each.value.name
  resource_group_name       = var.resource_group_name
  zone_name                 = each.value.zone_name
  records                   = each.value.records
}
# Loadbalancer rules
module "load_balancer" {
  source = "./load_balancer"

  for_each = var.load_balancer

  resource_group_name       = var.resource_group_name
  location                  = var.location
  load_balancer_name        = each.value.name
  frontend_ip_configuration = each.value.frontend_ip_configuration
  sku                       = each.value.sku
  sku_tier                  = each.value.sku_tier
  tags                      = var.tags
}
module "load_balancer_backend_address_pool" {
  source = "./load_balancer_backend_address_pool"
  depends_on = [module.load_balancer]
  for_each = var.load_balancer_backend_address_pool

  load_balancer_backend_address_pool_name = each.value.name
  load_balancer_id                        = each.value.load_balancer_id
  #virtual_network_id                      = each.value.virtual_network_id
}
module "load_balancer_backend_address_pool_association" { # do multiple modules for this if needed
  source = "./load_balancer_backend_address_pool_association"
  depends_on = [module.load_balancer_backend_address_pool]
  for_each = var.haproxy_linux_virtual_machine

  network_interface_id                = each.value.nic_id
  ip_configuration_name               = each.value.ip_configuration_name 
  backend_address_pool_id             = each.value.backend_address_pool_id
}
module "load_balancer_probe" {
  source = "./load_balancer_probe"

  for_each = var.load_balancer_probe

  load_balancer_probe_name = each.value.name
  load_balancer_id         = each.value.load_balancer_id
  protocol                 = each.value.protocol
  port                     = each.value.port
  probe_threshold          = each.value.probe_threshold
  request_path             = try(each.value.request_path, null)
  interval_in_seconds      = each.value.interval_in_seconds
  number_of_probes         = each.value.number_of_probes

}
module "load_balancer_rule" {
  source = "./load_balancer_rule"

  for_each = var.load_balancer_rule

  load_balancer_rule_name        = each.value.name
  load_balancer_id               = each.value.load_balancer_id
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  backend_address_pool_ids       = each.value.backend_address_pool_id
  probe_id                       = each.value.probe_id
  enable_floating_ip             = each.value.enable_floating_ip
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
  load_distribution              = each.value.load_distribution
  disable_outbound_snat          = each.value.disable_outbound_snat
  enable_tcp_reset               = each.value.enable_tcp_reset
}