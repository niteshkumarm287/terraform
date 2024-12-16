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

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1  # Default value, can be overridden via tfvars
}