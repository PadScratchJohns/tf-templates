resource "azurerm_availability_set" "availability_set" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                         = var.availability_set_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_update_domain_count = var.platform_update_domain_count
  platform_fault_domain_count  = var.platform_fault_domain_count
  proximity_placement_group_id = var.proximity_placement_group_id
  managed                      = var.managed
  tags                         = merge(tomap({ "module_version" = "1.0.0", "type" = "AvailabilitySet" }), var.tags)
}