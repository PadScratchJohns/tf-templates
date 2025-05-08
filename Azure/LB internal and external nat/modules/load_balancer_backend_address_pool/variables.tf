variable "load_balancer_backend_address_pool_name" {
  type        = string
  description = "Specifies the name of the Backend Address Pool. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[a-z0-9-_]+$", var.load_balancer_backend_address_pool_name))
    error_message = "The load_balancer_backend_address_pool_name value must match the regex expression '[a-z0-9-_]+$' (e.g. ne-db_rg_ne-db-ha-mgmt02942ipconfig1)"
  }
}

variable "load_balancer_id" {
  type        = string
  description = "The ID of the Load Balancer in which to create the Backend Address Pool. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Network/loadBalancers/[a-z0-9-_]+$", var.load_balancer_id))
    error_message = "The load_balancer_id value must be the Azure Resource UID format, (e.g. /subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/loadBalancers/ne-db-ha-lb)."
  }
}

variable "tunnel_interface" {
  type = object({
    identifier = optional(string)
    type       = optional(string)
    protocol   = optional(string)
    port       = optional(number)
  })
  description = "One or more tunnel_interface blocks as defined above."
  default     = null

  # validation { # TODO
  # }
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the Virtual Network within which the Backend Address Pool should exist."
  default     = null

}