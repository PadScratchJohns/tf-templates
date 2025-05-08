resource "azurerm_network_interface" "network_interface" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers                   = var.dns_servers
  edge_zone                     = var.edge_zone
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  internal_dns_name_label       = var.internal_dns_name_label
  dynamic "ip_configuration" {
    for_each = var.ip_configuration[*]

    content {
      name                                               = ip_configuration.value["name"]
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value["gateway_load_balancer_frontend_ip_configuration_id"]
      subnet_id                                          = ip_configuration.value["subnet_id"]
      private_ip_address_version                         = ip_configuration.value["private_ip_address_version"]
      private_ip_address_allocation                      = ip_configuration.value["private_ip_address_allocation"]
      public_ip_address_id                               = ip_configuration.value["public_ip_address_id"]
      primary                                            = var.ip_configuration[0].name == ip_configuration.value["name"] ? true : false #each.index isn't available so compare this way
      private_ip_address                                 = ip_configuration.value["private_ip_address"]
    }

  }


  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "NetworkInterface" }), var.tags)

}

