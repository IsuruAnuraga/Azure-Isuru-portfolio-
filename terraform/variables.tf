variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "sku_name" {
  description = "SKU name for App Service Plan (e.g., B1, S1, P1v2)"
  type        = string
}

variable "app_name" {
  description = "Name of the Web App (must be globally unique)"
  type        = string
}

variable "node_version" {
  description = "Node.js version"
  type        = string
}

variable "app_command_line" {
  description = "Startup command for the app"
  type        = string
}

variable "always_on" {
  description = "Should the app be loaded at all times?"
  type        = bool
}

variable "app_settings" {
  description = "Additional app settings"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
