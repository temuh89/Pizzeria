terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }

  }
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "tonytrfmstorage"
    container_name       = "tfstatestorage"
    key                  = "terraform.tfstate"
  }
}# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "random" {}