resource "azurerm_storage_account_network_rules" "storage_network_rules" {

  storage_account_id         = var.storage_account_id
  #resource_group_name        = var.resource_group_name
  #storage_account_name       = var.storage_account_name
  default_action             = var.default_action
  bypass                     = var.bypass
  ip_rules                   = var.ip_rules
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  dynamic "private_link_access" {
    for_each = var.private_link_access == null ? [] : var.private_link_access[*]

    content {
      endpoint_resource_id = private_link_access.value["endpoint_resource_id"]
      endpoint_tenant_id   = private_link_access.value["endpoint_tenant_id"]
    }
  }
}


