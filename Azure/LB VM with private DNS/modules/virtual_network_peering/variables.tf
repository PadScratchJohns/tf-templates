variable "vnet_peering_name" {
  type        = string
  description = "The name of the peering itself. No validation needed, its not important, it just has to be present. Changing this forces a new resource to be created."

}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the availability set. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("[A-Za-z0-9-_]+(_rg|$)$", var.resource_group_name))
    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. cringey-customer-name_rg)"
  }
}

variable "virtual_network_name" {
  type        = string
  description = "Its the virtual_network_name... What did you expect it to be? Changing this forces a new resource to be created."
  validation {
    condition     = can(regex("[A-Za-z0-9-_]+(-vnet|$)$", var.virtual_network_name))
    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. my-special-place-vnet)"
  }
}
variable "remote_virtual_network_id" {
  type        = string
  description = "Its the id of the remote virtual network you are peering to... Its like you're not even paying attention... Changing this forces a new resource to be created."
  validation {
    condition = can(regex("/subscriptions/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/resourceGroups/[a-z0-9-_]+/providers/Microsoft.Network/virtualNetworks/[a-z0-9-_]+", remote_virtual_network_id))
    error_message = "The remote_virtual_network_id value must be the Azure Resource UID format, e.g. '/subscriptions/5d4d9f0b-0298-469f-890c-5959bcf3e265/resourceGroups/acdc_rg/providers/Microsoft.Network/networkInterfaces/thuderstruck-vnet'."
  }
}
