#!/bin/bash
# Azure ML Compute Instance Management - CLI Commands Reference
# Copy and paste commands as needed

# Variables - Update these for your environment
RESOURCE_GROUP="tharinduMLRG"
WORKSPACE_NAME="tharinduMLWorkspace"
COMPUTE_NAME="my-ds-instance"

# =============================================================================
# COMPUTE INSTANCE MANAGEMENT COMMANDS
# =============================================================================

# List all compute instances in the workspace
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# List all compute resources (instances and clusters) with table format
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --output table

# List only compute instances (filter out clusters)
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance']"

# Create a new compute instance
az ml compute create \
    --name $COMPUTE_NAME \
    --size Standard_DS3_v2 \
    --type ComputeInstance \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --idle-time-before-shutdown PT30M \
    --ssh-access-enabled false

# Create compute instance with SSH enabled
az ml compute create \
    --name $COMPUTE_NAME \
    --size Standard_DS3_v2 \
    --type ComputeInstance \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --idle-time-before-shutdown PT1H \
    --ssh-access-enabled true

# Show details of a specific compute instance
az ml compute show --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# Get just the status of a compute instance
az ml compute show --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "state" -o tsv

# Start a stopped compute instance
az ml compute start --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# Start compute instance without waiting for completion
az ml compute start --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --no-wait

# Stop a running compute instance
az ml compute stop --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# Stop compute instance without waiting for completion
az ml compute stop --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --no-wait

# Delete a compute instance (with confirmation prompt)
az ml compute delete --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# Delete compute instance without confirmation prompt
az ml compute delete --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --yes

# Delete compute instance without waiting for completion
az ml compute delete --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --yes --no-wait

# Update compute instance idle time
az ml compute update --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --idle-time-before-shutdown PT2H

# =============================================================================
# COMPUTE CLUSTER MANAGEMENT COMMANDS
# =============================================================================

# Create a compute cluster
az ml compute create \
    --name training-cluster \
    --size Standard_DS3_v2 \
    --type AmlCompute \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --min-instances 0 \
    --max-instances 4 \
    --idle-time-before-scale-down 900

# Create low-priority compute cluster (cheaper)
az ml compute create \
    --name low-priority-cluster \
    --size Standard_DS3_v2 \
    --type AmlCompute \
    --workspace-name $WORKSPACE_NAME \
    --resource-group $RESOURCE_GROUP \
    --min-instances 0 \
    --max-instances 4 \
    --tier LowPriority \
    --idle-time-before-scale-down 300

# List all compute clusters
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='AmlCompute']"

# Show compute cluster details
az ml compute show --name training-cluster --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP

# Update compute cluster max instances
az ml compute update --name training-cluster --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --max-instances 8

# Delete compute cluster
az ml compute delete --name training-cluster --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --yes

# =============================================================================
# USEFUL QUERIES AND FILTERS
# =============================================================================

# List compute instances with name, state, and size
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance'].{Name:name, State:state, Size:size}" --output table

# List only running compute instances
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance' && state=='Running'].name" --output tsv

# List only stopped compute instances
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance' && state=='Stopped'].name" --output tsv

# Get all compute resources (instances and clusters) in table format
az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --output table

# Check if specific compute instance exists
az ml compute show --name $COMPUTE_NAME --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "name" -o tsv 2>/dev/null

# =============================================================================
# BATCH OPERATIONS (use in loops)
# =============================================================================

# Start all stopped compute instances
for instance in $(az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance' && state=='Stopped'].name" --output tsv); do
    az ml compute start --name "$instance" --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --no-wait
done

# Stop all running compute instances
for instance in $(az ml compute list --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --query "[?type=='ComputeInstance' && state=='Running'].name" --output tsv); do
    az ml compute stop --name "$instance" --workspace-name $WORKSPACE_NAME --resource-group $RESOURCE_GROUP --no-wait
done

# =============================================================================
# COMMON VM SIZES FOR DIFFERENT USE CASES
# =============================================================================

# Development and testing
# --size Standard_DS2_v2    # 2 vCPUs, 7 GB RAM
# --size Standard_DS3_v2    # 4 vCPUs, 14 GB RAM

# CPU-intensive training
# --size Standard_D4s_v3    # 4 vCPUs, 16 GB RAM
# --size Standard_D8s_v3    # 8 vCPUs, 32 GB RAM

# GPU for deep learning
# --size Standard_NC6s_v3   # 6 vCPUs, 112 GB RAM, 1 V100 GPU
# --size Standard_NC12s_v3  # 12 vCPUs, 224 GB RAM, 2 V100 GPUs

# =============================================================================
# ISO 8601 DURATION FORMATS
# =============================================================================

# Common idle time formats:
# PT15M   = 15 minutes
# PT30M   = 30 minutes
# PT1H    = 1 hour
# PT2H    = 2 hours
# PT0S    = Never shutdown automatically

# Scale down time for clusters (in seconds):
# 300     = 5 minutes
# 900     = 15 minutes
# 1800    = 30 minutes
# 3600    = 1 hour