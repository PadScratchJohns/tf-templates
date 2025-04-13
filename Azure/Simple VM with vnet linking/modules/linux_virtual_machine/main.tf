resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  lifecycle {
    ignore_changes = [
      virtual_machine_scale_set_id, tags["CreatedOnDate"], tags["ReviewDate"]
    ]

    prevent_destroy = false # https://github.com/hashicorp/terraform/issues/27360

  }
  location              = var.location
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  computer_name         = var.computer_name
  disable_password_authentication = var.disable_password_authentication
  name                  = var.linux_virtual_machine_name
  network_interface_ids = var.network_interface_ids
  resource_group_name   = var.resource_group_name
  size                  = var.size
  dynamic "os_disk" {
    for_each = var.os_disk[*]

    content {
      caching              = os_disk.value["caching"]
      disk_size_gb         = os_disk.value["disk_size_gb"] 
      name                 = os_disk.value["name"]
      storage_account_type = os_disk.value["storage_account_type"]
    }
  }
  dynamic "identity" {
    for_each = var.identity[*]

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }
  dynamic "secret" {
    for_each = var.secret[*]
    content {

      dynamic "certificate" {
        for_each = secret.value.certificate[*]

        content {
          url = certificate.value.url
        }
      }

      key_vault_id = secret.value["key_vault_id"]

    }
  }
  secure_boot_enabled = var.secure_boot_enabled
  source_image_id     = var.source_image_id
  dynamic "source_image_reference" {
    for_each = var.source_image_reference[*]
    content {
      publisher = source_image_reference.value["publisher"]
      offer     = source_image_reference.value["offer"]
      sku       = source_image_reference.value["sku"]
      version   = source_image_reference.value["version"]
    }
  }
  tags = merge(tomap({ "module_version" = "0.0.1", "type" = "VirtualMachine" }), var.tags)
  dynamic "termination_notification" {
    for_each = var.termination_notification[*]
    content {
      enabled = termination_notification.value["enabled"]
      timeout = termination_notification.value["timeout"]
    }
  }
  user_data = base64encode(templatefile(var.user_data, {
      saltmasterip = var.saltmasterip
      dbpass       = var.dbpass
      vnet_split   = var.vnet_split
      peered_vnet_split = var.peered_vnet_split
  }))
  vtpm_enabled = var.vtpm_enabled
  # TODO: create azurerm_orchestrated_virtual-machine_scale_set module for below
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  zone                         = var.zone
}