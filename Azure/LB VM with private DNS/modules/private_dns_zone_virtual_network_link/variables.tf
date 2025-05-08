variable "private_dns_zone_virtual_network_link_name" {
  type        = string
  description = "The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^([\\S]+\\.[\\S]+){1,}$", var.private_dns_zone_virtual_network_link_name))
    error_message = "The private_dns_zone_virtual_network_link_name value must match the regex expression '^([\\S]+\\.[\\S]+){1,}$' (e.g. maxcontactsolutions.com)."
  }
}

variable "private_dns_zone_name" {
  type        = string
  description = "The name of the Private DNS zone (without a terminating dot). Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^([\\S]+\\.[\\S]+){1,}$", var.private_dns_zone_name))
    error_message = "The private_dns_zone_name value must match the regex expression '^([\\S]+\\.[\\S]+){1,}$' (e.g. maxcontactsolutions.com)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."

}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
  default     = null

}

variable "registration_enabled" {
  type        = bool
  description = "Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}

  validation {
    condition     = can(var.tags.Customer)
    error_message = "The tags must contain a key/pair defining the Customer of the resource."
  }
}