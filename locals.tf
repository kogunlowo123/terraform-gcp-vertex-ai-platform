locals {
  project_id = var.project_id
  region     = var.region

  # Merge user-supplied labels with default labels
  default_labels = {
    managed-by = "terraform"
    module     = "vertex-ai-platform"
  }
  labels = merge(local.default_labels, var.labels)

  # Service account email constructed from the resource
  service_account_email = google_service_account.vertex_ai.email

  # IAM roles required for the Vertex AI service account
  vertex_ai_iam_roles = [
    "roles/aiplatform.user",
    "roles/storage.objectAdmin",
    "roles/artifactregistry.reader",
    "roles/bigquery.dataEditor",
  ]

  # Build a map of entity types for iteration
  entity_types_map = {
    for et in var.feature_store_entity_types : et.name => et
  }

  # Build a flat map of features across all entity types
  features_flat = merge([
    for et in var.feature_store_entity_types : {
      for f in et.features : "${et.name}/${f.name}" => {
        entity_type_name = et.name
        name             = f.name
        description      = f.description
        value_type       = f.value_type
      }
    }
  ]...)
}
