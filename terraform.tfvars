# compute instance variables
instance-name = "web-server"
machine_type  = "n2-standard-2"
zone          = "us-central1-a"
boot_disk     = "debian-cloud/debian-11"
tags          = ["dev", "web"]

# service account variables
account_id = "tf-sa-demo"
display_name = "tf-sa-demo"