resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                      = var.vnet_peering_name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.virtual_network_name
  remote_virtual_network_id = var.remote_virtual_network_id
}