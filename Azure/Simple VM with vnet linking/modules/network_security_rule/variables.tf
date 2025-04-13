variable "network_security_rule_name" {
  type        = string
  description = "The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[\\S]+$", var.network_security_rule_name))
    error_message = "The network_security_rule_name value must match the regex expression '[\\S]+$' (e.g. Office)"
  }
}
variable "network_security_group_name" {
  type        = string
  description = "The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[\\S]+$", var.network_security_group_name))
    error_message = "The network_security_group_name value must match the regex expression '[\\S]+$' (e.g. Office)"
  }
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created."
  type        = string

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+(_rg|$)$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. cringey-customer-name_rg)"
  }
}

variable "description" {
  type        = string
  description = "A description for this rule. Restricted to 140 characters."
  #default = null # even though this is optional in the schema, we enforce a description

  validation {
    condition     = can(regex("[\\S\\s]+$", var.description)) && length(var.description) < 141
    error_message = "The description value must match the regex expression '[\\S\\s]+$' (e.g. 'MaxContact Office') and be no greater than 140 characters."
  }
}

variable "protocol" {
  type        = string
  description = "Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."

  validation {
    condition     = contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], var.protocol)
    error_message = "The protocol value must be one of: 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah', '*'."
  }
}

variable "source_port_range" {
  type        = string
  description = "Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."

  validation {
    condition     = try((var.source_port_range >= 0 && var.source_port_range <= 65535) || var.source_port_range == "*" || var.source_port_range == null, true)
    error_message = "The source_port_range value must be between 0 and 65535, '*', or null (if source_port_ranges is provided)."
  }
}

variable "source_port_ranges" {
  type        = list(string)
  description = "List of source ports or port ranges. This is required if source_port_range is not specified."

  #   validation { #TODO
  #   }
}

variable "destination_port_range" {
  type        = string
  description = "Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."

  validation {
    condition     = try((var.destination_port_range >= 0 && var.destination_port_range <= 65535) || var.destination_port_range == "*" || var.destination_port_range == null, true)
    error_message = "The destination_port_range value must be between 0 and 65535, '*', or null (if destination_port_ranges is provided)."
  }
}

variable "destination_port_ranges" {
  type        = list(string)
  description = "List of destination ports or port ranges. This is required if destination_port_range is not specified."

  #   validation { #TODO
  #   }
}

variable "source_address_prefix" {
  type        = string
  description = "CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified."

  #   validation { #TODO
  #   }
}

variable "source_address_prefixes" {
  type        = list(string)
  description = "List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified."

  #   validation { #TODO
  #   }
}

variable "source_application_security_group_ids" {
  type        = list(string)
  description = "A List of source Application Security Group IDs"
  default     = []

  #   validation { #TODO
  #   }
}

variable "destination_address_prefix" {
  type        = string
  description = "CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: shell az network list-service-tags --location westcentralus. For further information please see Azure CLI - az network list-service-tags. This is required if destination_address_prefixes is not specified."

  #   validation { #TODO
  #   }
}

variable "destination_address_prefixes" {
  type        = list(string)
  description = "List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified."

  #   validation { #TODO
  #   }
}

variable "destination_application_security_group_ids" {
  type        = list(string)
  description = "A List of destination Application Security Group IDs"
  default     = []

  #   validation { #TODO
  #   }
}

variable "access" {
  type        = string
  description = "Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."

  validation {
    condition     = contains(["Allow", "Deny"], var.access)
    error_message = "The access value must be one of 'Allow', 'Deny'."
  }
}

variable "priority" {
  type        = number
  description = "Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."

  validation {
    condition     = var.priority >= 100 && var.priority <= 4096
    error_message = "The priority must be between 100 and 4096, and unique in the network security group."
  }
}

variable "direction" {
  type        = string
  description = "The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."

  validation {
    condition     = contains(["Inbound", "Outbound"], var.direction)
    error_message = "The direction value must be one of 'Inbound', 'Outbound'."
  }
}