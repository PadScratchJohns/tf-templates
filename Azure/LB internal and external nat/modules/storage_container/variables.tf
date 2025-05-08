variable "container_name" {
  description = "Name of the (you guessed it..) container..."
}
variable "storage_account_name" {
  description = "Supposed to be deprecated in favour of storage_account_id - this variable references the name of the storage container"
}
#variable "storage_account_id" {
#  description = "Favoured in place of the now deprecated Storage_account_name - references the id of the storage container - for future use it seems as azurerm and/or our provider version is low enough to still have it"
#}
variable "container_access_type" {
  description = "Access level for container - this is inherited from storage ACL but setting default as private here as well"
  default = "private"
}