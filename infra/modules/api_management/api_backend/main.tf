resource "azurerm_api_management_backend" "api_management_backend" {
  name                = var.service_settings.name
  resource_group_name = var.service_settings.resource_group_name
  api_management_name = var.service_settings.api_management_name
  protocol            = var.service_settings.protocol #"http"
  url                 = var.service_settings.url #"https://backend"
}