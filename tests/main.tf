module "test" {
  source = "../"

  project_id = "test-project-id"
  region     = "us-central1"

  # Feature Store
  enable_feature_store = true
  feature_store_name   = "test_feature_store"
  feature_store_online_serving_config = {
    fixed_node_count = 1
  }
  feature_store_entity_types = [
    {
      name        = "users"
      description = "User entity type"
      features = [
        {
          name        = "age"
          description = "User age"
          value_type  = "INT64"
        },
        {
          name        = "city"
          description = "User city"
          value_type  = "STRING"
        }
      ]
    }
  ]

  # Endpoints
  enable_endpoints = true
  endpoints = {
    "prediction-endpoint" = {
      name         = "test-prediction-endpoint"
      description  = "Test prediction endpoint"
      machine_type = "n1-standard-4"
      min_replicas = 1
      max_replicas = 3
    }
  }

  # Workbench
  enable_workbench = false

  # Tensorboard
  enable_tensorboard = true
  tensorboard_name   = "test-tensorboard"

  # Service Account
  service_account_id = "vertex-ai-test-sa"

  # Private Service Connect
  enable_private_service_connect = false

  labels = {
    environment = "test"
    managed_by  = "terraform"
  }
}
