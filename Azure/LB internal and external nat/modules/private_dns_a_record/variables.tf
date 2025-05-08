variable "private_dns_a_record_name" {
  type        = string
  description = "The name of the DNS A Record. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^[A-Za-z0-9-_]+$", var.private_dns_a_record_name))
    error_message = "The private_dns_a_record_name value must match the regex expression '^[A-Za-z0-9-_]+$' (e.g. ukw-db-ha-mgmt01)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."

}

variable "zone_name" {
  type        = string
  description = "Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^[A-Za-z0-9-_\\.]+$", var.zone_name))
    error_message = "The zone_name value must match the regex expression '^[A-Za-z0-9-_\\.]+$' (e.g. ukw-db-ha-mgmt01)."
  }
}

variable "ttl" {
  type        = number
  description = "The Time To Live (TTL) of the DNS record in seconds."
  default     = 10

  validation {
    condition     = var.ttl >= 1 && var.ttl <= 3600
    error_message = "The ttl value must be between 1 and 3600."
  }
}

variable "records" {
  type        = list(string)
  description = "List of IPv4 Addresses."

  validation {
    condition = length([
      for record in var.records : true
      if can(regex("([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})", record))
    ]) == length(var.records)
    error_message = "Each IP Address in the records value must be in the non-CIDR format e.g. '8.8.8.8'."
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}

  # validation { # TODO: figure out why this seems to have a character limit when returning the tags in tests
  #   condition     = can(var.tags.Customer)
  #   error_message = "The tags must contain a key/pair defining the Customer of the resource."
  # }
}