variable "resource_group_name" {
  default = "test-rg"
}

variable "location" {
    default = "canadacentral"
}   

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = set(string)
  default     = ["devstgoiusacct5", "devstgoiuascct6"]
}