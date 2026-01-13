# Production Environment Configuration

resource_group_name   = "rg-ppp-func-test"
location              = "australiaeast"
app_service_plan_name = "asp-ppp-func-test"
sku_name              = "P0v3"  # Premium tier for production
app_name              = "ppp-func-test"
node_version          = "20-lts"
app_command_line      = "node server.js"
always_on             = true  # Required for production

app_settings = {
  "ENVIRONMENT" = "production"
  "NODE_ENV"    = "production"
}

tags = {
  Environment = "Test"
  Project     = "PPP-Func"
  ManagedBy   = "Terraform"
}