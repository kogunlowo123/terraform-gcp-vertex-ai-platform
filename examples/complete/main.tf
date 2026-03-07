module "vertex_ai_platform" {
  source = "../../"

  project_id = "my-gcp-project"
  region     = "us-central1"
  network    = "ml-platform-vpc"
  subnetwork = "ml-platform-subnet"

  # Feature Store – full configuration
  enable_feature_store = true
  feature_store_name   = "production-feature-store"

  feature_store_online_serving_config = {
    fixed_node_count = 5
  }

  feature_store_entity_types = [
    {
      name        = "customers"
      description = "Customer entity type for churn and LTV models"
      features = [
        {
          name        = "lifetime_value"
          description = "Predicted customer lifetime value"
          value_type  = "DOUBLE"
        },
        {
          name        = "churn_score"
          description = "Churn probability score"
          value_type  = "DOUBLE"
        },
        {
          name        = "signup_date"
          description = "Customer signup timestamp"
          value_type  = "STRING"
        },
        {
          name        = "segment"
          description = "Customer segment label"
          value_type  = "STRING"
        },
      ]
    },
    {
      name        = "transactions"
      description = "Transaction entity type for fraud detection"
      features = [
        {
          name        = "amount"
          description = "Transaction amount"
          value_type  = "DOUBLE"
        },
        {
          name        = "is_fraudulent"
          description = "Whether the transaction is fraudulent"
          value_type  = "BOOL"
        },
        {
          name        = "merchant_category"
          description = "Merchant category code"
          value_type  = "STRING"
        },
      ]
    },
    {
      name        = "items"
      description = "Item entity type for recommendation engine"
      features = [
        {
          name        = "category"
          description = "Item category"
          value_type  = "STRING"
        },
        {
          name        = "embedding"
          description = "Item embedding vector"
          value_type  = "DOUBLE_ARRAY"
        },
        {
          name        = "popularity_score"
          description = "Item popularity score"
          value_type  = "DOUBLE"
        },
      ]
    },
  ]

  # Multiple prediction endpoints
  enable_endpoints = true
  endpoints = {
    churn_prediction = {
      name         = "churn-prediction-endpoint"
      description  = "Customer churn prediction model endpoint"
      machine_type = "n1-standard-8"
      min_replicas = 2
      max_replicas = 20
    }
    fraud_detection = {
      name         = "fraud-detection-endpoint"
      description  = "Real-time fraud detection endpoint"
      machine_type = "n1-highmem-8"
      min_replicas = 3
      max_replicas = 50
    }
    recommendation = {
      name         = "recommendation-endpoint"
      description  = "Product recommendation endpoint"
      machine_type = "n1-standard-16"
      min_replicas = 2
      max_replicas = 30
    }
  }

  # Workbench instances for different teams
  enable_workbench = true
  workbench_instances = [
    {
      name             = "data-scientist-notebook"
      machine_type     = "n1-standard-16"
      accelerator_type = "NVIDIA_TESLA_V100"
      boot_disk_size   = 200
      data_disk_size   = 1000
    },
    {
      name             = "ml-engineer-notebook"
      machine_type     = "n1-standard-8"
      accelerator_type = "NVIDIA_TESLA_T4"
      boot_disk_size   = 200
      data_disk_size   = 500
    },
    {
      name             = "analyst-notebook"
      machine_type     = "e2-standard-4"
      accelerator_type = null
      boot_disk_size   = 150
      data_disk_size   = 200
    },
  ]

  # Tensorboard
  enable_tensorboard = true
  tensorboard_name   = "production-tensorboard"

  service_account_id = "vertex-ai-prod-sa"

  enable_private_service_connect = true

  labels = {
    environment = "production"
    team        = "ml-platform"
    cost-center = "ml-ops"
    managed-by  = "terraform"
  }
}
