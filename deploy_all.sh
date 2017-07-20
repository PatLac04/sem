# USAGE:
# bash deploy_all.sh

az login
# Change this to the subscription that you want to use, required to avoid using the 'default' one if you have access to 
# multiple subscription with your user
az account set --subscription 9c7a8343-5f8f-463a-b994-d81fc00090e5

resourceGroupName=rg-Semeon
location=canadacentral

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

# Validate & Deploy API/Query VMs
az group deployment validate --resource-group $resourceGroupName --template-file ApiandQueryDeploy.json --parameters @ApiandQueryDeploy.parameters.json --verbose
az group deployment create --name DeployAPIAndQueryVMs --resource-group $resourceGroupName --template-file ApiandQueryDeploy.json --parameters @ApiandQueryDeploy.parameters.json --verbose

# Validate & Deploy Ingestion API VMs
az group deployment validate --resource-group $resourceGroupName --template-file IngestionApiDeploy.json --parameters @IngestionApiDeploy.parameters.json --verbose
az group deployment create --name DeployIngestionApiVMs --resource-group $resourceGroupName --template-file IngestionApiDeploy.json --parameters @IngestionApiDeploy.parameters.json --verbose

# Validate & Deploy Ingesters and Data Capture  VMs
az group deployment validate --resource-group $resourceGroupName --template-file IngestionDeploy.json --parameters @IngestionDeploy.parameters.json --verbose
az group deployment create --name DeployIngestersVMs --resource-group $resourceGroupName --template-file IngestionDeploy.json --parameters @IngestionDeploy.parameters.json --verbose

# Validate & Deploy SolR VMs
az group deployment validate --resource-group $resourceGroupName --template-file SolRDeploy.json --parameters @SolRDeploy.parameters.json --verbose
az group deployment create --name DeploySolRVMs --resource-group $resourceGroupName --template-file SolRDeploy.json --parameters @SolRDeploy.parameters.json --verbose

# Validate & Deploy PostgresSQL VMs
az group deployment validate --resource-group $resourceGroupName --template-file PostgresDeploy.json --parameters @PostgresDeploy.parameters.json --verbose
az group deployment create --name DeployPostgresVMs --resource-group $resourceGroupName --template-file PostgresDeploy.json --parameters @PostgresDeploy.parameters.json --verbose



###az group deployment create --name TestDeploy --resource-group $resourceGroupName --template-file tmp.json --parameters @IngestionDeploy.parameters.json --verbose
