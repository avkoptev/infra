data "vkcs_compute_flavor" "compute" {
  name = "STD2-1-2"
}

data "vkcs_images_image" "my-ubuntu" {
  name = "Ubuntu-22.04-202208"
}

#Create servers
resource "vkcs_compute_instance" "my-vm-1" {
  name                    = "server-vm-1"
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = "warspoonserver-rsa"
  security_groups         = ["default","security_group"]
  availability_zone       = "MS1"

  block_device {
    uuid                  = data.vkcs_images_image.my-ubuntu.id
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = 10
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = vkcs_networking_network.network.id
    fixed_ip_v4 = "192.168.199.110"
  }

  depends_on = [
    vkcs_networking_network.network,
    vkcs_networking_subnet.subnetwork
  ]
}

resource "vkcs_networking_floatingip" "fip" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_compute_floatingip_associate" "fip" {
  floating_ip = vkcs_networking_floatingip.fip.address
  instance_id = vkcs_compute_instance.my-vm-1.id
}

#Create balansir
resource "vkcs_lb_loadbalancer" "my-lb-1" {
  name = "loadbalancer"
  vip_subnet_id = "${vkcs_networking_subnet.subnetwork.id}"  
}

resource "vkcs_lb_listener" "listener" {
  name = "listener"
  protocol = "HTTP"
  protocol_port = 8080
  loadbalancer_id = "${vkcs_lb_loadbalancer.my-lb-1.id}"
}

resource "vkcs_lb_pool" "pool" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = "${vkcs_lb_listener.listener.id}"
}

resource "vkcs_lb_member" "member_1" {    
  address = "192.168.199.110"
  protocol_port = 8080
  pool_id = "${vkcs_lb_pool.pool.id}"
  subnet_id = "${vkcs_networking_subnet.subnetwork.id}"
  weight = 0
}

output "instance_fip" {
  value = vkcs_networking_floatingip.fip.address
}