resource "azurerm_lb" "load_balancer" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]

    prevent_destroy = false # https://github.com/hashicorp/terraform/issues/27360

  }
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
  location            = var.location

  edge_zone = var.edge_zone

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration[*]

    content {
      name                                               = frontend_ip_configuration.value["name"]
      zones                                              = frontend_ip_configuration.value["zones"]
      subnet_id                                          = frontend_ip_configuration.value["subnet_id"]
      gateway_load_balancer_frontend_ip_configuration_id = frontend_ip_configuration.value["gateway_load_balancer_frontend_ip_configuration_id"]
      private_ip_address                                 = frontend_ip_configuration.value["private_ip_address"]
      private_ip_address_allocation                      = frontend_ip_configuration.value["private_ip_address_allocation"]
      private_ip_address_version                         = frontend_ip_configuration.value["private_ip_address_version"]
      public_ip_address_id                               = frontend_ip_configuration.value["public_ip_address_id"]
      public_ip_prefix_id                                = frontend_ip_configuration.value["public_ip_prefix_id"]
    }
  }

  # The Microsoft.Network/AllowGatewayLoadBalancer feature is required to be registered in order to use the Gateway SKU. The feature can only be registered by the Azure service team, please submit an Azure support ticket for that.
  # TODO: can we data source features and do conditional?
  sku      = var.sku
  sku_tier = var.sku_tier
  tags     = merge(tomap({ "module_version" = "0.0.1", "type" = "LoadBalancer" }), var.tags)
}