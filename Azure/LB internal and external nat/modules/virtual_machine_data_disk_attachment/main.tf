resource "azurerm_virtual_machine_data_disk_attachment" "virtual_machine_data_disk_attachment" {
  lifecycle {
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  virtual_machine_id        = var.virtual_machine_id
  managed_disk_id           = var.managed_disk_id
  lun                       = var.lun
  caching                   = var.caching
  create_option             = var.create_option
  write_accelerator_enabled = var.write_accelerator_enabled

}