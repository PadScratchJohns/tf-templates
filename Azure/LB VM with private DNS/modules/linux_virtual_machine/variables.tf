variable "location" {
  type        = string
  description = "The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}
variable "environment" {
  type        = string
  description = "Environment defined in tfvars - mainly for magical purposes - aka DNS"

  validation {
    condition     = contains(["dev", "uat", "prd"], var.environment)
    error_message = "The environment value must be one of: 'dev', 'uat', 'prd'."
  }
}
variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9\\._]+$", var.admin_username))
    error_message = "The admin_username value must match the regex expression '[a-z0-9\\._]+$' (e.g. max)."
  }
}
variable "admin_password" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
  sensitive   = true

  validation {
    condition     = can(regex("[\\S]+$", var.admin_password)) || var.admin_password == null
    error_message = "The admin_password value must match the regex expression '[\\S]+$' (e.g. 1Q^kl7m311$n)"
  }
}
variable "computer_name" {
  type        = string
  description = "Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = can(regex("[a-z0-9_-]+$", var.computer_name)) || var.computer_name == null
    error_message = "The computer_name value must match the regex expression '[a-z0-9_-]+$' (e.g. dkcc-mvm)."
  }
}

variable "linux_virtual_machine_name" {
  type        = string
  description = "The name of the Linux Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9-_]+$", var.linux_virtual_machine_name))
    error_message = "The linux_virtual_machine_name value must match the regex expression '[a-z0-9-_]+$' (e.g. dkcc-mvm)."
  }
}

variable "network_interface_ids" {
  type        = list(string)
  description = "A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine."

#  validation {
#    condition = length([
#      for network_interface_id in var.network_interface_ids : true
#      if can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft.Network/networkInterfaces/[a-z0-9-_]+-Nic$", network_interface_id))
#    ]) == length(var.network_interface_ids) || try((var.network_interface_ids) == null ? true : false, false)
#    error_message = "The network_interface_ids value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/networkInterfaces/dkcc-mvm-Nic'."
#  }
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created."

}
variable "size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
  default     = "Standard_B2ms"

  #   validation { #TODO
  #   }
}
variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    diff_disk_settings = optional(object({
      option    = optional(string)
      placement = optional(string)
    }))
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool)
  })
  description = "An os_disk block as defined above."

  #   validation { #TODO
  #   }
}

variable "additional_capabilities" {
  type = object({
    ultra_ssd_enabled = optional(string)
  })
  description = "An additional_capabilities block as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "admin_ssh_key" {
  type = object({
    public_key = optional(string)
    username   = optional(string)
  })
  description = "One or more admin_ssh_keys blocks as defined above."

  #   validation { #TODO
  #   }
}

variable "allow_extension_operations" {
  type        = bool
  description = "Should Extension Operations be allowed on this Virtual Machine? Defaults to true."
  default     = true
}

variable "availability_set_id" {
  type        = string
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/availabilitySets/[a-z0-9-_]+$", var.availability_set_id)) || var.availability_set_id == null
    error_message = "The availability_set_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/availabilitySets/aaaaaaaaaaaa'."
  }
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = optional(string)
  })
  description = "A boot_diagnostics block as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "capacity_reservation_group_id" {
  type        = string
  description = "Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/capacityReservationGroups/[a-z0-9-_]+$", var.capacity_reservation_group_id)) || var.capacity_reservation_group_id == null
    error_message = "The capacity_reservation_group_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/capacityReservationGroups/aaaaaaaaaaaa'."
  }
}



variable "custom_data" {
  type        = string
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = can(regex("[\\S\\s]+$", var.custom_data)) || var.custom_data == null
    error_message = "The custom_data value must match the regex expression '[\\S\\s]+$' (e.g. IkhlbGxvLCB3b3JsZC4gSGVsbG8sIHdvcmxkLiBIZWxsbywgd29ybGQuIg==)"
  }
}

variable "dedicated_host_id" {
  type        = string
  description = "The ID of a Dedicated Host where this machine should be run on. Conflicts with dedicated_host_group_id."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/hostGroups/[a-z0-9-_]+/hosts/[a-z0-9-_]+$", var.dedicated_host_id)) || var.dedicated_host_id == null
    error_message = "The dedicated_host_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/hostGroups/aaaaaaaaaaaa/hosts/aaaaaa'."
  }
}

variable "dedicated_host_group_id" {
  type        = string
  description = "The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with dedicated_host_id."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/hostGroups/[a-z0-9-_]+$", var.dedicated_host_group_id)) || var.dedicated_host_group_id == null
    error_message = "The dedicated_host_group_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/hostGroups/aaaaaaaaaaaa'."
  }
}

variable "disable_password_authentication" {
  type        = bool
  description = "Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = true
}

variable "eviction_policy" {
  type        = string
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = try(contains(["Deallocate", "Delete"], var.eviction_policy) || var.eviction_policy == null, true)
    error_message = "The eviction_policy value must be one of: 'Deallocate', 'Delete'."
  }
}

variable "extensions_time_budget" {
  type        = string
  description = "Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (PT1H30M)."
  default     = "PT1H30M"

  #   validation { #TODO
  #   }  
}

variable "gallery_application" {
  type = object({
    version_id             = optional(string)
    configuration_blob_uri = optional(string)
    order                  = optional(number)
    tag                    = optional(string)
  })
  description = "One or more gallery_application blocks as defined above."
  default     = null

  #   validation { #TODO
  #   }  
}

