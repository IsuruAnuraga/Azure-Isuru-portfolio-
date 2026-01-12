# Production Environment Configuration

resource_group_name   = "rg-kuruppu-prod"
location              = "australiaeast"
app_service_plan_name = "asp-kuruppu-prod"
sku_name              = "P1v2"  # Premium tier for production
app_name              = "webapp-kuruppu-prod"
node_version          = "20-lts"
app_command_line      = "node server.js"
always_on             = true  # Required for production

app_settings = {
  "ENVIRONMENT" = "production"
  "NODE_ENV"    = "production"
}

tags = {
  Environment = "Production"
  Project     = "Kuruppu"
  ManagedBy   = "Terraform"
}
