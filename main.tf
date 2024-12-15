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