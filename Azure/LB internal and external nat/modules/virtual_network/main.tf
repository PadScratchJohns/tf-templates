resource "azurerm_virtual_network" "virtual_network" {

  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"], subnet # ignore subsequent changes by the subnet module
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  location            = var.location

  bgp_community = var.bgp_community != null ? "12076:${var.bgp_community}" : null # TODO: does bgp_community support multiple values? if so, need to adjust to dynamic

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan.id == tostring(null) ? [] : var.ddos_protection_plan[*]
    content {
      id     = ddos_protection_plan.value["ddos_protection_plan_id"]
      enable = try(ddos_protection_plan.value["ddos_protection_plan_enabled"] == null ? true : ddos_protection_plan.value["ddos_protection_plan_enabled"], true)
    }
  }

  dns_servers             = var.dns_servers
  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = try(var.flow_timeout_in_minutes != null ? try(var.flow_timeout_in_minutes <= 4 ? 4 : try(var.flow_timeout_in_minutes >= 30 ? 30 : var.flow_timeout_in_minutes), var.flow_timeout_in_minutes) : null)

  subnet = [] # create empty array by default, set subnet configuration with subnet terraform module, not inline

  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "VirtualNetwork" }), var.tags)
}