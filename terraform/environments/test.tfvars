# Test Environment Configuration

resource_group_name   = "rg-kuruppu-test"
location              = "australiaeast"
app_service_plan_name = "asp-kuruppu-test"
sku_name              = "B1"
app_name              = "webapp-kuruppu-test"
node_version          = "20-lts"
app_command_line      = "node server.js"
always_on             = false  # Save costs in test

app_settings = {
  "ENVIRONMENT" = "test"
  "NODE_ENV"    = "test"
}

tags = {
  Environment = "Test"
  Project     = "Kuruppu"
  ManagedBy   = "Terraform"
}
