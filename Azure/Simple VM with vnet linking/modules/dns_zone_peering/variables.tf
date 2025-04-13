variable "name" {
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
variable "private_dns_zone_name" {
  type        = string
  description = "Its the private_dns_zone_name... What did you expect it to be? Changing this forces a new resource to be created."
}
variable "virtual_network_id" {
  type        = string
  description = "Its the id of the remote virtual network you are peering to... Its like you're not even paying attention... Changing this forces a new resource to be created."
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags which should be assigned to this Virtual Machine."
  default     = {}
}