module "compute_instance" {
  source = "./modules/compute-instance"
  instance-name = var.instance-name
  machine_type  = var.machine_type
  zone          = var.zone
  boot_disk     = var.boot_disk
  tags          = var.tags
}

module "google_service_account" {
  source = "./modules/service-account"
  account_id = var.account_id
  display_name = var.display_name

}

module "google_container_cluster" {
    source = "./modules/gke-cluster"
    name = var.name
    location = var.location
    remove_default_node_pool = var.remove_default_node_pool
    initial_node_count = var.initial_node_count
  
}


module "google_compute_instance_template" {
  source                 = "./modules/instance-template"
  cit_name               = var.cit_name
  cit_description        = var.cit_description
  cit_tags               = var.cit_tags
  cit_labels             = var.cit_labels
  cit_environment        = var.cit_environment
  cit_machine_type       = var.cit_machine_type
  cit_can_ip_forward     = var.cit_can_ip_forward
  cit_automatic_restart  = var.cit_automatic_restart
  cit_on_host_maintenance = var.cit_on_host_maintenance
  cit_source_image       = var.cit_source_image
  cit_auto_delete        = var.cit_auto_delete
  cit_boot               = var.cit_boot
  cit_network            = var.cit_network
}
