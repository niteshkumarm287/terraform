resource "google_compute_instance" "test1" {
  count        = var.instance_count
  name         = "${var.instance-name}-${count.index + 1}"
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
