####################################################
# Create network
####################################################
data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}

module "create_network"{
  source = "./modules/network"

  network_name = "net"
  cidr = "192.168.199.0/24"
  router_id = vkcs_networking_router.router.id   
}

resource "vkcs_networking_router" "router" {
   name                = "router"
   admin_state_up      = true
   external_network_id = data.vkcs_networking_network.extnet.id
}

####################################################
# Create stage server
####################################################
module "create_stage"{
  source = "./modules/instance"

  instance_name = "server-vm-1"
  key_pair = "warspoonserver-rsa"
  flavor_name = "STD2-1-2"
  security_group_name = "security_group"
  network = module.create_network.network  
  volume_size = 10
  fixed_ip = "192.168.199.110"
}

module "create_lb_stage"{
  source = "./modules/balancer"

  subnet = "${module.create_network.subnet}"
  loadbalancer = "loadbalancer"
  fixed_ip = "192.168.199.110"
  port = 8080
  listener = "listener_1"
  pool = "pool_1"
}

####################################################
# Create prod server
####################################################
module "create_prod"{  
  source = "./modules/instance"

  instance_name = "server_prod-vm-1"
  key_pair = "warspoonserver-rsa"
  flavor_name = "STD2-1-2"
  security_group_name = "security_group"
  network = module.create_network.network
  volume_size = 10
  fixed_ip = "192.168.199.10"
}

module "create_lb_prod"{
  source = "./modules/balancer"

  subnet = "${module.create_network.subnet}"
  loadbalancer = "prodloadbalancer"
  fixed_ip = "192.168.199.10"
  port = 8080
  listener = "listener_2"
  pool = "pool_2"
}

####################################################
# Create gitlab server
####################################################
module "create_gitlab"{
  source = "./modules/instance"

  instance_name = "gitlab-vm-1"
  key_pair = "warspoonserver-rsa"
  flavor_name = "STD2-2-8"
  security_group_name = "security_group"
  network = module.create_network.network
  volume_size = 20
  fixed_ip = "192.168.199.200"
}

####################################################
# Create observe server
####################################################
module "create_observe"{  
  source = "./modules/instance"

  instance_name = "observe-vm-1"
  key_pair = "warspoonserver-rsa"
  flavor_name = "STD2-1-2"
  security_group_name = "security_group"
  network = module.create_network.network
  volume_size = 10
  fixed_ip = "192.168.199.210"
}