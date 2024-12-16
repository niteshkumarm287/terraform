resource "google_compute_instance" "example" {
  for_each = var.instances

  name         = each.value.uci_name
  machine_type = each.value.uci_machine_type
  zone         = each.value.uci_zone

  boot_disk {
    initialize_params {
      image = each.value.uci_image
    }
  }

  network_interface {
    network = each.value.uci_network
  }
}
