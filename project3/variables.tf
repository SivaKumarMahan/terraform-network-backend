variable "resource_group_name" {
  default = "aimsplus"
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "storage_disk" {
  type = number
  description = "The size of the storage disk in GB"
  default     = 80
}

variable "is_delete" {
    type = bool
    description = "Flag to determine if resources should be deleted"
    default = true
}

variable "allowed_locations" {
    description = "List of allowed Azure regions for resource deployment"
    type        = list(string)
    default     = ["Central India", "West Europe", "Southeast Asia"]
}

variable "resource_tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {
    "environment"      = "dev"
    "managed_by"       =  "terraform"
    "department"       = "devops"
  }
}

variable "network_config" {
    type = tuple([string, string, number])
    description = "A tuple containing VNet name, Subnet name, and address space CIDR"
    default = ["10.0.0.0/16", "10.0.2.0", 24]
}

variable "allowed_vm_sizes" {
    description = "List of allowed VM sizes for deployment"
    type        = list(string)
    default     = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}

variable "vm_config" {
    type = object({
        size         = string
        publisher    = string
        offer        = string
        sku          = string
        version      = string
    })
    description = "Configuration for the virtual machine"
    default = {
        size         = "Standard_DS1_v2"
        publisher    = "Canonical"
        offer        = "0001-com-ubuntu-server-jammy"
        sku          = "22_04-lts"
        version      = "latest"
    }
}