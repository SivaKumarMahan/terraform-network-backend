terraform {
  backend "azurerm" {
    resource_group_name  = "test-rg"
    storage_account_name = "tfstatestorage749"
    container_name       = "tfstate"
    key                  = "modular-infra/terraform.tfstate"
  }
}