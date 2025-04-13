output "network_security_group" {
  value = azurerm_network_security_group.network_security_group
}
output "nsg_id" {
  value = azurerm_network_security_group.network_security_group.id
}