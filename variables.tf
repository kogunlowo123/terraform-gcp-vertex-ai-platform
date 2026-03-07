variable "project_id" {
  description = "The GCP project ID where Vertex AI resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region for Vertex AI resources."
  type        = string
}

variable "network" {
  description = "The VPC network self-link for private connectivity."
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "The subnetwork self-link for private connectivity."
  type        = string
  default     = null
}

# -----------------------------------------------------------------------------
# Feature Store
# -----------------------------------------------------------------------------

variable "enable_feature_store" {
  description = "Whether to create the Vertex AI Feature Store."
  type        = bool
  default     = true
}

variable "feature_store_name" {
  description = "The name of the Vertex AI Feature Store."
  type        = string
  default     = "default_feature_store"
}

variable "feature_store_online_serving_config" {
  description = "Online serving configuration for the Feature Store."
  type = object({
    fixed_node_count = optional(number, 1)
  })
  default = {
    fixed_node_count = 1
  }
}

variable "feature_store_entity_types" {
  description = "List of entity types to create in the Feature Store."
  type = list(object({
    name        = string
    description = optional(string, "")
    features = optional(list(object({
      name        = string
      description = optional(string, "")
      value_type  = string
    })), [])
  }))
  default = []
}

# -----------------------------------------------------------------------------
# Endpoints
# -----------------------------------------------------------------------------

variable "enable_endpoints" {
  description = "Whether to create Vertex AI Endpoints."
  type        = bool
  default     = true
}

variable "endpoints" {
  description = "Map of Vertex AI Endpoint configurations."
  type = map(object({
    name         = string
    description  = optional(string, "")
    machine_type = optional(string, "n1-standard-4")
    min_replicas = optional(number, 1)
    max_replicas = optional(number, 1)
  }))
  default = {}
}

# -----------------------------------------------------------------------------
# Workbench
# -----------------------------------------------------------------------------

variable "enable_workbench" {
  description = "Whether to create Workbench instances."
  type        = bool
  default     = true
}

variable "workbench_instances" {
  description = "List of Workbench instance configurations."
  type = list(object({
    name             = string
    machine_type     = optional(string, "e2-standard-4")
    accelerator_type = optional(string, null)
    boot_disk_size   = optional(number, 150)
    data_disk_size   = optional(number, 100)
  }))
  default = []
}

# -----------------------------------------------------------------------------
# Tensorboard
# -----------------------------------------------------------------------------

variable "enable_tensorboard" {
  description = "Whether to create a Vertex AI Tensorboard instance."
  type        = bool
  default     = true
}

variable "tensorboard_name" {
  description = "The display name for the Vertex AI Tensorboard instance."
  type        = string
  default     = "default-tensorboard"
}

# -----------------------------------------------------------------------------
# Service Account & IAM
# -----------------------------------------------------------------------------

variable "service_account_id" {
  description = "The service account ID (name) for Vertex AI workloads."
  type        = string
  default     = "vertex-ai-sa"
}

# -----------------------------------------------------------------------------
# Private Service Connect
# -----------------------------------------------------------------------------

variable "enable_private_service_connect" {
  description = "Whether to enable Private Service Connect for endpoints."
  type        = bool
  default     = true
}

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

variable "labels" {
  description = "A map of labels to apply to all resources that support labels."
  type        = map(string)
  default     = {}
}
