output "feature_store_id" {
  description = "The Feature Store ID."
  value       = module.vertex_ai_platform.feature_store_id
}

output "feature_store_entity_type_ids" {
  description = "Map of entity type IDs."
  value       = module.vertex_ai_platform.feature_store_entity_type_ids
}

output "endpoint_ids" {
  description = "Map of endpoint IDs."
  value       = module.vertex_ai_platform.endpoint_ids
}

output "workbench_instance_ids" {
  description = "Map of Workbench instance IDs."
  value       = module.vertex_ai_platform.workbench_instance_ids
}

output "tensorboard_id" {
  description = "The Tensorboard instance ID."
  value       = module.vertex_ai_platform.tensorboard_id
}

output "service_account_email" {
  description = "The service account email."
  value       = module.vertex_ai_platform.service_account_email
}

output "artifact_registry_url" {
  description = "The Artifact Registry repository URL."
  value       = module.vertex_ai_platform.artifact_registry_repository_url
}
