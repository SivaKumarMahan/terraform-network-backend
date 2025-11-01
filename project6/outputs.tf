output "nsg_rule_names" {
  value = [for rule in azurerm_network_security_group.nsg.security_rule : rule.name]
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}