variable "resource_group_name" {
  default = "test-rg"
}

variable "location" {
    default = "centralindia"
}   

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "project7 Terraform"
}

variable "default_tags" {
  type = map(string)
  default = {
    company = "dummy"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment = "dev"
    cost-center = "it"
  }
}

variable "storage_account_name" {
  default = "tfstatestorage757"
}

variable "allowed_ports_str" {
  default = "22,80,443"
}

variable "envs" {
  type = map(object({
    redundancy    = string
    instance_size = string
  }))
  default = {
    dev = {
      redundancy    = "small"
      instance_size = "low"
    }
    prod = {
      redundancy    = "large"
      instance_size = "high"
    }
  }
}

variable "vm_size" {
  type = string
  default = "Standard_D2s_v3"
  validation {
    condition     = length(var.vm_size) >= 2 && length(var.vm_size) <= 20 && can(regex("standard", lower(var.vm_size)))
    error_message = "VM size must contain the word 'standard' and be between 2 and 20 characters."
  }
}

variable "backup_name" {
  type    = string
  default = "daily_backup"

  validation {
    condition     = endswith(var.backup_name, "_backup")
    error_message = "Backup name must end with '_backup'."
  }
}

variable "credential" {
  type = string
  description = "Sensitive credential variable"
  sensitive   = true
  
}

variable "monthly_costs" {
  type    = list(number)
  default = [-50, 100, 75, 200]
}