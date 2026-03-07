module "vertex_ai_platform" {
  source = "../../"

  project_id = "my-gcp-project"
  region     = "us-central1"

  # Enable only Tensorboard and Endpoints with minimal config
  enable_feature_store = false
  enable_workbench     = false
  enable_tensorboard   = true

  tensorboard_name = "basic-tensorboard"

  enable_endpoints = true
  endpoints = {
    prediction = {
      name        = "basic-prediction-endpoint"
      description = "Basic prediction endpoint"
    }
  }

  service_account_id = "vertex-ai-basic-sa"

  enable_private_service_connect = false

  labels = {
    environment = "dev"
  }
}
