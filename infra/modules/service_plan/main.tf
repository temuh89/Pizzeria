resource "azurerm_service_plan" "service_plan" {
  name                = var.service_settings.name
  resource_group_name = var.service_settings.resource_group_name
  location            = var.service_settings.location
  os_type             = var.service_settings.os_type
  sku_name            = var.service_settings.sku_name
}