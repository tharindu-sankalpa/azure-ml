# **Learning Objectives for Azure Machine Learning (Hands-On Machine Learning - HOML)**

1. **Foundational Concepts**
   - Understand the key building blocks of Azure Machine Learning:
     - **ML Workspace**: Setting up and managing an Azure ML workspace.
     - **ML Studio**: Navigating the UI for experiments, datasets, models, endpoints, etc.
     - **Compute Targets**: Different compute targets and how to manage them.
     - **Data Stores**: Connecting to external and internal storage solutions.
     - **Data Assets**: How to create, register, and version datasets.


2. **Training Jobs and Compute Targets**
   - Learn how to submit training jobs using the **Azure SDK** (Python).
   - Understand different **compute targets** and when to use each:
     - **Compute Instances**
     - **Compute Clusters**
     - **Kubernetes Clusters (AKS)**
     - **Custom Servers / On-Premise Targets**

3. **Experimentation & MLflow Integration**
   - Explore **MLflow** for experiment tracking:
     - Logging parameters, metrics, and artifacts.
     - Registering trained models.
   - Understand how MLflow integrates with Azure ML for lifecycle tracking.

4. **Model Deployment & Real-Time Inference**
   - Learn how to deploy registered models to various endpoints.
   - Understand how to send **real-time inference requests** and validate predictions.

5. **Model Monitoring**
   - Track model performance post-deployment.
   - Understand data drift, prediction drift, and logging for production models.

6. **Operationalizing ML with Pipelines**
   - Build **end-to-end ML pipelines** using the Azure SDK:
     - Data preprocessing
     - Model training
     - Model registration
     - Model deployment
     - Testing and inference
   - Automate the pipeline for CI/CD and reproducibility.

7. **Azure ML Designer**
   - Explore **Azure ML Designer** (UI-based pipeline builder):
     - Learn available components.
     - Understand input/output data flows.
     - Build and deploy pipelines through a drag-and-drop interface.

8. **AutoML in Azure**
   - Understand Azure **AutoML** and its capabilities.
   - Learn different AutoML flavors (classification, regression, forecasting).
   - Train, evaluate, and deploy models using AutoML.
