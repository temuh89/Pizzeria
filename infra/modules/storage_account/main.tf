resource "azurerm_storage_account" "pizzeria_storage_account" {
  
  name                     = var.service_settings.name
  resource_group_name      = var.service_settings.resource_group_name
  location                 = var.service_settings.location
  account_tier             = var.service_settings.account_tier
  account_replication_type = var.service_settings.account_replication_type
  
  tags = {
    environment = "demo"
  }
 
}