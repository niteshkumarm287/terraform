terraform {
  backend "gcs" {
    bucket = "terraform-nitesh"
    prefix = "statefile/"
  }
}