# Development Environment Configuration

resource_group_name   = "rg-kuruppu-dev"
location              = "australiaeast"
app_service_plan_name = "asp-kuruppu-dev"
sku_name              = "B1"
app_name              = "webapp-kuruppu-dev"
node_version          = "20-lts"
app_command_line      = "node server.js"
always_on             = false  # Save costs in dev

app_settings = {
  "ENVIRONMENT" = "development"
  "NODE_ENV"    = "development"
}

tags = {
  Environment = "Development"
  Project     = "Kuruppu"
  ManagedBy   = "Terraform"
}
