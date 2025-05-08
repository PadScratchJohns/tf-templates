resource "azurerm_network_security_rule" "network_security_rule" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                                       = var.network_security_rule_name
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = var.network_security_group_name
  description                                = var.description
  protocol                                   = var.protocol
  source_port_range                          = var.source_port_ranges == null ? var.source_port_range : null
  source_port_ranges                         = var.source_port_range == null ? var.source_port_ranges : null
  destination_port_range                     = var.destination_port_ranges == null ? var.destination_port_range : null
  destination_port_ranges                    = var.destination_port_range == null ? var.destination_port_ranges : null
  source_address_prefix                      = var.source_address_prefixes == null ? var.source_address_prefix : null
  source_address_prefixes                    = var.source_address_prefix == null ? var.source_address_prefixes : null
  source_application_security_group_ids      = var.source_application_security_group_ids
  destination_address_prefix                 = var.destination_address_prefixes == null ? var.destination_address_prefix : null
  destination_address_prefixes               = var.destination_address_prefix == null ? var.destination_address_prefixes : null
  destination_application_security_group_ids = var.destination_application_security_group_ids
  access                                     = var.access
  priority                                   = var.priority
  direction                                  = var.direction
}