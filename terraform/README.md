az ad sp create-for-rbac --name "github-actions-terraform" --role Contributor --scopes /subscriptions/YOUR_SUBSCRIPTION_ID --sdk-auth
Add the JSON output as GitHub secret named AZURE_CREDENTIALS

