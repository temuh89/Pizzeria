resource "azurerm_linux_function_app" "function_app" {
  name                = var.service_settings.name
  resource_group_name = var.service_settings.resource_group_name
  location            = var.service_settings.location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id

  site_config {


  }
}