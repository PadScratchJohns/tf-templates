resource "azurerm_lb_rule" "load_balancer_rule" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                           = var.load_balancer_rule_name
  loadbalancer_id                = var.load_balancer_id
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  protocol                       = var.protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  backend_address_pool_ids       = var.backend_address_pool_ids
  probe_id                       = var.probe_id
  enable_floating_ip             = var.enable_floating_ip
  idle_timeout_in_minutes        = var.idle_timeout_in_minutes
  load_distribution              = var.load_distribution
  disable_outbound_snat          = var.disable_outbound_snat
  enable_tcp_reset               = var.enable_tcp_reset
}