terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "n1-standard-2"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}
resource "google_compute_subnetwork" "public-subnetwork" {
    name = "terraform-subnetwork"
    ip_cidr_range = "10.2.0.0/16"
    region = "us-central1"
    zone = "us_central1-c"
    network = google_compute_network.vpc_network.name
}
resource "google_compute_firewall_rule" "firewall_rule" {
    Name    =   mynet-allow-ssh
    Network =    mynet
    Targets =    All instances in the network
    Source filter =  IP Ranges
    Source IP ranges =  0.0.0.0/0 
    Protocols and ports =   Specified protocols and ports
        tcp = ports 22 }
}