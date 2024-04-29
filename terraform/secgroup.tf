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

resource "vkcs_networking_secgroup_rule" "secgroup_rule_6" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 5005
   port_range_min = 5005
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_6"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_7" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 9090
   port_range_min = 9090
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_7"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_8" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 9100
   port_range_min = 9100
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_8"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_9" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 3000
   port_range_min = 3000
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_9"
}

resource "vkcs_networking_secgroup_rule" "secgroup_rule_10" {
   direction = "ingress"
   ethertype = "IPv4"
   port_range_max = 9093
   port_range_min = 9093
   protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
   security_group_id = vkcs_networking_secgroup.secgroup.id
   description = "secgroup_rule_10"
}