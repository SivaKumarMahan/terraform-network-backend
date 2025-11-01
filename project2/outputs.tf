output "acr" {
    value = azurerm_container_registry.acr.login_server
}

output "aks_cluster_name" {
    value = azurerm_kubernetes_cluster.aks.name
}