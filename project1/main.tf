data "azurerm_resource_group" "existing_rg" {
  name = "test-rg"
}

module "network" {
  source              = "./modules/network"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  vnet_name           = "testVNet"
  subnet_name         = "testSubnet"
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  subnet_id           = module.network.subnet_id
    vm_name             = "testVM"
}