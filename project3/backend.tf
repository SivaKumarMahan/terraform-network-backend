terraform {
  backend "azurerm" {
    resource_group_name  = "aimsplus"
    storage_account_name = "tfstatestorage759"
    container_name       = "tfstate"
    key                  = "modular-infra/terraform.tfstate"
  }
}