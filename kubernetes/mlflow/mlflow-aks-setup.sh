# Set variables
RESOURCE_GROUP="tharindu-ml-tst-rg"
LOCATION="centralindia"
STORAGE_ACCOUNT_NAME="mlflowartifacts$RANDOM"
CONTAINER_NAME="mlflow-artifacts"
AKS_CLUSTER_NAME="tharindu-mlflow-aks"
AKS_NODE_COUNT=2
AKS_NODE_VM_SIZE="Standard_DS2_v2"

# Create Azure Storage Account for artifacts
az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS \
    --kind StorageV2

# Get storage account key
STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Create blob container
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT_NAME \
    --account-key $STORAGE_KEY

# Create AKS cluster
az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME \
    --node-count $AKS_NODE_COUNT \
    --node-vm-size $AKS_NODE_VM_SIZE \
    --location $LOCATION \
    --enable-managed-identity \
    --generate-ssh-keys

# Get AKS credentials
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME

echo "Resource Group: $RESOURCE_GROUP"
echo "Storage Account: $STORAGE_ACCOUNT_NAME"
echo "Storage Key: $STORAGE_KEY"
echo "Container Name: $CONTAINER_NAME"
echo "AKS Cluster: $AKS_CLUSTER_NAME"