# Create a resource group
az group create --name tharindu-ml-tst-rg --location centralindia

# Create an AKS cluster
az aks create \
  --resource-group tharindu-ml-tst-rg \
  --name tharindu-ml-tst-aks \
  --node-count 2 \
  --node-vm-size Standard_D4ads_v5 \
  --enable-managed-identity \
  --network-plugin azure \
  --generate-ssh-keys

# Get AKS credentials
az aks get-credentials --resource-group tharindu-ml-tst-rg --name tharindu-ml-tst-aks


# Install k8s CLI extension
az extension add -n k8s-extension

# install ASK ML extension
az k8s-extension create \
  --name azureml-extension \
  --extension-type Microsoft.AzureML.Kubernetes \
  --config enableTraining=True enableInference=True \
  inferenceRouterServiceType=LoadBalancer \
  allowInsecureConnections=True \
  --cluster-type managedClusters \
  --cluster-name tharindu-ml-tst-aks \
  --resource-group tharindu-ml-tst-rg \
  --scope cluster

# View extension status
az k8s-extension show \
  --name azureml-extension \
  --cluster-type managedClusters \
  --cluster-name tharindu-ml-tst-aks \
  --resource-group tharindu-ml-tst-rg

# Check pods in the azureml namespace
kubectl get pods -n azureml

# Make sure the ML CLI extension is installed
az extension add -n ml

# Attach the AKS cluster to your Azure ML workspace
az ml compute attach \
  --resource-group tharindu-ml-tst-rg \
  --workspace-name <your-workspace-name> \
  --type kubernetes \
  --name akscompute \
  --resource-id "/subscriptions/<your-subscription-id>/resourceGroups/tharindu-ml-tst-rg/providers/Microsoft.ContainerService/managedClusters/tharindu-ml-tst-aks" \
  --namespace azureml

# Verify the attached compute
az ml compute list \
  --resource-group tharindu-ml-tst-rg \
  --workspace-name <your-workspace-name>