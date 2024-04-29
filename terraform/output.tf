output "server1"{
  value=module.create_stage.instance_fip
}

output "prod_server1"{
  value=module.create_prod.instance_fip
}

output "gitlab"{
  value=module.create_gitlab.instance_fip
}

output "observe"{
  value=module.create_observe.instance_fip
}