variable "ip_configuration" {
  type = list(object({
    name                                               = string
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    subnet_id                                          = optional(string)
    private_ip_address_version                         = optional(string)
    private_ip_address_allocation                      = string
    public_ip_address_id                               = optional(string)
    primary                                            = optional(string)
    private_ip_address                                 = optional(string)
  }))
  description = "An ip_configuration block as defined above."
  #   validation { #TODO
  #   }
}

variable "location" {
  description = "The location where the Network Interface should exist. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "name" {
  description = "The name of the Network Interface. Changing this forces a new resource to be created."
  type        = string
  default     = null

  validation {
    condition     = can(regex("[a-z0-9-_]+-nic$", var.name))
    error_message = "The network_interface value must match the regex expression '[a-z0-9-_]+-nic$' (e.g. cringey-customer-name-nic)"
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+_rg$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[a-z0-9-_]+_rg$' (e.g. cringey-customer-name_rg)"
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface."
  default     = []

  validation {
    condition = length([
      for dns_server in var.dns_servers : true
      if can(regex("([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})", dns_server))
    ]) == length(var.dns_servers)
    error_message = "Each IP Address in the dns_servers value must be in the non-CIDR format e.g. '8.8.8.8'."
  }
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created"
  default     = null

  #   validation { #TODO
  #   }

}

variable "enable_ip_forwarding" {
  type        = bool
  description = "Should IP Forwarding be enabled? Defaults to false."
  default     = false
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "Should Accelerated Networking be enabled? Defaults to false. Only certain Virtual Machine sizes are supported for Accelerated Networking https://docs.microsoft.com/azure/virtual-network/create-vm-accelerated-networking-cli"
  default     = false
}

variable "internal_dns_name_label" {
  type        = string
  description = "The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
  default     = null

  #   validation { #TODO
  #   }

}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}