variable "backend_address_pool_id" {
  type        = string
  description = "The ID of the Backend Address Pool. Changing this forces a new Backend Address Pool Address to be created."

  validation {
    condition     = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft\\.Network/loadBalancers/[a-z0-9-_]+/backendAddressPools/[a-z0-9-_]+$", var.backend_address_pool_id))
    error_message = "The backend_address_pool_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/dkcc_rg/providers/Microsoft.Network/loadBalancers/ukw-db-ha-lb/backendAddressPools/ne-db-ha-lb-backendpool-01'."
  }
}
variable "network_interface_id" {
  type        = string
  description = "The ID of the NIC which should be used for this Backend Address Pool association. Changing this forces a new Backend Address Pool Address to be created."

}
variable "ip_configuration_name" {
  type        = string
  description = "The name of the nic basically - normally ipconfig1"
  default     = null
}
