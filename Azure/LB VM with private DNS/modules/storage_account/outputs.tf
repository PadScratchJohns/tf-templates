output "storage_account" {
  value     = azurerm_storage_account.storage_account
  sensitive = true
}