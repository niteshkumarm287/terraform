# variable "instance_name" {
#   description = "Name of the compute instance"
#   type        = string
# }

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
}

variable "zone" {
  description = "The GCP zone to deploy the instance"
  type        = string
}

variable "boot_disk" {
  description = "Boot disk image for the instance"
  type        = string
}

variable "tags" {
  description = "Tags for the compute instance"
  type        = list(string)
}


variable "instance-name" {
  description = "instance name for the instance"
  type        = string
}

variable "account_id" {

    description = "service account creation"
    type = string
  
}

variable "display_name" {

    description = "service account creation"
    type = string
  
}