Create a SP wth cintribute access to subscription

az ad sp create-for-rbac --name "azure-msc" --role Contributor --scopes /subscriptions/31c93d57-7ee6-4811-a3c1-100e8b91524c --sdk-auth


Set the backend.conf