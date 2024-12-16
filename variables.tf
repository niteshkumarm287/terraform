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


variable "name" {

    description = "cluster name"
    type = string
  
}

variable "location" {

    description = "cluster location"
    type = string
  
}

variable "remove_default_node_pool" {

    description = "cluster defult node pool"
    type = bool
  
}

variable "initial_node_count" {

    description = "cluster node count"
    type = number
  
}

variable "cit_name" {

    description = "instance template name"
    type = string
  
}

variable "cit_description" {
    description = "instance template description"
    type = string
  
}

variable "cit_tags" {
    description = "instance template tags"
    type = list(string)
    
  
}

variable "cit_labels" {
  description = "Label for the environment"
  type        = string
  default     = "production"
}

variable "cit_environment" {
    description = "instance template environment"
    type = string
  
}


variable "cit_machine_type" {
    description = "instance template machine type"
    type = string
  
}

variable "cit_can_ip_forward" {
    description = "instance template can ip forward"
    type = bool
  
}

variable "cit_automatic_restart" {
    description = "instance template automatic restart"
    type = bool
  
}

variable "cit_on_host_maintenance" {
    description = "instance template on host maintenance"
    type = string
}


variable "cit_source_image" {
    description = "instance template source image"
    type = string
  
}

variable "cit_auto_delete" {
    description = "instance template auto delete"
    type = bool
  
}

variable "cit_boot" {
    description = "instance template boot"
    type = bool
  
}

variable "cit_network" {
    description = "instance template network"
    type = string
  
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1  # Default value, can be overridden via tfvars
}


variable "instances" {
  type = map(object({
    uci_name         = string
    uci_machine_type = string
    uci_zone         = string
    uci_image        = string
    uci_network      = string
  }))
}