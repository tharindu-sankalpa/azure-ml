#!/usr/bin/env python3
"""
Create Azure ML Compute Instance
"""
import json
from azure.identity import DefaultAzureCredential
from azure.ai.ml import MLClient
from azure.ai.ml.entities import ComputeInstance

class ComputeManager:
    def __init__(self, config_path="../../notebooks/config.json"):
        with open(config_path) as f:
            config = json.load(f)
        
        credential = DefaultAzureCredential()
        self.ml_client = MLClient(
            credential=credential,
            subscription_id=config["subscription_id"],
            resource_group_name=config["resource_group"],
            workspace_name=config["workspace_name"]
        )

    def create_compute_instance(self):
        """Create a compute instance."""
        compute_instance = ComputeInstance(
            name="my-ds-instance",
            size="Standard_F8s_v2", # 8 cores, 16GB RAM, 64GB storage
            idle_time_before_shutdown="PT30M",
            ssh_public_access_enabled=False,
            description="Development compute instance for data science work"
        )
        
        print("Creating compute instance...")
        try:
            operation = self.ml_client.compute.begin_create_or_update(compute_instance)
            result = operation.result()
            print(f"Compute instance '{result.name}' created successfully!")
            print(f"State: {result.state}")
            print(f"Size: {result.size}")
            return result
        except Exception as e:
            print(f"Error creating compute instance: {e}")
            return None

    def list_compute_instances(self):
        """List existing compute instances."""
        print("\nExisting compute instances:")
        compute_instances = self.ml_client.compute.list(compute_type="ComputeInstance")
        for instance in compute_instances:
            print(f"- {instance.name}: {instance.state} ({instance.size})")

if __name__ == "__main__":
    compute_manager = ComputeManager()
    
    # First, list existing instances
    compute_manager.list_compute_instances()
    
    # Create new instance
    result = compute_manager.create_compute_instance()
    
    if result:
        print("\nUpdated compute instances:")
        compute_manager.list_compute_instances()