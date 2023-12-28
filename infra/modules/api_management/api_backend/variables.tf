variable "service_settings" {
    type = object({
        name                = string
        resource_group_name = string
        api_management_name = string
        protocol            = string #"http"
        url                 = string #"https://backend"
    })
}
