resource "azurerm_api_management_api" "api" {
  name                = var.service_settings.name
  resource_group_name = var.service_settings.resource_group_name
  api_management_name = var.service_settings.api_management_name
  revision            = var.service_settings.revision
  display_name        = var.service_settings.display_name
  #path                = var.service_settings.path
  protocols           = var.service_settings.protocols

  import {
    content_format = var.import.content_format
    content_value  = var.import.content_value
  }
}