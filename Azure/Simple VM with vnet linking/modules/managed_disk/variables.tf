variable "managed_disk_name" {
  type        = string
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9-_]+$", var.managed_disk_name))
    error_message = "The managed_disk_name value must match the regex expression '[a-z0-9-_]+$' (e.g. cringey-customer-name-osdisk1)"
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Managed Disk should exist. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+(_rg|$)$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. cringey-customer-name_rg)"
  }
}

variable "location" {
  type        = string
  description = "Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "storage_account_type" {
  type        = string
  description = "The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS."

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "StandardSSD_LRS", "UltraSSD_LRS"], var.storage_account_type)
    error_message = "The storage_account_type value must be one of: 'Standard_LRS', 'StandardSSD_ZRS', 'Premium_LRS', 'PremiumV2_LRS', 'Premium_ZRS', 'StandardSSD_LRS', 'UltraSSD_LRS'."
  }
}

variable "create_option" {
  type        = string
  description = "The method to use when creating the managed disk. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["Import", "ImportSecure", "Empty", "Copy", "FromImage", "Restore", "Upload"], var.create_option)
    error_message = "The storage_account_type value must be one of: 'Import', 'ImportSecure', 'Empty', 'Copy', 'FromImage', 'Restore', 'Upload'."
  }
}

variable "disk_encryption_set_id" {
  type        = string
  description = "The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. Conflicts with secure_vm_disk_encryption_set_id."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft.Compute/diskEncryptionSets/[a-z0-9-_]+$", var.disk_encryption_set_id)) || var.disk_encryption_set_id == null
    error_message = "The disk_encryption_set_id value must be the Azure Resource UID format, e.g. '/subscriptions/your-sub-id-here/resourceGroups/cringey-customer-name_rg/providers/Microsoft.Compute/diskEncryptionSets/cringey-customer-nameencryptionset'."
  }
}

variable "disk_iops_read_write" {
  type        = number
  description = "The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes."
  default     = null

  validation {
    condition     = try(var.disk_iops_read_write >= 4 && var.disk_iops_read_write <= 256 || var.disk_iops_read_write == null, true)
    error_message = "The disk_iops_read_write value must be between 4 and 256, or null."
  }
}

variable "disk_mbps_read_write" {
  type        = number
  description = "The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second."
  default     = null

  # validation { # TODO
  # }
}

variable "disk_iops_read_only" {
  type        = number
  description = "The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes."
  default     = null

  validation {
    condition     = try(var.disk_iops_read_only >= 4 && var.disk_iops_read_only <= 256 || var.disk_iops_read_only == null, true)
    error_message = "The disk_iops_read_only value must be between 4 and 256, or null."
  }
}

variable "disk_mbps_read_only" {
  type        = number
  description = "The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second."
  default     = null

  # validation { # TODO
  # }
}

variable "upload_size_bytes" {
  type        = number
  description = "Specifies the size of the managed disk to create in bytes. Required when create_option is Upload. The value must be equal to the source disk to be copied in bytes. Source disk size could be calculated with ls -l or wc -c. More information can be found at https://learn.microsoft.com/en-us/azure/virtual-machines/linux/disks-upload-vhd-to-managed-disk-cli#copy-a-managed-disk. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # }
}

variable "disk_size_gb" {
  type        = number
  description = "Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased."

  # validation { # TODO
  # }
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Managed Disk should exist. Changing this forces a new Managed Disk to be created."
  default     = null

  # validation { # TODO
  # }
}

variable "encryption_settings" {
  type = object({
    disk_encryption_key = optional(object({
      secret_url      = optional(string)
      source_vault_id = optional(string)
    }))
    key_encryption_key = optional(object({
      secret_url      = optional(string)
      source_vault_id = optional(string)
    }))
  })
  description = "A encryption_settings block as defined above."
  default     = null

  # validation { # TODO
  # }
}

