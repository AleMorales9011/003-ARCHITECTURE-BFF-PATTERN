# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0" # Optional but recommended in production
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

 # Tags for desktop department
variable "desktop_tags" {
  type = map(string)
  default = {
    Department = "Des FEP Team"
    Environment = "Testing"
    Owner = "John Doe"
    Purpose = "Frontend"

  }
}

 # Tags for mobile department
variable "mobile_tags" {
  type = map(string)
  default = {
    Department = "Mob FEP Team"
    Environment = "Testing"
    Owner = "Jane Doe"
    Purpose = "Frontend"

  }
}
# Create a Resource Group for desktop 
resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = "rg-desktop-bknd-001"
  tags     = var.desktop_tags
}

# Create a Resource Group for mobile 
resource "azurerm_resource_group" "rg" {
  location = "westeurope"
  name     = "rg-mobile-bknd-001"
  tags     = var.mobile_tags
}
resource "azurerm_storage_account" "st" {
  name                      = "staccdevopsrg21605"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"

