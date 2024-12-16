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

