resource "azurerm_public_ip" "public_ip" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    create_before_destroy = true # If this resource is to be associated with a resource that requires disassociation before destruction (such as azurerm_network_interface) it is recommended to set the lifecycle argument create_before_destroy = true. Otherwise, it can fail to disassociate on destruction.
    prevent_destroy       = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method

  # TODO: implement conditional logic to include regions that support zones: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
  zones                   = var.zones
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_mode == "Enabled" ? var.ddos_protection_plan_id : null
  domain_name_label       = var.domain_name_label
  edge_zone               = var.edge_zone
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  ip_tags                 = var.ddos_protection_mode == "Enabled" ? var.ip_tags : null
  ip_version              = var.ip_version
  public_ip_prefix_id     = var.public_ip_prefix_id
  reverse_fqdn            = var.reverse_fqdn
  sku                     = var.sku
  sku_tier                = var.sku_tier

  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "PublicIP" }), var.tags)

}