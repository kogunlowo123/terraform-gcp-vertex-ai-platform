output "tensorboard_id" {
  description = "The Tensorboard instance ID."
  value       = module.vertex_ai_platform.tensorboard_id
}

output "endpoint_ids" {
  description = "Map of endpoint IDs."
  value       = module.vertex_ai_platform.endpoint_ids
}

output "service_account_email" {
  description = "The service account email."
  value       = module.vertex_ai_platform.service_account_email
}
