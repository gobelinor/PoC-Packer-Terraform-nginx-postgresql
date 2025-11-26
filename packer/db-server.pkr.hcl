source "openstack" "db-server" {
  identity_endpoint = "https://auth.cloud.ovh.net/v3"
  tenant_id         = var.ovh_project_id
  username          = var.ovh_username
  password          = var.ovh_password
  region            = var.region
  domain_name       = "default"
  
  image_name        = "db-server-postgresql-{{timestamp}}"
  source_image_name = var.source_image
  flavor            = var.flavor
  
  ssh_username      = var.ssh_username
  
  networks          = [var.network_uuid]
  
  # Forcer l'utilisation d'IPv4
  use_floating_ip   = false
  ssh_ip_version    = "4"
  
  metadata = {
    os_type     = "linux"
    os_distro   = "ubuntu"
    os_version  = "22.04"
    image_type  = "db-server"
    database    = "postgresql"
    created_by  = "packer"
  }
}

build {
  sources = ["source.openstack.db-server"]

  provisioner "shell" {
    script = "scripts/base-setup.sh"
  }

  provisioner "shell" {
    script = "scripts/postgresql-setup.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get clean",
      "sudo rm -rf /tmp/*",
      "sudo rm -rf /var/tmp/*",
      "sudo truncate -s 0 ~/.bash_history"
    ]
  }

  post-processor "manifest" {
    output     = "manifest-db.json"
    strip_path = true
  }
}
