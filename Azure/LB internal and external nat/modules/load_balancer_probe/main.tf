resource "azurerm_lb_probe" "load_balancer_probe" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.load_balancer_probe_name
  loadbalancer_id     = var.load_balancer_id
  protocol            = var.protocol
  port                = var.port
  probe_threshold     = var.probe_threshold
  request_path        = contains(["Http", "Https"], var.protocol) ? var.request_path : null
  interval_in_seconds = var.interval_in_seconds
  number_of_probes    = (var.number_of_probes * var.interval_in_seconds) < 10 ? 10 : var.number_of_probes

}