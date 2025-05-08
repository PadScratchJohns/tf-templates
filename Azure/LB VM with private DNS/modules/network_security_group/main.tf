resource "azurerm_network_security_group" "network_security_group" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"], security_rule # ignore subsequent changes by the network_security_rule module
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  # should be defined in network_security_rule module
  #security_rule = var.security_rule

  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "NetworkSecurityGroup" }), var.tags)

}