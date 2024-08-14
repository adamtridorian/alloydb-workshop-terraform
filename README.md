1. Ensure you have Python installed
To check your current Python version, run python3 -V or python -V. Supported versions are Python 3.8 to 3.12.

2. Install gcloud CLI
https://cloud.google.com/sdk/docs/install#mac

3. Config gcloud CLI
gcloud auth login
gcloud config set project <PROJECT_ID>
gcloud init

4. Replace project ID in vars.tf

5. Install Terraform and Initialize
https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli
terraform init

6. Run terraform with 
terraform apply