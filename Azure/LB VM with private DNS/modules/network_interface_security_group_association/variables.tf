# vars
variable "network_interface_id" {
  type        = string
  description = "The ID of the network interface. Changing this forces a new resource to be created."
}
variable "network_security_group_id" {
  type        = string
  description = "The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created."

}