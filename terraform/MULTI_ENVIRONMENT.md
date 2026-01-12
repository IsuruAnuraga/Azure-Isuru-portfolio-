# Multi-Environment Terraform Setup

This guide explains how to manage multiple environments (dev, test, prod) with Terraform.

## Environment Structure

```
terraform/
├── main.tf                    # Main infrastructure definitions
├── variables.tf               # Variable declarations
├── outputs.tf                 # Output values
├── environments/
│   ├── dev.tfvars            # Development environment config
│   ├── test.tfvars           # Test environment config
│   └── prod.tfvars           # Production environment config
```

## Environment Configuration

Each environment has separate:
- **Resource names** (e.g., `webapp-kuruppu-dev`, `webapp-kuruppu-prod`)
- **SKU/pricing tiers** (B1 for dev/test, P1v2 for prod)
- **App settings** (environment-specific variables)
- **State files** (dev.tfstate, test.tfstate, prod.tfstate)

## Deployment Methods

### Method 1: Automated via GitHub Actions (Recommended)

The pipeline automatically deploys based on branch:

| Branch    | Environment(s) | Trigger       |
|-----------|---------------|---------------|
| `main`    | prod          | Push to main  |
| `develop` | dev + test    | Push to develop |
| Manual    | Any (choice)  | Workflow dispatch |

**Workflow triggers:**
- Push to `main` → deploys to **prod**
- Push to `develop` → deploys to **dev** and **test**
- Manual run → choose environment from dropdown

### Method 2: Local Deployment

Deploy to a specific environment locally:

#### Setup Backend (First Time Only)

```bash
# Create storage account for Terraform state
az group create --name rg-terraform-state --location australiaeast

az storage account create \
  --name tfstatekuname \
  --resource-group rg-terraform-state \
  --location australiaeast \
  --sku Standard_LRS

az storage container create \
  --name tfstate \
  --account-name tfstatekuname
```

#### Deploy Development Environment

```bash
cd terraform

# Initialize with dev state
terraform init -backend-config="key=dev.tfstate"

# Validate
terraform validate

# Plan with dev variables
terraform plan -var-file="environments/dev.tfvars"

# Apply
terraform apply -var-file="environments/dev.tfvars" -auto-approve
```

#### Deploy Test Environment

```bash
cd terraform

# Initialize with test state
terraform init -backend-config="key=test.tfstate" -reconfigure

# Plan and apply
terraform plan -var-file="environments/test.tfvars"
terraform apply -var-file="environments/test.tfvars" -auto-approve
```

#### Deploy Production Environment

```bash
cd terraform

# Initialize with prod state
terraform init -backend-config="key=prod.tfstate" -reconfigure

# Plan and apply
terraform plan -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars" -auto-approve
```

## Environment Details

### Development (dev)
- **Resource Group**: `rg-kuruppu-dev`
- **App Name**: `webapp-kuruppu-dev`
- **SKU**: B1 (Basic)
- **Always On**: Disabled (cost savings)
- **State File**: `dev.tfstate`

### Test (test)
- **Resource Group**: `rg-kuruppu-test`
- **App Name**: `webapp-kuruppu-test`
- **SKU**: B1 (Basic)
- **Always On**: Disabled (cost savings)
- **State File**: `test.tfstate`

### Production (prod)
- **Resource Group**: `rg-kuruppu-prod`
- **App Name**: `webapp-kuruppu-prod`
- **SKU**: P1v2 (Premium)
- **Always On**: Enabled (required for production)
- **State File**: `prod.tfstate`

## GitHub Actions Setup

1. **Create Azure Service Principal** (if not already done):
```bash
az ad sp create-for-rbac \
  --name "github-actions-terraform" \
  --role Contributor \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID \
  --sdk-auth
```

2. **Add GitHub Secret**:
   - Go to repository Settings → Secrets → Actions
   - Create secret: `AZURE_CREDENTIALS`
   - Paste the JSON output from step 1

3. **Create GitHub Environments** (optional but recommended):
   - Settings → Environments
   - Create environments: `dev`, `test`, `prod`
   - Add protection rules for `prod` (require reviewers)

## Switching Between Environments

When working locally, use `-reconfigure` flag to switch environments:

```bash
# Switch from dev to prod
terraform init -backend-config="key=prod.tfstate" -reconfigure
terraform plan -var-file="environments/prod.tfvars"
```

## Viewing Environment Resources

```bash
# View dev resources
terraform init -backend-config="key=dev.tfstate" -reconfigure
terraform show

# View prod resources
terraform init -backend-config="key=prod.tfstate" -reconfigure
terraform show
```

## Best Practices

✅ **Never share state files** between environments  
✅ **Use remote backend** (Azure Storage) for team collaboration  
✅ **Protect production** with GitHub environment protection rules  
✅ **Review plans** before applying to production  
✅ **Tag resources** consistently with environment labels  
✅ **Use lower SKUs** for dev/test to save costs  

## Cleanup

Destroy a specific environment:

```bash
# Destroy dev environment
terraform init -backend-config="key=dev.tfstate" -reconfigure
terraform destroy -var-file="environments/dev.tfvars"
```

## Troubleshooting

### Error: "Backend configuration changed"
Run `terraform init -reconfigure`

### Error: "State file locked"
Another deployment is in progress. Wait or force unlock:
```bash
terraform force-unlock <LOCK_ID>
```

### Different state file showing
Ensure you're using the correct backend config:
```bash
terraform init -backend-config="key=<environment>.tfstate" -reconfigure
```
