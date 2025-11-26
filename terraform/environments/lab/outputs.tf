output "web_server_ip" {
  description = "IP du serveur web"
  value       = module.web_instance.instance_ip
}

output "web_server_id" {
  description = "ID du serveur web"
  value       = module.web_instance.instance_id
}

output "web_server_name" {
  description = "Nom du serveur web"
  value       = module.web_instance.instance_name
}

output "db_server_ip" {
  description = "IP du serveur DB"
  value       = module.db_instance.instance_ip
}

output "db_server_id" {
  description = "ID du serveur DB"
  value       = module.db_instance.instance_id
}

output "db_server_name" {
  description = "Nom du serveur DB"
  value       = module.db_instance.instance_name
}
