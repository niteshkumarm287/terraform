resource "google_container_cluster" "demo-1" {

    name = var.name
    location = var.location
    remove_default_node_pool = var.remove_default_node_pool
    initial_node_count = var.initial_node_count
    
  
}