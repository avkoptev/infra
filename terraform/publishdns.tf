resource "vkcs_publicdns_zone" "zone" {
   zone = "warspoon.ru"
   primary_dns = "ns1.mcs.mail.ru"   
   admin_email = "izgoi_ketsal@mail.ru"
   expire = 3600000
}

####################################################
# stage server
####################################################
resource "vkcs_publicdns_record" "stage" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "stage"
  ip = "${module.create_lb_stage.instance_fip}"
  ttl = 60  
}

resource "vkcs_publicdns_record" "Server1" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "server1"
  ip = "${module.create_stage.instance_fip}"
  ttl = 60  
}

####################################################
# prod server
####################################################
resource "vkcs_publicdns_record" "prod" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "@"
  ip = "${module.create_lb_prod.instance_fip}"
  ttl = 60  
}

resource "vkcs_publicdns_record" "Prod_server1" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "prodserver1"
  ip = "${module.create_stage.instance_fip}"
  ttl = 60  
}

####################################################
# gitlab server
####################################################
resource "vkcs_publicdns_record" "gitlab" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "ci"
  ip = "${module.create_gitlab.instance_fip}"
  ttl = 60  
}

resource "vkcs_publicdns_record" "register" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "registry.ci"
  ip = "${module.create_gitlab.instance_fip}"
  ttl = 60  
}

####################################################
# observe server
####################################################
resource "vkcs_publicdns_record" "Prometheus" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "monitoring"
  ip = "${module.create_observe.instance_fip}"
  ttl = 60  
}

resource "vkcs_publicdns_record" "Grafana" {
  zone_id = vkcs_publicdns_zone.zone.id
  type = "A"
  name = "Grafana"
  ip = "${module.create_observe.instance_fip}"
  ttl = 60  
}

