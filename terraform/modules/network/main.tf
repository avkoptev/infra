terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "~> 0.5.2" 
        }
    }
}

resource "vkcs_networking_network" "network" {
   name = var.network_name
}

resource "vkcs_networking_subnet" "subnetwork" {
   name       = "${var.network_name}_subnet"
   network_id = vkcs_networking_network.network.id
   cidr       = var.cidr
}

resource "vkcs_networking_router_interface" "db" {
   router_id = var.router_id
   subnet_id = vkcs_networking_subnet.subnetwork.id
}

output "network" {
   value = vkcs_networking_network.network.id
}

output "subnet" {
   value = vkcs_networking_subnet.subnetwork.id
}