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