module "resource_group" {
  source   = "./modules/resource_group/"
  name     = "pizzeria"
  location = "southafricanorth"

}
resource "random_id" "strg_acc" {
  byte_length = 4
}

resource "random_string" "random" {
  count   = 4
  length  = 4
  numeric = false
  special = false
  upper   = false
}

module "storage_account" {
  source = "./modules/storage_account/"
  service_settings = {

    name                     = "pizzeria${lower(random_id.strg_acc.hex)}"
    resource_group_name      = module.resource_group.name
    location                 = module.resource_group.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  tags = {
    environment = "demo"
  }
  depends_on = [module.resource_group, random_id.strg_acc]
}

module "service_plan" {
  source = "./modules/service_plan/"
  service_settings = {
    name                = "pizzeria${random_string.random[0].result}"
    resource_group_name = module.resource_group.name
    location            = module.resource_group.location
    os_type             = "Linux"
    sku_name            = "Y1"

  }
}

module "function_app" {
  source = "./modules/function_app/"
  service_settings = {
    name                = "pizzeria${random_string.random[1].result}"
    location            = module.resource_group.location
    resource_group_name = module.resource_group.name
  }
  storage_account_name       = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key
  service_plan_id            = module.service_plan.id
  site_config = {
    application_stack = {
      node_version = "20-LTS"
    }
  }
  depends_on = [module.service_plan]
}

module "apim" {
  source = "./modules/api_management/apim/"
  service_settings = {
    name                = "pizzeria${random_string.random[2].result}"
    location            = module.resource_group.location
    resource_group_name = module.resource_group.name
    publisher_name      = "Tony"
    publisher_email     = "tony@pizzeria.com"
  }
  sku_name   = "Developer_1"
  depends_on = [module.resource_group]
}

module "user_assigned_identity" {
  source              = "./modules/managed_identity/"
  resource_group_name = module.resource_group.name
  name                = "pizzeria${random_string.random[1].result}"
  location            = module.resource_group.location
}

module "api" {
  source = "./modules/api_management/api/"
  service_settings = {
    name                = "${module.function_app.name}"
    resource_group_name = module.resource_group.name
    api_management_name = module.apim.name
    revision            = 1
    display_name        = module.function_app.name
#    path                = "./api"
    protocols           = ["http"]
depends_on = [module.function_app]
  }
  import = {
    content_format = "swagger-link-json"
    content_value  = "https://${module.function_app.name}.azurewebsites.net/?format=json"
  }

}

module "api_backend" {
  source = "./modules/api_management/api_backend/"
  service_settings = {
    name                = "pizzeria_api"
    resource_group_name = module.resource_group.name
    api_management_name = module.apim.name
    protocol            = "http"
    url                 = "https://${module.function_app.name}.azurewebsites.net/"

  }

}

module "database" {
  source = "./modules/cosmosdb/"

  service_settings = {
    name                = "${module.storage_account.name}${random_string.random[3].result}"
    location            = module.resource_group.location
    resource_group_name = module.resource_group.name
    offer_type          = "Standard"
    kind                = "MongoDB"
  }
  enable_automatic_failover = true

  capabilities = {
    name = "MongoDBv3.4"
  }

  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location = {
    location          = "eastus2"
    failover_priority = 0
  }


}