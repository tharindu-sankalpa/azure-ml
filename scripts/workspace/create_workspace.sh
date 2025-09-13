#!/bin/bash
# This script contains commands to create an Azure ML Workspace.
# These commands are intended to be run individually in an ad-hoc manner.

# --- Configuration Variables ---
# Set the names for your resource group, workspace, and the Azure location.
RESOURCE_GROUP="tharinduMLRG"
WORKSPACE_NAME="tharinduMLWorkspace"
LOCATION="centralindia"


# --- Command Sequence ---

# 1. Log in to your Azure account.
# This will open a browser window for you to authenticate.
az login

# 2. Install or update the Azure ML CLI extension.
# This extension is required to interact with Azure Machine Learning services.
az extension add -n ml --upgrade

# 3. Create a resource group.
# A resource group is a container that holds related resources for an Azure solution.
az group create --name $RESOURCE_GROUP --location $LOCATION

# 4. Create the Azure ML workspace.
# This command provisions the workspace and its associated resources.
az ml workspace create \
    --name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION

# 5. Verify the workspace was created successfully.
# This command shows the details of the newly created workspace.
az ml workspace show \
    --name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP
