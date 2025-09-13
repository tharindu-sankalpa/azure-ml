#!/usr/bin/env python3
"""
Download workspace configuration for SDK usage
"""
import json
from azure.identity import DefaultAzureCredential
from azure.ai.ml import MLClient

def download_config():
    """Download and save workspace config"""
    # Your workspace details
    subscription_id = "89ac6d39-455b-40fa-a35d-404abf0eba90"
    resource_group = "tharinduMLRG"
    workspace_name = "tharinduMLWorkspace"
    
    try:
        credential = DefaultAzureCredential()
        
        ml_client = MLClient(
            credential=credential,
            subscription_id=subscription_id,
            resource_group_name=resource_group,
            workspace_name=workspace_name
        )
        
        # Test the connection
        workspace = ml_client.workspaces.get(workspace_name)
        print(f"Successfully connected to workspace: {workspace.name}")
        print(f"Location: {workspace.location}")
        print(f"Resource Group: {workspace.resource_group}")
        
        # Create config dictionary
        config = {
            "subscription_id": subscription_id,
            "resource_group": resource_group,
            "workspace_name": workspace_name
        }
        
        # Save config.json in the notebooks directory
        with open("../../notebooks/config.json", "w") as f:
            json.dump(config, f, indent=2)
        
        print(f"\nConfig saved to ../notebooks/config.json")
        print("You can now use this config file with the Azure ML SDK.")
        
        return config
        
    except Exception as e:
        print(f"Error connecting to workspace: {e}")
        print("\nTroubleshooting tips:")
        print("1. Make sure you're logged in with 'az login'")
        print("2. Verify the workspace exists with 'az ml workspace show -n tharinduMLWorkspace -g tharinduMLRG'")
        print("3. Check if you have the right permissions on the workspace")
        return None

if __name__ == "__main__":
    download_config()