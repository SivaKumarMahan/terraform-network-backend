output "names_of_storage_accounts" {
  value = [for sa in azurerm_storage_account.stg : sa.name]
}