# =============================================================================
# Service Account
# =============================================================================

output "service_account_email" {
  description = "The email address of the Vertex AI service account."
  value       = google_service_account.vertex_ai.email
}

output "service_account_id" {
  description = "The fully-qualified ID of the Vertex AI service account."
  value       = google_service_account.vertex_ai.id
}

# =============================================================================
# Artifact Registry
# =============================================================================

output "artifact_registry_repository_id" {
  description = "The ID of the Artifact Registry repository for model artifacts."
  value       = google_artifact_registry_repository.model_artifacts.id
}

output "artifact_registry_repository_url" {
  description = "The URL of the Artifact Registry repository."
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.model_artifacts.repository_id}"
}

# =============================================================================
# Feature Store
# =============================================================================

output "feature_store_id" {
  description = "The ID of the Vertex AI Feature Store."
  value       = var.enable_feature_store ? google_vertex_ai_featurestore.main[0].id : null
}

output "feature_store_name" {
  description = "The name of the Vertex AI Feature Store."
  value       = var.enable_feature_store ? google_vertex_ai_featurestore.main[0].name : null
}

output "feature_store_entity_type_ids" {
  description = "Map of entity type names to their IDs."
  value = {
    for name, et in google_vertex_ai_featurestore_entitytype.entity_types : name => et.id
  }
}

# =============================================================================
# Endpoints
# =============================================================================

output "endpoint_ids" {
  description = "Map of endpoint keys to their IDs."
  value = {
    for key, ep in google_vertex_ai_endpoint.endpoints : key => ep.id
  }
}

output "endpoint_names" {
  description = "Map of endpoint keys to their resource names."
  value = {
    for key, ep in google_vertex_ai_endpoint.endpoints : key => ep.name
  }
}

# =============================================================================
# Workbench
# =============================================================================

output "workbench_instance_ids" {
  description = "Map of Workbench instance names to their IDs."
  value = {
    for name, wb in google_workbench_instance.instances : name => wb.id
  }
}

output "workbench_instance_proxy_uris" {
  description = "Map of Workbench instance names to their proxy URIs."
  value = {
    for name, wb in google_workbench_instance.instances : name => wb.proxy_uri
  }
}

# =============================================================================
# Tensorboard
# =============================================================================

output "tensorboard_id" {
  description = "The ID of the Vertex AI Tensorboard instance."
  value       = var.enable_tensorboard ? google_vertex_ai_tensorboard.main[0].id : null
}

output "tensorboard_name" {
  description = "The resource name of the Vertex AI Tensorboard instance."
  value       = var.enable_tensorboard ? google_vertex_ai_tensorboard.main[0].name : null
}
