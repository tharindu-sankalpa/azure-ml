from azure.ai.ml import MLClient
from azure.identity import DefaultAzureCredential

# Initialize the ML client
ml_client = MLClient(
    credential=DefaultAzureCredential(),
    subscription_id="89ac6d39-455b-40fa-a35d-404abf0eba90",
    resource_group_name="tharinduMLRG",
    workspace_name="tharinduMLWorkspace"
)

# List all environments
envs = ml_client.environments.list()
for env in envs:
    print(env.name)