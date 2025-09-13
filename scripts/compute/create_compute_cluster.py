#!/usr/bin/env python3
"""
Create Azure ML Compute Cluster
"""
import json
from azure.identity import DefaultAzureCredential
from azure.ai.ml import MLClient
from azure.ai.ml.entities import AmlCompute

class AzureMLComputeManager:
    """Manager class for Azure ML compute operations"""
    
    def __init__(self, config_path="../../notebooks/config.json"):
        """Initialize the compute manager with configuration"""
        self.config_path = config_path
        self.ml_client = self._initialize_client()
    
    def _initialize_client(self):
        """Initialize and return ML Client"""
        with open(self.config_path) as f:
            config = json.load(f)
        
        credential = DefaultAzureCredential()
        return MLClient(
            credential=credential,
            subscription_id=config["subscription_id"],
            resource_group_name=config["resource_group"],
            workspace_name=config["workspace_name"]
        )
    
    def create_compute_cluster(self, cluster_name="training-cluster", 
                             vm_size="Standard_F2s_v2", min_instances=0, 
                             max_instances=4, idle_time=900):
        """Create a compute cluster"""
        compute_cluster = AmlCompute(
            name=cluster_name,
            size=vm_size,
            min_instances=min_instances,
            max_instances=max_instances,
            idle_time_before_scale_down=idle_time,
            tier="Dedicated",
            description="Training cluster for ML workloads"
        )
        
        print("Creating compute cluster...")
        try:
            # Check if cluster already exists
            try:
                existing_cluster = self.ml_client.compute.get(cluster_name)
                print(f"Compute cluster '{cluster_name}' already exists.")
                self._print_cluster_info(existing_cluster)
                return existing_cluster
            except:
                pass
            
            operation = self.ml_client.compute.begin_create_or_update(compute_cluster)
            result = operation.result()
            print(f"Compute cluster '{result.name}' created successfully!")
            self._print_cluster_info(result)
            return result
            
        except Exception as e:
            print(f"Error creating compute cluster: {e}")
            return None
    
    def list_compute_clusters(self):
        """List existing compute clusters"""
        print("\nExisting compute clusters:")
        compute_clusters = self.ml_client.compute.list(compute_type="AmlCompute")
        for cluster in compute_clusters:
            print(f"- {cluster.name}: {cluster.provisioning_state} ({cluster.size})")
            print(f"  Min: {cluster.min_instances}, Max: {cluster.max_instances}")
    
    def _print_cluster_info(self, cluster):
        """Helper method to print cluster information"""
        print(f"State: {cluster.provisioning_state}")
        print(f"Size: {cluster.size}")
        print(f"Min instances: {cluster.min_instances}")
        print(f"Max instances: {cluster.max_instances}")

if __name__ == "__main__":
    # Initialize compute manager
    compute_manager = AzureMLComputeManager()
    
    # List existing clusters
    compute_manager.list_compute_clusters()
    
    # Create new cluster
    result = compute_manager.create_compute_cluster()
    
    if result:
        print("\nUpdated compute clusters:")
        compute_manager.list_compute_clusters()