module "compute_instance" {
  source = "./modules/compute-instance"
  instance-name = var.instance-name
  machine_type  = var.machine_type
  zone          = var.zone
  boot_disk     = var.boot_disk
  tags          = var.tags

}
