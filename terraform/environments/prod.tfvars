# Production Environment Configuration

resource_group_name   = "rg-azure-msc"
location              = "southeastasia"
app_service_plan_name = "asp-azure-msc"
sku_name              = "F1"  # Premium tier for production
app_name              = "azure-msc-final"
node_version          = "20-lts"
app_command_line      = "node server.js"
always_on             = true  # Required for production

app_settings = {
  "ENVIRONMENT" = "production"
  "NODE_ENV"    = "production"
}

tags = {
  Environment = "Test"
  Project     = "Msc"
  ManagedBy   = "Terraform"
}