resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                  = var.private_dns_zone_virtual_network_link_name
  private_dns_zone_name = var.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
  tags                  = merge(tomap({ "module_version" = "0.0.1", "type" = "PrivateDNSZoneVirtualNetworkLink" }), var.tags)

}