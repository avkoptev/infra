data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}

resource "vkcs_networking_network" "network" {
   name = "net"   
}

resource "vkcs_networking_subnet" "subnetwork" {
   name       = "subnet_1"
   network_id = vkcs_networking_network.network.id
   cidr       = "192.168.199.0/24"   
}

resource "vkcs_networking_router" "router" {
   name                = "router"
   admin_state_up      = true
   external_network_id = data.vkcs_networking_network.extnet.id
}

resource "vkcs_networking_router_interface" "db" {
   router_id = vkcs_networking_router.router.id
   subnet_id = vkcs_networking_subnet.subnetwork.id
}

resource "vkcs_networking_secgroup" "secgroup" {
   name = "security_group"
   description = "terraform security group"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_1" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 22
   port_range_min = 22
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_1"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_2" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 8080
   port_range_min = 8080
   remote_ip_prefix = "0.0.0.0/0"
   protocol = "tcp"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_2"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_3" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 443
   port_range_min = 443
   remote_ip_prefix = "0.0.0.0/0"
   protocol = "tcp"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_3"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_4" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 2222
   port_range_min = 2222
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_4"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_5" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 80
   port_range_min = 80
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_5"
}

resource "vkcs_publicdns_zone" "zone" {
   zone = "warspoon.ru"
   primary_dns = "ns1.mcs.mail.ru"   
   admin_email = "izgoi_ketsal@mail.ru"
   expire = 3600000
}

resource "vkcs_publicdns_record" "srv" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "@"
  ip = vkcs_networking_floatingip.lb_fip.address
  ttl = 60  
}

resource "vkcs_publicdns_record" "run" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "ci"
  ip = vkcs_networking_floatingip.run_fip.address
  ttl = 60  
}