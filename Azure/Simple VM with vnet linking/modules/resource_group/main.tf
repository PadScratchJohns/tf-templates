resource "azurerm_resource_group" "resource_group" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  location = var.location
  name     = var.resource_group_name
  tags     = merge(tomap({ "module_version" = "1.0.0", "type" = "ResourceGroup" }), var.tags)
}