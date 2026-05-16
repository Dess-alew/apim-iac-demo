provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-demo"
  location = "East US"
}

resource "azurerm_api_management" "apim" {
  name                = "apim-dess-${random_string.suffix.result}"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "My Org"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}