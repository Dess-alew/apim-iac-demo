provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# ↓ REPLACE your existing RG block with this one
resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-demo"
  location = "East US"

  lifecycle {
    prevent_destroy = true
  }
}

# New APIM in same resource group
resource "azurerm_api_management" "apim2" {
  name                = "apim-new-${random_string.suffix.result}"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "My Org"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}