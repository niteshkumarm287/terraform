# compute instance variables
instance_count = 2
instance-name = "web-server"
machine_type  = "n2-standard-2"
zone          = "us-central1-a"
boot_disk     = "debian-cloud/debian-11"
tags          = ["prod", "web"]

# service account variables
account_id = "tf-sa-prod"
display_name = "tf-sa-prod"

# gke cluster variables

name = "gke-prod-1"
location = "us-central1"
remove_default_node_pool = true
initial_node_count = 1


# instance template

cit_name               = "demo-1"
cit_description        = "demo-1"
cit_tags               = ["dev", "demo"]
cit_labels             = "dev"
cit_machine_type       = "n2-standard-2"
cit_environment        = "dev"
cit_can_ip_forward     = false
cit_automatic_restart  = true
cit_on_host_maintenance = "MIGRATE"
cit_source_image       = "debian-cloud/debian-11"
cit_auto_delete        = true
cit_boot               = true
cit_network            = "default"


# creating instance using for each

instances = {
  instance1 = {
    uci_name         = "web-instance-1"
    uci_machine_type = "e2-small"
    uci_zone         = "us-central1-a"
    uci_image        = "projects/debian-cloud/global/images/family/debian-11"
    uci_network      = "default"
  }
  instance2 = {
    uci_name         = "web-instance-2"
    uci_machine_type = "e2-medium"
    uci_zone         = "us-central1-b"
    uci_image        = "projects/debian-cloud/global/images/family/debian-11"
    uci_network      = "default"
  }
}
