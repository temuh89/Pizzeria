variable "service_settings" {
    type = object({
      name                     = string
      resource_group_name      = string
      location                 = string
      publisher_name           = string
      publisher_email          = string
    })
}

variable "sku_name" {
  type = string   
}