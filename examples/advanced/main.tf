module "vertex_ai_platform" {
  source = "../../"

  project_id = "my-gcp-project"
  region     = "us-central1"
  network    = "vertex-ai-vpc"
  subnetwork = "vertex-ai-subnet"

  # Feature Store with entity types
  enable_feature_store = true
  feature_store_name   = "advanced-feature-store"

  feature_store_online_serving_config = {
    fixed_node_count = 3
  }

  feature_store_entity_types = [
    {
      name        = "users"
      description = "User entity type for recommendation features"
      features = [
        {
          name        = "age"
          description = "User age"
          value_type  = "INT64"
        },
        {
          name        = "purchase_count"
          description = "Total number of purchases"
          value_type  = "INT64"
        },
        {
          name        = "embedding"
          description = "User embedding vector"
          value_type  = "DOUBLE_ARRAY"
        },
      ]
    },
    {
      name        = "products"
      description = "Product entity type"
      features = [
        {
          name        = "category"
          description = "Product category"
          value_type  = "STRING"
        },
        {
          name        = "price"
          description = "Product price"
          value_type  = "DOUBLE"
        },
      ]
    },
  ]

  # Multiple endpoints
  enable_endpoints = true
  endpoints = {
    recommendation = {
      name         = "recommendation-endpoint"
      description  = "Recommendation model endpoint"
      machine_type = "n1-standard-8"
      min_replicas = 2
      max_replicas = 10
    }
    scoring = {
      name         = "scoring-endpoint"
      description  = "Real-time scoring endpoint"
      machine_type = "n1-standard-4"
      min_replicas = 1
      max_replicas = 5
    }
  }

  # Workbench
  enable_workbench = true
  workbench_instances = [
    {
      name             = "ml-engineer-notebook"
      machine_type     = "n1-standard-8"
      accelerator_type = "NVIDIA_TESLA_T4"
      boot_disk_size   = 200
      data_disk_size   = 500
    },
  ]

  # Tensorboard
  enable_tensorboard = true
  tensorboard_name   = "advanced-tensorboard"

  service_account_id = "vertex-ai-advanced-sa"

  enable_private_service_connect = true

  labels = {
    environment = "staging"
    team        = "ml-platform"
  }
}
