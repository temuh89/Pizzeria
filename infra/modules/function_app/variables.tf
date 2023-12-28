variable "service_settings" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
  })  
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_access_key" {
  type = string
}

variable "service_plan_id" {
  type = string
}

variable "site_config" {
  type = object({
    application_stack = object({
      node_version = string
    })
  #   api_definition_url    = string
  #   api_management_api_id = string
  })
  
}
