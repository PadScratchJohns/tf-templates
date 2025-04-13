variable "public_ip_name" {
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created."
  type        = string

  validation {
    condition     = can(regex("[a-z0-9-_]+-ip$", var.public_ip_name))
    error_message = "The public_ip_name value must match the regex expression '[a-z0-9-_]+-ip$' (e.g. cringey-customer-name-vm-ip)"
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created."
  type        = string

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+(_rg|$)$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. cringey-customer-name_rg)"
  }
}

variable "location" {
  description = "Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = contains(["eastus", "eastus2", "southcentralus", "westus2", "westus3", "australiaeast", "southeastasia", "northeurope", "swedencentral", "uksouth", "westeurope", "centralus", "southafricanorth", "centralindia", "eastasia", "japaneast", "koreacentral", "canadacentral", "francecentral", "germanywestcentral", "norwayeast", "switzerlandnorth", "uaenorth", "brazilsouth", "centraluseuap", "eastus2euap", "qatarcentral", "centralusstage", "eastusstage", "eastus2stage", "northcentralusstage", "southcentralusstage", "westusstage", "westus2stage", "asia", "asiapacific", "australia", "brazil", "canada", "europe", "france", "germany", "global", "india", "japan", "korea", "norway", "singapore", "southafrica", "switzerland", "uae", "uk", "unitedstates", "unitedstateseuap", "eastasiastage", "southeastasiastage", "brazilus", "eastusstg", "northcentralus", "westus", "jioindiawest", "devfabric", "westcentralus", "southafricawest", "australiacentral", "australiacentral2", "australiasoutheast", "japanwest", "jioindiacentral", "koreasouth", "southindia", "westindia", "canadaeast", "francesouth", "germanynorth", "norwaywest", "switzerlandwest", "ukwest", "uaecentral", "brazilsoutheast"], var.location)
    error_message = "The location value must be one of: 'eastus', 'eastus2', 'southcentralus', 'westus2', 'westus3', 'australiaeast', 'southeastasia', 'northeurope', 'swedencentral', 'uksouth', 'westeurope', 'centralus', 'southafricanorth', 'centralindia', 'eastasia', 'japaneast', 'koreacentral', 'canadacentral', 'francecentral', 'germanywestcentral', 'norwayeast', 'switzerlandnorth', 'uaenorth', 'brazilsouth', 'centraluseuap', 'eastus2euap', 'qatarcentral', 'centralusstage', 'eastusstage', 'eastus2stage', 'northcentralusstage', 'southcentralusstage', 'westusstage', 'westus2stage', 'asia', 'asiapacific', 'australia', 'brazil', 'canada', 'europe', 'france', 'germany', 'global', 'india', 'japan', 'korea', 'norway', 'singapore', 'southafrica', 'switzerland', 'uae', 'uk', 'unitedstates', 'unitedstateseuap', 'eastasiastage', 'southeastasiastage', 'brazilus', 'eastusstg', 'northcentralus', 'westus', 'jioindiawest', 'devfabric', 'westcentralus', 'southafricawest', 'australiacentral', 'australiacentral2', 'australiasoutheast', 'japanwest', 'jioindiacentral', 'koreasouth', 'southindia', 'westindia', 'canadaeast', 'francesouth', 'germanynorth', 'norwaywest', 'switzerlandwest', 'ukwest', 'uaecentral', 'brazilsoutheast'."
  }
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  type        = string

  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "The allocation_method value must be one of: 'Static', 'Dynamic'."
  }
}
variable "network_interface_name" {
  type        = string
  default     = null
}
variable "ip_configuration" {
  type        = string
  default     = null
}
variable "zones" {
  description = "A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  type        = list(string)
  default     = []

  #   validation { #TODO
  #   }
}

variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"

  validation {
    condition     = try(contains(["Disabled", "Enabled", "VirtualNetworkInherited"], var.ddos_protection_mode))
    error_message = "The ddos_protection_mode value must be one of: 'Disabled', 'Enabled', 'VirtualNetworkInherited'."
  }
}

variable "ddos_protection_plan_id" {
  type        = string
  description = "The ID of DDoS protection plan associated with the public IP."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[\\S]+/providers/Microsoft.Network/ddosProtectionPlans/[\\S]+", var.ddos_protection_plan_id)) || var.ddos_protection_plan_id == null
    error_message = "The ddos_protection_plan_id value must be in the resource UID format (e.g. '/subscriptions/your-sub-id-here/resourceGroups/rg1/providers/Microsoft.Network/serviceEndpointPolicies/testServiceEndpointPolicy')."
  }
}

variable "domain_name_label" {
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  type        = string
  default     = null

  #   validation { #TODO
  #   }
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created."
  type        = string
  default     = null

  #   validation { #TODO
  #   }
}

variable "idle_timeout_in_minutes" {
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = 4

  validation {
    condition     = (var.idle_timeout_in_minutes >= 4 || var.idle_timeout_in_minutes <= 30)
    error_message = "The idle_timeout_in_minutes value must be between 4 and 30 minutes, or null."
  }
}
variable "internal_dns_name_label" {
  description = "A mapping of IP tags to assign to the public IP. Changing this forces a new resource to be created."
  type        = string
  default     = null

  #   validation { #TODO
  #   }
}
variable "ip_tags" {
  description = "A mapping of IP tags to assign to the public IP. Changing this forces a new resource to be created."
  type        = map(string)
  default     = {}

  #   validation { #TODO
  #   }
}

variable "ip_version" {
  description = "The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created."
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "The ip_version value must be one of: 'IPv4', 'IPv6'."
  }
}

variable "public_ip_prefix_id" {
  type        = string
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[\\S]+/providers/Microsoft.Network/publicIPPrefixes/[\\S]+", var.public_ip_prefix_id)) || var.public_ip_prefix_id == null
    error_message = "The public_ip_prefix_id value must be in the resource UID format (e.g. '/subscriptions/your-sub-id-here/resourceGroups/rg1/providers/Microsoft.Network/publicIPPrefixes/test-ipprefix')."
  }
}

variable "reverse_fqdn" {
  description = "A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  type        = string
  default     = null

  #   validation { #TODO
  #   }
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "The sku value must be one of: 'Basic', 'Standard'."
  }
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional. Changing this forces a new resource to be created."
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "The sku_tier value must be one of: 'Regional', 'Global'."
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}