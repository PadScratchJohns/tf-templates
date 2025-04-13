output "network_interface" { # the whole interface
  value = azurerm_network_interface.network_interface
}
output "nic_id" { # the whole interface
  value = azurerm_network_interface.network_interface.id
  #value = { for nam, nid in azurerm_network_interface.network_interface : nam => nid.id } 
}