variable "identity" {
  type = object({
    type         = optional(string)
    identity_ids = optional(list(string))
  })
  description = "An identity block as defined above."
  default     = null

  #   validation { #TODO
  #   }   
}

variable "patch_assessment_mode" {
  type        = string
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault."
  default     = "ImageDefault"

  validation {
    condition     = contains(["AutomaticByPlatform", "ImageDefault"], var.patch_assessment_mode)
    error_message = "The patch_assessment_mode value must be one of: 'AutomaticByPlatform', 'ImageDefault'."
  }
}

variable "patch_mode" {
  type        = string
  description = "Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. For more information on patch modes please see https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes."
  default     = "ImageDefault"

  validation {
    condition     = contains(["AutomaticByPlatform", "ImageDefault"], var.patch_mode)
    error_message = "The patch_mode value must be one of: 'AutomaticByPlatform', 'ImageDefault'."
  }
}

variable "max_bid_price" {
  type        = string
  description = "The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons."
  default     = "-1"

  #   validation { #TODO
  #   } 
}

variable "plan" {
  type = object({
    name      = optional(string)
    product   = optional(string)
    publisher = optional(string)
  })
  description = "A plan block as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "platform_fault_domain" {
  type        = string
  description = "Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "priority" {
  type        = string
  description = "Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  default     = "Regular"

  validation {
    condition     = contains(["Regular", "Spot"], var.priority)
    error_message = "The priority value must be one of: 'Regular', 'Spot'."
  }
}

variable "provision_vm_agent" {
  type        = bool
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "proximity_placement_group_id" {
  type        = string
  description = "The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/proximityPlacementGroups/[a-z0-9-_]+$", var.proximity_placement_group_id)) || var.proximity_placement_group_id == null
    error_message = "The proximity_placement_group_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/proximityPlacementGroups/aaaaaaaaaaaa'."
  }
}

variable "secret" {
  type = object({
    certificate = optional(object({
      url = optional(string)
    }))
    key_vault_id = optional(string)
  })
  description = "One or more secret blocks as defined above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "secure_boot_enabled" {
  type        = bool
  description = "Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = true
}

variable "source_image_id" {
  type        = string
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include Image IDs, Shared Image IDs, Shared Image Version IDs, Community Gallery Image IDs, Community Gallery Image Version IDs, Shared Gallery Image IDs and Shared Gallery Image Version IDs."
  default     = null

  #   validation { #TODO
  #   }
}

variable "source_image_reference" {
  type = object({
    publisher = optional(string)
    offer     = optional(string)
    sku       = optional(string)
    version   = optional(string)
  })
  description = "A source_image_reference block as defined above."

  #   validation { #TODO
  #   }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags which should be assigned to this Virtual Machine."
  default     = {}
}

variable "termination_notification" {
  type = object({
    enabled = optional(bool)
    timeout = optional(number)
  })
  default = null

  #   validation { #TODO
  #   } 
}

variable "user_data" {
  type        = string
  description = "The Base64-Encoded User Data which should be used for this Virtual Machine."
  default     = null

  validation {
    condition     = can(regex("[\\S]+$", var.user_data)) || var.user_data == null
    error_message = "The user_data value must match the regex expression '[\\S]+$' (e.g. IkhlbGxvLCB3b3JsZC4gSGVsbG8sIHdvcmxkLiBIZWxsbywgd29ybGQuIg==)"
  }
}

variable "vtpm_enabled" {
  type        = bool
  description = "Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

variable "virtual_machine_scale_set_id" {
  type        = string
  description = "Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Compute/virtualMachineScaleSets/[a-z0-9-_]+$", var.virtual_machine_scale_set_id)) || var.virtual_machine_scale_set_id == null
    error_message = "The virtual_machine_scale_set_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Compute/virtualMachineScaleSets/aaaaaaaaaaaa'."
  }
}


variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this Managed Disk should be located. Changing this property forces a new resource to be created."
  default     = null

  # validation { # TODO
  # } 
}
# Vars that can be on some VM's but not others - default NULL
variable "moniker" {
  type        = string
  description = "Not used, but here for posterity if needed"
  default     = null
}
variable "saltmasterip" {
  type        = string
  description = "For the orchastration automation master - which is SaltStack"
  default     = null
}
variable "vnet_split" {
  type        = string
  default     = null
}
variable "peered_vnet_split" {
  type        = string
  description = "as this is in a var in user_data it needs to be a non null value"
}
variable "cli_id" {
  description = "as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
}
variable "ten_id" {
  description = "as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
}
variable "sec_id" {
  description = "as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
  sensitive   = true

  validation {
  condition     = can(regex("[\\S]+$", var.sec_id)) || var.sec_id == null
  error_message = "The sec_id value must match the regex expression '[\\S]+$' (e.g. 1Q^kl7m311$n)"
  }
}
variable "accountname" {
  description = "Storage account name for use as a variable - Normally used for SIPREC storage, as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
}
variable "containername" {
  description = "Container name for use as a variable - Normally used for SIPREC storage, as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
}
variable "pospassword" {
  description = "Postgres password for use as a variable in user_data, as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
  sensitive   = true
}
variable "reppassword" {
  description = "Rep user password for use as a variable in user_data, as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
  sensitive   = true
}
variable "bacpassword" {
  description = "Backup_user password for use as a variable in user_data, as this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
  sensitive   = true
}
variable "saltrepokey" {
  description = "repo key, currently it gets mangled in the pipeline... As this is in a var in user_data it needs to be a non null value"
  default     = "notanullvalue"
  sensitive   = true
}