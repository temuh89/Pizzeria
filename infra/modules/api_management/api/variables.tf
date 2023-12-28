variable "service_settings" {
    type = object({
        name                = string
        resource_group_name = string
        api_management_name = string
        revision            = number #"1"
        display_name        = string #"Example API"
    #    path                = string #"example"
        protocols           = set(string) #["https"]
    })
}

variable "import" {
    type = object({
    content_format = string #"swagger-link-json"
    content_value  = string #"http://conferenceapi.azurewebsites.net/?format=json"
      })

  }
