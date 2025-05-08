resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }
# Anything not in a var is the default value
  name                         = var.vnet_peering_name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = var.remote_virtual_network_id
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  allow_virtual_network_access = true
  use_remote_gateways          = false
}