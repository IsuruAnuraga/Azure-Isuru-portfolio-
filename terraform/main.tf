terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Backend configuration for remote state
  # Configure with: terraform init -backend-config="key=prod.tfstate"
  backend "azurerm" {
    # These values should be set via backend config file or command line
    # resource_group_name  = "rg-terraform-state"
    # storage_account_name = "tfstateXXXXX"
    # container_name       = "tfstate"
    # key                  = "prod.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = var.tags
}

# Linux Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = var.always_on

    application_stack {
      node_version = var.node_version
    }

    app_command_line = var.app_command_line
  }

  app_settings = merge(
    var.app_settings,
    {
      "WEBSITE_NODE_DEFAULT_VERSION" = var.node_version
      "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    }
  )

  https_only = true

  tags = var.tags
}
