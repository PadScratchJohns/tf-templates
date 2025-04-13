variable "virtual_network_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+-vnet$", var.virtual_network_name))
    error_message = "The virtual_network_name value must match the regex expression '[a-z0-9-_]+-vnet$' (e.g. cringey-customer-name-vnet)"
  }
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+_rg$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[a-z0-9-_]+_rg$' (e.g. cringey-customer-name_rg)"
  }
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network. You can supply more than one address space."

  validation {
    condition = length([
      for address in var.address_space : true
      if can(regex("([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})/[1-32]", address))
    ]) == length(var.address_space)
    error_message = "Each IP Address in the address_space value must be in the CIDR format e.g. (8.8.8.8/32)."
  }
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "bgp_community" {
  type        = number
  description = "The BGP community attribute in format <as-number>:<community-value>."
  default     = null

  validation {
    condition     = (can(regex("[0-9]{4,5}", var.bgp_community)) || try(var.bgp_community == null ? true : false, false))
    error_message = "The bgp_community value must be a 4-5 digit integer. It's automatically prefixed with '12076:'."
  }
}

variable "ddos_protection_plan" {
  type = object({
    id     = optional(string)
    enable = optional(bool)
  })
  description = "A ddos_protection_plan block as documented above."
  default     = {}

  validation {
    condition = length([
      for ddos_protection_plan in var.ddos_protection_plan : true
      if can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft.Network/ddosProtectionPlans/[a-z0-9-_]+$", ddos_protection_plan.ddos_protection_plan_id))
    ]) == length(var.ddos_protection_plan) || try((var.ddos_protection_plan.id) == null ? true : false, false)
    error_message = "The ddos_protection_plan_id value must be the Azure Resource UID format, e.g. '/subscriptions/your-sub-id-here/resourceGroups/cringey-customer-name_rg/providers/Microsoft.Network/ddosProtectionPlans/cringey-customer-name-ddos'."
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
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
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = null

  validation {
    condition     = (can(regex("[0-9]{1,2}", var.flow_timeout_in_minutes)) || try(var.flow_timeout_in_minutes == null ? true : false, false))
    error_message = "The flow_timeout_in_minutes value must be a 1-2 digit integer that'll automatically be set between 4 and 30 if outside of that range."
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}