# compute instance variables
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
location = "us-central-1"
remove_default_node_pool = true
initial_node_count = 2


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