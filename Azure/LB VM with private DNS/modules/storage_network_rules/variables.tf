#variable "resource_group_name" {
#  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
#  type        = string
#  validation {
#    condition     = can(regex("[A-Za-z0-9-_]+(_rg|$)$", var.resource_group_name))
#    error_message = "The resource_group_name value must match the regex expression '[A-Za-z0-9-_]+(_rg|$)$' (e.g. dkcc_rg)"
#  }
#}
variable "storage_account_id" {
  default = null
  description = "storage account id for the... storage account..."
}
#variable "storage_account_name" {
#  default = null
#  description = "storage account name for the... storage account..."
#}
variable "default_action" {
  default = null
  description = "default set as null instead of deny"
}
variable "bypass" {
  default = null
  description = "default set as null instead of deny"
}
variable "ip_rules" {
  default = null
  description = "default set as null instead of deny"
}
variable "virtual_network_subnet_ids" {
  default = null
  description = "default set as null instead of deny"
}
variable "private_link_access" {
  default = null
  description = "default set as null instead of deny"
}