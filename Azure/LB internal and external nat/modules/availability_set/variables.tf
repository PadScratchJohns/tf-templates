variable "availability_set_name" {
  type        = string
  description = "Specifies the name of the availability set. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9-_]+-av$", var.availability_set_name))
    error_message = "The availability_set_name value must match the regex expression '[a-z0-9-_]-av+$' (e.g. ukw-db-ha-mgmt-av)"
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the availability set. Changing this forces a new resource to be created."

}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "platform_update_domain_count" {
  type        = number
  description = "Specifies the number of update domains that are used. Defaults to 5. Changing this forces a new resource to be created."
  default     = 5

  validation {
    condition     = can(regex("[0-9]{1,}", var.platform_update_domain_count))
    error_message = "The platform_update_domain_count value must match the regex expression '[0-9]{1,}' (e.g. 5)"
  }
}

variable "platform_fault_domain_count" {
  type        = number
  description = "Specifies the number of fault domains that are used. Defaults to 3. Changing this forces a new resource to be created."
  default     = 3

  validation {
    condition     = can(regex("[0-9]{1,}", var.platform_fault_domain_count)) # TODO: add validation per region
    error_message = "The platform_fault_domain_count value must match the regex expression '[0-9]{1,}' (e.g. 3)"
  }
}

variable "proximity_placement_group_id" {
  type        = string
  description = "The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "managed" {
  type        = bool
  description = "Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic). Default is true. Changing this forces a new resource to be created."
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}

}