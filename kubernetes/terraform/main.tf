provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  initial_node_count = 1

  addons_config {
    kubernetes_dashboard {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  master_auth {
    username = "${var.username}"
    password = "${var.password}"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = "${google_container_cluster.primary.name}"
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
    ]
  }
}

resource "google_compute_firewall" "k8s_firewall" {
  name    = "allow-k8s-ui"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# The following outputs allow authentication and connectivity to the GKE Cluster
# by using certificate-based authentication.
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
