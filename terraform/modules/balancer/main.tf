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

resource "vkcs_lb_loadbalancer" "loadbalancer" {
  name = var.loadbalancer
  vip_subnet_id = var.subnet
}

resource "vkcs_networking_floatingip" "lb_fip" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_networking_floatingip_associate" "lb_fip" {
  floating_ip = vkcs_networking_floatingip.lb_fip.address
  port_id = vkcs_lb_loadbalancer.loadbalancer.vip_port_id
}

resource "vkcs_lb_listener" "listener" {
  name = var.listener
  protocol = "HTTP"
  protocol_port = var.port
  loadbalancer_id = "${vkcs_lb_loadbalancer.loadbalancer.id}"
}

resource "vkcs_lb_pool" "pool" {
  name = "var.pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = "${vkcs_lb_listener.listener.id}"
}

resource "vkcs_lb_member" "member" {    
  address = var.fixed_ip
  protocol_port = var.port
  pool_id = "${vkcs_lb_pool.pool.id}"
  subnet_id = var.subnet
  weight = 0
}

output "instance_fip" {
  value = vkcs_networking_floatingip.lb_fip.address
}