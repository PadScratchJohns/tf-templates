resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_peering" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                      = var.name
  resource_group_name       = var.resource_group_name
  private_dns_zone_name     = var.private_dns_zone_name
  virtual_network_id        = var.virtual_network_id
  registration_enabled      = false
  tags                      = merge(tomap({ "module_version" = "1.0.0", "type" = "PrivateDNSzoneLink" }), var.tags)
}