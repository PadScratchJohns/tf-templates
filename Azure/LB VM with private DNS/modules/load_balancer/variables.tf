variable "load_balancer_name" {
  type        = string
  description = "Specifies the name of the Load Balancer. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9-_]+-lb$", var.load_balancer_name))
    error_message = "The load_balancer_name value must match the regex expression '[a-z0-9-_]+-lb$' (e.g. ne-db-ha-lb)"
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which to create the Load Balancer. Changing this forces a new resource to be created."

}

variable "location" {
  type        = string
  description = "Specifies the supported Azure Region where the Load Balancer should be created. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Load Balancer should exist. Changing this forces a new Load Balancer to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "frontend_ip_configuration" {
  type = object({
    name                                               = optional(string)
    zones                                              = optional(list(number))
    subnet_id                                          = optional(string)
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    private_ip_address                                 = optional(string)
    private_ip_address_allocation                      = optional(string)
    private_ip_address_version                         = optional(string)
    public_ip_address_id                               = optional(string)
    public_ip_prefix_id                                = optional(string)
  })
  description = "One or multiple frontend_ip_configuration blocks as documented above."
  default     = null

  #   validation { #TODO
  #   }
}

variable "sku" {
  type        = string
  description = "The SKU of the Azure Load Balancer. Accepted values are Basic, Standard and Gateway. Defaults to Basic. Changing this forces a new resource to be created."
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Gateway"], var.sku)
    error_message = "The sku value must be one of: 'Basic', 'Standard', 'Gateway'."
  }
}

variable "sku_tier" {
  type        = string
  description = "The SKU tier of this Load Balancer. Possible values are Global and Regional. Defaults to Regional. Changing this forces a new resource to be created."
  default     = "Regional"

  validation {
    condition     = contains(["Global", "Regional"], var.sku_tier)
    error_message = "The sku_tier value must be one of: 'Global', 'Regional'."
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}

}