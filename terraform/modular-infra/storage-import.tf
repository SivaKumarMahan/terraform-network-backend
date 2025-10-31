resource "azurerm_storage_account" "existing" {
    name                     = "tfstatestorage749"
    resource_group_name      = "test-rg"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "LRS"
}