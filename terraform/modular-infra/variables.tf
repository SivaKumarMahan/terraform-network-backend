variable "resource_group_name" {
    description = "The name of the resource group."
    type        = string
}

variable "location" {
    description = "The Azure region to deploy resources."
    type        = string
    default     = "Central India"
}

variable "vnet_name" {
    description = "The name of the Virtual Network."
    type        = string
}

variable "subnet_name" {
    description = "The name of the Subnet."
    type        = string
}

variable "vm_name" {
    description = "The name of the Virtual Machine."
    type        = string
}