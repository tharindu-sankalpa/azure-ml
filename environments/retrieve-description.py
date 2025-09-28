from azure.ai.ml import MLClient
from azure.identity import DefaultAzureCredential

# Initialize the ML client
ml_client = MLClient(
    credential=DefaultAzureCredential(),
    subscription_id="89ac6d39-455b-40fa-a35d-404abf0eba90",
    resource_group_name="tharinduMLRG",
    workspace_name="tharinduMLWorkspace"
)

# Then you can get the environment
env = ml_client.environments.get("AzureML-sklearn-0.24-ubuntu18.04-py37-cpu", version=44)
print(env.description, env.tags)
