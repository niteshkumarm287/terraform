resource "google_compute_instance" "test1" {
  name         = var.instance-name
  machine_type = var.machine_type
  zone         = var.zone

  # Boot disk configuration
  boot_disk {
    initialize_params {
      image = var.boot_disk
    }
  }

  # Network configuration
  network_interface {
    network = "default"
  }

  # Tags
  tags = var.tags
}
