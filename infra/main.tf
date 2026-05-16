provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-demo"
  location = "East US"
}

resource "azurerm_api_management" "apim" {
  name                = "my-apim-demo"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "My Org"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}