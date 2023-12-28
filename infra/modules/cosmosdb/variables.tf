variable "service_settings" {
    type = object({
      name = string
      location            = string
      resource_group_name = string
      offer_type          = string #"Standard"
      kind                = string #"MongoDB"
    })
}

variable "enable_automatic_failover" {
    type = bool
} 

variable "consistency_policy" {
    type = object ({
    consistency_level       = string #"BoundedStaleness"
    max_interval_in_seconds = number #300
    max_staleness_prefix    = number #100000
})
  }

variable "capabilities" {
  type = object({
    name = string
  })
    
  }

variable "geo_location" {
    type = object ({
    location          = string #"eastus"
    failover_priority = number
    })
  }