variable "service_settings" {
    type = object({
      name                     = string
      resource_group_name      = string
      location                 = string
      os_type                  = string #"Linux"
      sku_name                 = string #"P1v2"
    })
}



