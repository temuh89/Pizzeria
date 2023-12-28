resource "azurerm_api_management" "apim" {
  name                = var.service_settings.name
  location            = var.service_settings.location
  resource_group_name = var.service_settings.resource_group_name
  publisher_name      = var.service_settings.publisher_name
  publisher_email     = var.service_settings.publisher_email

  sku_name = var.sku_name #"Developer_1"
}
