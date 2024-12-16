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