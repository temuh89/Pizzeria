variable "service_settings" {
    type = object({
      name                     = string
      resource_group_name      = string
      location                 = string
      account_tier             = string #"Standard"
      account_replication_type = string #"LRS"
    })
}

variable "tags" {
  type = map
}