variable "hyper_v_generation" {
  type        = string
  description = "The HyperV Generation of the Disk when the source of an Import or Copy operation targets a source that contains an operating system. Possible values are V1 and V2. For ImportSecure it must be set to V2. Changing this forces a new resource to be created."
  default     = ""

  validation {
    condition     = contains(["V1", "V2"], var.hyper_v_generation) || var.hyper_v_generation == ""
    error_message = "The hyper_v_generation value must be one of: 'V1', 'V2' or an empty string."
  }
}

variable "image_reference_id" {
  type        = string
  description = "ID of an existing platform/marketplace disk image to copy when create_option is FromImage. This field cannot be specified if gallery_image_reference_id is specified. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "gallery_image_reference_id" {
  type        = string
  description = "ID of a Gallery Image Version to copy when create_option is FromImage. This field cannot be specified if image_reference_id is specified. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "logical_sector_size" {
  type        = number
  description = "Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = try(contains([4096, 512], var.logical_sector_size) || var.logical_sector_size == null, true)
    error_message = "The logical_sector_size value must be one of: '4096', '512' or null."
  }
}

variable "os_type" {
  type        = string
  description = "Specify a value when the source of an Import, ImportSecure or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows."
  default     = ""

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type) || var.os_type == ""
    error_message = "The os_type value must be one of: 'Linux', 'Windows' or an empty string."
  }
}

variable "source_resource_id" {
  type        = string
  description = "The ID of an existing Managed Disk or Snapshot to copy when create_option is Copy or the recovery point to restore when create_option is Restore. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "source_uri" {
  type        = string
  description = "URI to a valid VHD file to be used when create_option is Import or ImportSecure. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "storage_account_id" {
  type        = string
  description = "The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import or ImportSecure. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "tier" {
  type        = string
  description = "The disk performance tier to use. Possible values are documented https://docs.microsoft.com/azure/virtual-machines/disks-change-performance. This feature is currently supported only for premium SSDs."
  default     = ""

  validation {
    condition     = contains(["P1", "P2", "P3", "P4", "P6", "P10", "P15", "P20", "P30", "P40", "P50", "P60", "P70", "P80"], var.tier) || var.tier == ""
    error_message = "The tier value must be one of: 'P1', 'P2', 'P3', 'P4', 'P6', 'P10', 'P15', 'P20', 'P30', 'P40', 'P50', 'P60', 'P70', 'P80' or an empty string."
  }
}

variable "max_shares" {
  type        = number
  description = "The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time."
  default     = null

  # validation { # TODO
  # } 
}

variable "trusted_launch_enabled" {
  type        = bool
  description = "Specifies if Trusted Launch is enabled for the Managed Disk. Changing this forces a new resource to be created."
  default     = null
}

variable "security_type" {
  type        = string
  description = "Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey, ConfidentialVM_DiskEncryptedWithPlatformKey and ConfidentialVM_DiskEncryptedWithCustomerKey. Changing this forces a new resource to be created."
  default     = ""

  validation {
    condition     = contains(["ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey", "ConfidentialVM_DiskEncryptedWithPlatformKey", "ConfidentialVM_DiskEncryptedWithCustomerKey"], var.security_type) || var.security_type == ""
    error_message = "The security_type value must be one of: 'ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey', 'ConfidentialVM_DiskEncryptedWithPlatformKey', 'ConfidentialVM_DiskEncryptedWithCustomerKey' or an empty string."
  }
}

variable "secure_vm_disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with disk_encryption_set_id. Changing this forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "on_demand_bursting_enabled" {
  type        = bool
  description = "Specifies if On-Demand Bursting is enabled for the Managed Disk."
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this Managed Disk should be located. Changing this property forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}

variable "network_access_policy" {
  type        = string
  description = "Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll."
  default     = "AllowAll"

  validation {
    condition     = contains(["AllowAll", "AllowPrivate", "DenyAll"], var.network_access_policy)
    error_message = "The network_access_policy value must be one of: 'AllowAll', 'AllowPrivate', 'DenyAll' or null."
  }
}

variable "disk_access_id" {
  type        = string
  description = "The ID of the disk access resource for using private endpoints on disks."
  default     = null

  # validation { # TODO
  # } 
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether it is allowed to access the disk via public network. Defaults to true."
  default     = true
}