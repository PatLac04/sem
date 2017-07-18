# USAGE:
# bash deploy_all.sh

az login
# Change this to the subscription that you want to use, required to avoid using the 'default' one if you have access to 
# multiple subscription with your user
az account set --subscription 9c7a8343-5f8f-463a-b994-d81fc00090e5

resourceGroupName=rg-PL
location=canadaeast

# Create a resource group
az group create --name $resourceGroupName --location $location

# Deploy VNet & Subnets
# az group deployment validate --resource-group $resourceGroupName --template-file VNetDeploy.json --parameters @VNetDeploy.parameters.json --verbose
az group deployment create --name DeployVNet --resource-group $resourceGroupName --template-file VNetDeploy.json --parameters @VNetDeploy.parameters.json --verbose

# Validate & Deploy Management VMs
# az group deployment validate --resource-group $resourceGroupName --template-file MgmtVMsDeploy.json --parameters @MgmtVMsDeploy.parameters.json --verbose
az group deployment create --name DeployMgmtVMs --resource-group $resourceGroupName --template-file MgmtVMsDeploy.json --parameters @MgmtVMsDeploy.parameters.json --verbose

# Validate & Deploy Web VMs
az group deployment validate --resource-group $resourceGroupName --template-file WebDeploy.json --parameters @WebDeploy.parameters.json --verbose
az group deployment create --name DeployWebVMs --resource-group $resourceGroupName --template-file WebDeploy.json --parameters @WebDeploy.parameters.json --verbose

