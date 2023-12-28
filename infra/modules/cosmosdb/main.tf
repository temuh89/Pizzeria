resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.service_settings.name
  location            = var.service_settings.location
  resource_group_name = var.service_settings.resource_group_name
  offer_type          = var.service_settings.offer_type
  kind                = var.service_settings.kind 

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.geo_location.location
    failover_priority = var.geo_location.failover_priority
  }

  geo_location {
    location          = var.geo_location.location
    failover_priority = var.geo_location.failover_priority
  }
}