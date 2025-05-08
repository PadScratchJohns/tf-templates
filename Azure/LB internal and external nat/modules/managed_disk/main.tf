resource "azurerm_managed_disk" "managed_disk" {
  lifecycle {
    ignore_changes = [
      tags["CreatedOnDate"], tags["ReviewDate"]
    ]
    prevent_destroy = true # https://github.com/hashicorp/terraform/issues/27360
  }

  name                   = var.managed_disk_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  storage_account_type   = var.storage_account_type
  create_option          = var.create_option
  disk_size_gb           = var.disk_size_gb 
  zone                   = var.zone
  tags                   = merge(tomap({ "module_version" = "0.0.1", "type" = "ManagedDisk" }), var.tags)

# The rest are default
  disk_encryption_set_id = var.secure_vm_disk_encryption_set_id == null ? var.disk_encryption_set_id : null
  disk_iops_read_write = contains(["PremiumV2_LRS", "UltraSSD_LRS"], var.storage_account_type) ? var.disk_iops_read_write : null
  disk_mbps_read_write = contains(["PremiumV2_LRS", "UltraSSD_LRS"], var.storage_account_type) ? var.disk_mbps_read_write : null
  disk_iops_read_only  = contains(["PremiumV2_LRS", "UltraSSD_LRS"], var.storage_account_type) ? var.disk_iops_read_only : null
  disk_mbps_read_only  = contains(["PremiumV2_LRS", "UltraSSD_LRS"], var.storage_account_type) ? var.disk_mbps_read_only : null
  upload_size_bytes    = var.create_option == "Upload" ? var.upload_size_bytes : null
  edge_zone = var.edge_zone

  dynamic "encryption_settings" {
    for_each = var.encryption_settings[*]
    content {
      dynamic "disk_encryption_key" {
        for_each = encryption_settings.value["disk_encryption_key"] == null ? {} : encryption_settings.value["disk_encryption_key"]

        content {
          secret_url      = disk_encryption_key.value["secret_url"]
          source_vault_id = disk_encryption_key.value["source_vault_id"]
        }
      }

      dynamic "key_encryption_key" {
        for_each = encryption_settings.value["key_encryption_key"] == null ? {} : encryption_settings.value["key_encryption_key"]

        content {
          key_url         = key_encryption_key.value["key_url"]
          source_vault_id = key_encryption_key.value["source_vault_id"]
        }
      }
    }
  }
  hyper_v_generation               = var.create_option == "ImportSecure" ? "V2" : (contains(["Import", "Copy"], var.create_option) ? var.hyper_v_generation : null)
  image_reference_id               = (var.create_option == "FromImage" && var.gallery_image_reference_id == null) ? var.image_reference_id : null
  gallery_image_reference_id       = (var.create_option == "FromImage" && var.image_reference_id == null) ? var.gallery_image_reference_id : null
  logical_sector_size              = contains(["UltraSSD_LRS", "PremiumV2_LRS"], var.storage_account_type) ? var.logical_sector_size : null
  os_type                          = contains(["Import", "ImportSecure", "Copy"], var.create_option) ? var.os_type : null
  source_resource_id               = var.create_option == "Copy" ? var.source_resource_id : null
  source_uri                       = contains(["Import", "ImportSecure"], var.create_option) ? var.source_uri : null
  storage_account_id               = contains(["Import", "ImportSecure"], var.create_option) ? var.storage_account_id : null
  tier                             = startswith("Premium", var.storage_account_type) ? var.tier : null
  max_shares                       = var.max_shares #TODO: add logic for Premium SSD maxShares limit: P15 and P20 disks: 2. P30,P40,P50 disks: 5. P60,P70,P80 disks: 10. For ultra disks the max_shares minimum value is 1 and the maximum is 5.
  trusted_launch_enabled           = contains(["FromImage", "Import"], var.create_option) ? var.trusted_launch_enabled : null
  security_type                    = var.trusted_launch_enabled == true ? var.security_type : null
  secure_vm_disk_encryption_set_id = var.security_type == "ConfidentialVM_DiskEncryptedWithCustomerKey" ? (var.disk_encryption_set_id == null ? var.secure_vm_disk_encryption_set_id : null) : null
  on_demand_bursting_enabled       = var.on_demand_bursting_enabled
  network_access_policy         = var.network_access_policy
  disk_access_id                = var.network_access_policy == "AllowedPrivate" ? var.disk_access_id : null
  public_network_access_enabled = var.public_network_access_enabled
}
