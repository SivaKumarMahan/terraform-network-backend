variable "resource_group_name" {
  default = "test-rg"
}

variable "location" {
    default = "Central India"
}   

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = set(string)
  default     = ["devstgoiuacct1", "devstgoiuacct2", "devstgoiuacct3"]
}