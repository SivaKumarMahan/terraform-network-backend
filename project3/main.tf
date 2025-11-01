data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_management_lock" "rg_lock" {
  name       = "RG-Delete-Lock"
  scope      = data.azurerm_resource_group.existing_rg.id
  lock_level = "CanNotDelete"
  notes      = "This resource group is protected from deletion."
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  address_space       = [element(var.network_config, 0)]
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${element(var.network_config, 1)}/${element(var.network_config, 2)}"]
}

resource "azurerm_network_interface" "nic" {
    name                = "${var.environment}-nic"
    location            = data.azurerm_resource_group.existing_rg.location
    resource_group_name = data.azurerm_resource_group.existing_rg.name
    
    ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.environment}-vm"
    location              = data.azurerm_resource_group.existing_rg.location
    resource_group_name   = data.azurerm_resource_group.existing_rg.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    vm_size               = var.allowed_vm_sizes[0]

    delete_os_disk_on_termination = var.is_delete
    
    storage_os_disk {
        name              = "${var.environment}-osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
        disk_size_gb      = var.storage_disk
    }
    
    storage_image_reference {
        publisher = var.vm_config.publisher
        offer     = var.vm_config.offer
        sku       = var.vm_config.sku
        version   = var.vm_config.version
    }
    
    os_profile {
        computer_name  = "${var.environment}-vm"
        admin_username = "adminuser"
        admin_password = "P@ssw0rd1234!"
    }
    
    os_profile_linux_config {
        disable_password_authentication = false
    }
    tags = {
        environment = var.resource_tags["environment"]
        managed_by  = var.resource_tags["managed_by"]
        department  = var.resource_tags["department"]
    }
}