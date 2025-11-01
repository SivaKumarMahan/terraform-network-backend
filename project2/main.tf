data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}

resource "azurerm_container_registry" "acr" {
    name                = var.acr
    resource_group_name = data.azurerm_resource_group.existing_rg.name
    location            = data.azurerm_resource_group.existing_rg.location
    sku                 = "Basic"
    admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = var.aks_cluster_name
    location            = data.azurerm_resource_group.existing_rg.location
    resource_group_name = data.azurerm_resource_group.existing_rg.name
    dns_prefix          = "testaksdns"
    
    default_node_pool {
        name       = "agentpool"
        node_count = var.node_count
        vm_size    = "Standard_DS2_v2"
    }
    
    identity {
        type = "SystemAssigned"
    }
    
    network_profile {
        network_plugin = "azure"
        load_balancer_sku = "standard"
    }
    
    tags = {
        project = "aks-flask-demo"
    }
    depends_on = [azurerm_container_registry.acr]
}

# This assigns AcrPull to the AKS kubelet identity principal so nodes can pull images.
resource "azurerm_role_assignment" "acr_pull" {
    scope                = azurerm_container_registry.acr.id
    role_definition_name = "AcrPull"
    principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  
}