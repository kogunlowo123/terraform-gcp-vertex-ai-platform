# Terraform GCP Vertex AI Platform

Terraform module for deploying a complete Vertex AI MLOps infrastructure on Google Cloud Platform.

## Features

- **Feature Store** -- Managed feature store with configurable entity types and features for online/offline serving.
- **Model Registry & Artifact Registry** -- Docker-format Artifact Registry repository for storing model artifacts and container images.
- **Endpoints** -- Vertex AI prediction endpoints with optional Private Service Connect.
- **Workbench** -- Managed Workbench notebook instances with optional GPU accelerators.
- **Tensorboard** -- Vertex AI Tensorboard for experiment tracking and visualization.
- **IAM** -- Dedicated service account with least-privilege roles for Vertex AI workloads.

## Usage

```hcl
module "vertex_ai_platform" {
  source = "github.com/kogunlowo123/terraform-gcp-vertex-ai-platform"

  project_id = "my-gcp-project"
  region     = "us-central1"
  network    = "my-vpc"
  subnetwork = "my-subnet"

  enable_feature_store = true
  feature_store_name   = "my-feature-store"

  feature_store_entity_types = [
    {
      name        = "users"
      description = "User features"
      features = [
        {
          name       = "age"
          value_type = "INT64"
        },
      ]
    },
  ]

  enable_endpoints = true
  endpoints = {
    prediction = {
      name         = "prediction-endpoint"
      machine_type = "n1-standard-4"
      min_replicas = 1
      max_replicas = 5
    }
  }

  enable_workbench = true
  workbench_instances = [
    {
      name         = "dev-notebook"
      machine_type = "e2-standard-4"
    },
  ]

  enable_tensorboard = true
  tensorboard_name   = "my-tensorboard"

  service_account_id = "vertex-ai-sa"

  labels = {
    environment = "dev"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| google | >= 5.10.0 |
| google-beta | >= 5.10.0 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_id | GCP project ID | `string` | n/a |
| region | GCP region | `string` | n/a |
| network | VPC network name | `string` | `null` |
| subnetwork | Subnetwork name | `string` | `null` |
| enable_feature_store | Enable Feature Store | `bool` | `true` |
| feature_store_name | Feature Store name | `string` | `"default_feature_store"` |
| feature_store_online_serving_config | Online serving config | `object` | `{ fixed_node_count = 1 }` |
| feature_store_entity_types | Entity types list | `list(object)` | `[]` |
| enable_endpoints | Enable Endpoints | `bool` | `true` |
| endpoints | Endpoint configurations | `map(object)` | `{}` |
| enable_workbench | Enable Workbench | `bool` | `true` |
| workbench_instances | Workbench instance configs | `list(object)` | `[]` |
| enable_tensorboard | Enable Tensorboard | `bool` | `true` |
| tensorboard_name | Tensorboard display name | `string` | `"default-tensorboard"` |
| service_account_id | Service account ID | `string` | `"vertex-ai-sa"` |
| enable_private_service_connect | Enable PSC for endpoints | `bool` | `true` |
| labels | Resource labels | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| service_account_email | Vertex AI service account email |
| artifact_registry_repository_id | Artifact Registry repository ID |
| artifact_registry_repository_url | Artifact Registry repository URL |
| feature_store_id | Feature Store ID |
| feature_store_entity_type_ids | Map of entity type IDs |
| endpoint_ids | Map of endpoint IDs |
| workbench_instance_ids | Map of Workbench instance IDs |
| tensorboard_id | Tensorboard instance ID |

## Examples

- [Basic](./examples/basic/) -- Minimal deployment with Tensorboard and a single endpoint.
- [Advanced](./examples/advanced/) -- Feature Store, multiple endpoints, Workbench with GPU, and private networking.
- [Complete](./examples/complete/) -- Full production deployment with all components enabled.

## License

MIT License. See [LICENSE](./LICENSE) for details.
