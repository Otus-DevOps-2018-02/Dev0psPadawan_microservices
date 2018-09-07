provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}


# App Instance settings
resource "google_compute_instance" "dockerhost" {
  count = "${var.dockerhost_count}" # Create two instances

  name         = "docker-host-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["docker-host"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

# HTTP port
resource "google_compute_firewall" "app_dockerhost" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-host"]
}

# SSH port
resource "google_compute_firewall" "ssh_dockerhost" {
  name    = "allow-ssh-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-host"]
}
