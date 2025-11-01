# Azure ML Local Development Environment Setup

Complete guide for setting up a local development environment for Azure Machine Learning using Python SDK on macOS, Ubuntu Linux, and Windows (WSL).

## Table of Contents

- [Prerequisites](#prerequisites)
- [OS-Specific Initial Setup](#os-specific-initial-setup)
  - [macOS Setup](#macos-setup)
  - [Ubuntu Linux Setup](#ubuntu-linux-setup)
  - [Windows WSL Setup](#windows-wsl-setup)
- [Common Setup (All Operating Systems)](#common-setup-all-operating-systems)
- [VS Code Configuration](#vs-code-configuration)
- [Testing Your Setup](#testing-your-setup)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Next Steps](#next-steps)

## Prerequisites

The following tools are required for all operating systems:

- **pyenv** - Python version management
- **Poetry** - Python dependency management
- **VS Code** - with Python extension
- **Git** - version control

## OS-Specific Initial Setup

### macOS Setup

#### Install Homebrew (if not already installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install pyenv

```bash
# Install pyenv
brew install pyenv

# Add pyenv to your shell configuration
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Reload shell configuration
source ~/.zshrc
```

#### Install Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Add Poetry to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### Verify Installations

```bash
pyenv --version
poetry --version
```

---

### Ubuntu Linux Setup

#### Update System Packages

```bash
sudo apt update && sudo apt upgrade -y
```

#### Install Build Dependencies

```bash
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev git
```

#### Install pyenv

```bash
# Clone pyenv repository
curl https://pyenv.run | bash

# Add pyenv to your shell configuration
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Reload shell configuration
source ~/.bashrc
```

#### Install Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Add Poetry to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### Verify Installations

```bash
pyenv --version
poetry --version
```

---

### Windows WSL Setup

#### Enable WSL (if not already enabled)

Open PowerShell as Administrator and run:

```powershell
wsl --install
```

This will install Ubuntu by default. Restart your computer if prompted.

#### Launch Ubuntu and Update

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y
```

#### Install Build Dependencies

```bash
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev git
```

#### Install pyenv

```bash
# Clone pyenv repository
curl https://pyenv.run | bash

# Add pyenv to your shell configuration
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Reload shell configuration
source ~/.bashrc
```

#### Install Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Add Poetry to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### Verify Installations

```bash
pyenv --version
poetry --version
```

#### Install VS Code with WSL Extension

1. Install VS Code on Windows
2. Install the "Remote - WSL" extension
3. Open WSL from VS Code: Press `F1` and type "WSL: Connect to WSL"

---

## Common Setup (All Operating Systems)

Once the prerequisites are installed, follow these steps on any OS:

### 1. Create Project Structure

```bash
# Create a new project directory
mkdir azure-ml-project
cd azure-ml-project

# Open VS Code in project root
code .

# From VS Code terminal, create notebooks directory
mkdir notebooks
cd notebooks
```

### 2. Python Environment Setup

```bash
# Install Python 3.10
pyenv install 3.10

# Set Python 3.10 as local version for this project
pyenv local 3.10

# Confirm your Python version
python --version
# Expected output: Python 3.10.x
```

### 3. Initialize Poetry Project

```bash
# Initialize a new Poetry project
poetry init --name azure-ml-project --python ">=3.10,<3.11"

# Follow the interactive prompts (you can press Enter to accept defaults)

# Configure Poetry to store the virtual environment in the project directory
poetry config virtualenvs.in-project true

# Create and activate the environment
poetry env use python
```

### 4. Install Azure ML Dependencies

```bash
# Install all required packages
poetry add azure-ai-ml azure-identity matplotlib pandas numpy ipykernel jupyter notebook
```

This will install:
- **azure-ai-ml**: Azure Machine Learning SDK
- **azure-identity**: Azure authentication
- **matplotlib**: Data visualization
- **pandas**: Data manipulation
- **numpy**: Numerical computing
- **ipykernel**: Jupyter kernel support
- **jupyter**: Jupyter notebook interface
- **notebook**: Classic notebook interface

---

## VS Code Configuration

### Set Up Python Interpreter

1. Open the Command Palette:
   - **macOS**: `CMD + SHIFT + P`
   - **Windows/Linux**: `CTRL + SHIFT + P`

2. Type and select: `Python: Select Interpreter`

3. Find your interpreter path by running:
   ```bash
   poetry env info
   ```

4. Look for the **Executable** path under **Virtualenv** section. 

   **Example output (macOS/Linux):**
   ```
   Virtualenv
   Python:         3.10.15
   Implementation: CPython
   Path:           /home/username/repos/azure-ml/notebooks/.venv
   Executable:     /home/username/repos/azure-ml/notebooks/.venv/bin/python
   Valid:          True
   ```

   **Example output (WSL):**
   ```
   Virtualenv
   Python:         3.10.15
   Implementation: CPython
   Path:           /home/username/azure-ml-project/notebooks/.venv
   Executable:     /home/username/azure-ml-project/notebooks/.venv/bin/python
   Valid:          True
   ```

5. Copy the **Executable** path
6. Paste it into the interpreter prompt in VS Code and confirm

---

## Testing Your Setup

### Create a Test Notebook

```bash
# Inside the notebooks directory
touch azure-sdk.ipynb
```

### Configure Notebook Kernel

1. Open `azure-sdk.ipynb` in VS Code
2. Click on **Select Kernel** (top-right corner or from the Kernel menu)
3. Choose **Python Environments...**
4. Select the Python environment associated with your Poetry environment (`.venv`)
5. Remove any incorrect kernel options if multiple appear

### Verify Installation

Add the following code to your notebook and run it:

```python
# Test Azure ML SDK installation
import azure.ai.ml
from azure.ai.ml import MLClient
from azure.identity import DefaultAzureCredential
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

print("✅ All packages imported successfully!")
print(f"Azure ML SDK version: {azure.ai.ml.__version__}")
print(f"Pandas version: {pd.__version__}")
print(f"NumPy version: {np.__version__}")

# Test basic functionality
data = {'A': [1, 2, 3], 'B': [4, 5, 6]}
df = pd.DataFrame(data)
print("\nSample DataFrame:")
print(df)
```

---

## Project Structure

Your final project structure should look like:

```
azure-ml-project/
├── notebooks/
│   ├── .venv/              # Virtual environment
│   ├── azure-sdk.ipynb     # Test notebook
│   ├── pyproject.toml      # Poetry dependencies
│   └── poetry.lock         # Locked dependencies
├── .python-version         # pyenv Python version
└── README.md               # This file
```

---

## Troubleshooting

### Issue: Python Version Not Found

**Problem**: `pyenv install 3.10` fails or Python version not available.

**Solution**:
```bash
# Update pyenv
# For macOS
brew upgrade pyenv

# For Linux/WSL
cd ~/.pyenv
git pull
```

### Issue: Kernel Not Found in VS Code

**Problem**: Your kernel doesn't appear in VS Code.

**Solution**:
1. Restart VS Code
2. Run `poetry env info` again to verify the environment
3. Manually select the interpreter using the full path from `poetry env info`
4. Ensure the Python extension is installed in VS Code

### Issue: Package Import Errors

**Problem**: `ModuleNotFoundError` when importing packages.

**Solution**:
```bash
# Verify packages are installed
poetry show

# Reinstall if needed
poetry install

# Verify you're using the correct kernel in the notebook
poetry env info
```

### Issue: Poetry Environment Issues

**Problem**: Virtual environment is corrupted or not working properly.

**Solution**:
```bash
# Remove existing environment
poetry env remove python

# Recreate environment
poetry env use python

# Reinstall dependencies
poetry install
```

### Issue: WSL Performance

**Problem**: Slow file operations in WSL.

**Solution**:
- Work within the Linux filesystem (`/home/username/`) rather than Windows filesystem (`/mnt/c/`)
- Your project should be created in `~/repos/` or similar Linux path

### Issue: Shell Configuration Not Loading (macOS)

**Problem**: Commands not found after installation.

**Solution**:
```bash
# For macOS (if using zsh)
source ~/.zshrc

# If using bash
source ~/.bashrc
```

### Issue: Permission Denied (Linux/WSL)

**Problem**: Permission errors when installing packages.

**Solution**:
```bash
# Don't use sudo with Poetry or pyenv
# If you accidentally used sudo, fix ownership:
sudo chown -R $USER:$USER ~/.pyenv
sudo chown -R $USER:$USER ~/.local
```

---

## Next Steps

Now that your environment is set up, you can:

1. **Connect to Azure ML Workspace**
   ```python
   from azure.ai.ml import MLClient
   from azure.identity import DefaultAzureCredential
   
   ml_client = MLClient(
       DefaultAzureCredential(),
       subscription_id="<your-subscription-id>",
       resource_group_name="<your-resource-group>",
       workspace_name="<your-workspace-name>"
   )
   ```

2. **Create and manage compute resources**
3. **Submit training jobs**
4. **Deploy models**
5. **Monitor experiments**


---

## OS-Specific Tips

### macOS
- Use Homebrew to keep tools updated: `brew upgrade pyenv poetry`
- If using an M1/M2 Mac, ensure Rosetta 2 is installed for compatibility: `softwareupdate --install-rosetta`

### Ubuntu Linux
- Keep system packages updated: `sudo apt update && sudo apt upgrade`
- Consider using `tmux` or `screen` for long-running processes

### Windows WSL
- Access Windows files from WSL: `/mnt/c/Users/YourUsername/`
- Access WSL files from Windows: `\\wsl$\Ubuntu\home\username\`
- Use Windows Terminal for better WSL experience
- Keep WSL updated: `wsl --update`

---

**✅ You're now ready to begin building, training, and deploying ML models locally with full support from the Azure ML SDK!**

---

*Last Updated: November 2025*