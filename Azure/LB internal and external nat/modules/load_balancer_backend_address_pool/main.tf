resource "azurerm_lb_backend_address_pool" "load_balancer_backend_address_pool" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name               = var.load_balancer_backend_address_pool_name
  loadbalancer_id    = var.load_balancer_id
  virtual_network_id = var.virtual_network_id

  dynamic "tunnel_interface" {
    for_each = var.tunnel_interface[*]

    content {
      identifier = each.value["identifier"]
      type       = each.value["type"]
      protocol   = each.value["protocol"]
      port       = each.value["port"]
    }
  }
}