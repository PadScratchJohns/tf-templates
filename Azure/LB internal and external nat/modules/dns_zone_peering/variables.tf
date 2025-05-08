variable "name" {
  type        = string
  description = "The name of the peering itself. No validation needed, its not important, it just has to be present. Changing this forces a new resource to be created."

}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the availability set. Changing this forces a new resource to be created."

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