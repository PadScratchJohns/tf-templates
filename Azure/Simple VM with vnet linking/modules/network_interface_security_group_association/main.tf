resource "azurerm_network_interface_security_group_association" "network_interface_security_group_association" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }
  
  network_interface_id        = var.network_interface_id
  network_security_group_id   = var.network_security_group_id
}