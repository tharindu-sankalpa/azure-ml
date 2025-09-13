#!/bin/bash
# Azure ML Workspace Creation Script

# Variables
RESOURCE_GROUP="tharinduMLRG"
WORKSPACE_NAME="tharinduMLWorkspace"
LOCATION="eastus"

# Ensure Azure CLI is installed and logged in
echo "Checking Azure CLI authentication..."
az account show || az login

# Install Azure ML extension
echo "Installing Azure ML extension..."
az extension add -n ml --upgrade

# Create resource group
echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create ML workspace
echo "Creating ML workspace: $WORKSPACE_NAME"
az ml workspace create \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION

# Verify workspace creation
echo "Verifying workspace creation..."
az ml workspace show \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP

echo "Workspace setup complete!"