resource "google_service_account" "vertex_ai" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = "Vertex AI Platform Service Account"
  description  = "Service account for Vertex AI workloads managed by Terraform."
}

resource "google_project_iam_member" "vertex_ai_roles" {
  for_each = toset([
    "roles/aiplatform.user",
    "roles/storage.objectAdmin",
    "roles/artifactregistry.reader",
    "roles/bigquery.dataEditor",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.vertex_ai.email}"
}

resource "google_artifact_registry_repository" "model_artifacts" {
  project       = var.project_id
  location      = var.region
  repository_id = "vertex-ai-model-artifacts"
  description   = "Repository for Vertex AI model artifacts."
  format        = "DOCKER"
  labels        = var.labels
}

resource "google_vertex_ai_featurestore" "main" {
  count = var.enable_feature_store ? 1 : 0

  project = var.project_id
  region  = var.region
  name    = var.feature_store_name
  labels  = var.labels

  online_serving_config {
    fixed_node_count = var.feature_store_online_serving_config.fixed_node_count
  }

  force_destroy = false
}

resource "google_vertex_ai_featurestore_entitytype" "entity_types" {
  for_each = var.enable_feature_store ? { for et in var.feature_store_entity_types : et.name => et } : {}

  featurestore = google_vertex_ai_featurestore.main[0].id
  name         = each.value.name
  description  = each.value.description
  labels       = var.labels
}

resource "google_vertex_ai_endpoint" "endpoints" {
  for_each = var.enable_endpoints ? var.endpoints : {}

  project      = var.project_id
  location     = var.region
  display_name = each.value.name
  description  = each.value.description
  labels       = var.labels

  network = var.enable_private_service_connect && var.network != null ? "projects/${data.google_project.current.number}/global/networks/${var.network}" : null
}

resource "google_workbench_instance" "instances" {
  for_each = {
    for idx, wb in var.workbench_instances : wb.name => wb
    if var.enable_workbench
  }

  project  = var.project_id
  location = "${var.region}-a"
  name     = each.value.name

  gce_setup {
    machine_type = each.value.machine_type

    dynamic "accelerator_configs" {
      for_each = each.value.accelerator_type != null ? [1] : []
      content {
        type       = each.value.accelerator_type
        core_count = 1
      }
    }

    boot_disk {
      disk_size_gb = each.value.boot_disk_size
      disk_type    = "PD_SSD"
    }

    data_disks {
      disk_size_gb = each.value.data_disk_size
      disk_type    = "PD_SSD"
    }

    service_accounts {
      email = google_service_account.vertex_ai.email
    }

    network_interfaces {
      network = var.network
      subnet  = var.subnetwork
    }
  }

  labels = var.labels
}

resource "google_vertex_ai_tensorboard" "main" {
  count = var.enable_tensorboard ? 1 : 0

  project      = var.project_id
  region       = var.region
  display_name = var.tensorboard_name
  labels       = var.labels
}
