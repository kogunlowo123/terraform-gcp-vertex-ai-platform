data "google_project" "current" {
  project_id = var.project_id
}

data "google_compute_network" "vpc" {
  count   = var.network != null ? 1 : 0
  project = var.project_id
  name    = var.network
}

data "google_compute_subnetwork" "subnet" {
  count   = var.subnetwork != null ? 1 : 0
  project = var.project_id
  name    = var.subnetwork
  region  = var.region
}
