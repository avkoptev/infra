terraform {
    required_providers {
        vkcs = {
            source = "vk-cs/vkcs"
            version = "~> 0.5.2" 
        }
    }
}

data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}

data "vkcs_compute_flavor" "compute" {
  name = var.flavor_name
}

data "vkcs_images_image" "my-ubuntu" {
  name = "ubuntu-22-202404160933.gitd6495fe9"
}

resource "vkcs_compute_instance" "instance" {
  name                    = var.instance_name
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = var.key_pair
  security_groups         = [var.security_group_name]
  availability_zone       = "MS1"

  block_device {
    uuid                  = data.vkcs_images_image.my-ubuntu.id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = var.volume_size
    boot_index            = 0
    delete_on_termination = true
  }

  network {       
    uuid = var.network
    fixed_ip_v4 = var.fixed_ip
  }

  #depends_on = [
    #data.vkcs_networking_network.network,
    #data.vkcs_networking_subnet.subnetwork
  #]
}

resource "vkcs_networking_floatingip" "fip" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip" {
  floating_ip = vkcs_networking_floatingip.fip.address
  instance_id = vkcs_compute_instance.instance.id
}

output "instance_fip" {
  value = vkcs_networking_floatingip.fip.address  
}