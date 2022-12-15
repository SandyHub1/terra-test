terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.99.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Add this block code if you want to import existing Resource group
resource "azurerm_resource_group" "rg" {
  name     = "RG"
  location = "South Africa North"
}
resource "azurerm_service_plan" "service-plan" {
  name                = "ASP-RG-8c97"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
  tags = {
          environment = "dev"
  }
}
# Create JAVA app service
resource "azurerm_linux_web_app" "app-service" {
  name = "MyAwesomeSuperWebApp"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.service-plan.id
  site_config {
    minimum_tls_version = "1.0"
    application_stack {
      java_server         = "TOMCAT"
      java_version        = "java11"
      java_server_version = 9.5
    }
  }
tags = {
    environment = "dev"
  }
}

