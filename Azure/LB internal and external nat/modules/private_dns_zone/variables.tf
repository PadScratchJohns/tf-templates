variable "private_dns_zone_name" {
  type        = string
  description = "The name of the Private DNS Zone. Must be a valid domain name. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^([\\S]+\\.[\\S]+){1,}$", var.private_dns_zone_name))
    error_message = "The private_dns_zone_name value must match the regex expression '^([\\S]+\\.[\\S]+){1,}$' (e.g. maxcontactsolutions.com)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the resource group where the resource exists. Changing this forces a new resource to be created."

}

variable "soa_record" {
  type = object({
    email        = optional(string)
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
    tags         = optional(map(string))
  })
  description = "An soa_record block as defined above. Changing this forces a new resource to be created."
  default     = null

  #   validation { #TODO
  #   }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}

}