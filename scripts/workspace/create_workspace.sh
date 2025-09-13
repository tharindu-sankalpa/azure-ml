#!/bin/bash
# Azure ML Workspace Creation Script

# Variables
RESOURCE_GROUP="tharinduMLRG"
WORKSPACE_NAME="tharinduMLWorkspace"
LOCATION="centralindia"

# Ensure Azure CLI is installed and logged in
echo "Checking Azure CLI authentication..."
az account show || az login

# Install Azure ML extension
echo "Installing Azure ML extension..."
az extension add -n ml --upgrade

# Create resource group
echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create resource group (this part was working correctly)
echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create ML workspace - CORRECTED SYNTAX
echo "Creating ML workspace: $WORKSPACE_NAME"
az ml workspace create \
    --name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION

# Verify workspace creation - CORRECTED SYNTAX
echo "Verifying workspace creation..."
az ml workspace show \
    --name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP

echo "Workspace setup complete!"