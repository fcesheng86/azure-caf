# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.74.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.47.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # subscription_id            = "5b79d5a5-399e-439f-8baf-a8ca1654cc3b"
  # tenant_id                  = "a6fadded-8a88-471f-a9f1-4fbd7bb0f321"
  use_cli = true
  features {}

}

provider "azuread" {
  # Configuration options
}
