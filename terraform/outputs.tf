output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.asp.id
}

output "webapp_name" {
  description = "Name of the Web App"
  value       = azurerm_linux_web_app.webapp.name
}

output "webapp_url" {
  description = "Default hostname of the Web App"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

output "webapp_id" {
  description = "ID of the Web App"
  value       = azurerm_linux_web_app.webapp.id
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses of the Web App"
  value       = azurerm_linux_web_app.webapp.outbound_ip_addresses
}
