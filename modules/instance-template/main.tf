resource "google_compute_instance_template" "demo-1" {

    name = var.cit_name
    description = var.cit_description
    tags = var.cit_tags

    labels = {
        environment = var.cit_labels
    }
    machine_type = var.cit_machine_type
    can_ip_forward = var.cit_can_ip_forward

    scheduling {
      automatic_restart = var.cit_automatic_restart
      on_host_maintenance = var.cit_on_host_maintenance
    }

    disk {
      source_image = var.cit_source_image
      auto_delete = var.cit_auto_delete
      boot = var.cit_boot
    }

    network_interface {
      network = var.cit_network
    }

  
}