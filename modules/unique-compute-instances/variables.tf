variable "instances" {
  type = map(object({
    uci_name         = string
    uci_machine_type = string
    uci_zone         = string
    uci_image        = string
    uci_network      = string
  }))
}