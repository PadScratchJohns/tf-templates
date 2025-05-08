resource "azurerm_network_interface_backend_address_pool_association" "load_balancer_backend_address_pool_association" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  network_interface_id                = var. network_interface_id
  ip_configuration_name               = var.ip_configuration_name 
  backend_address_pool_id             = var.backend_address_pool_id
}