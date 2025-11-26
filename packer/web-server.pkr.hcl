source "openstack" "web-server" {
  identity_endpoint = "https://auth.cloud.ovh.net/v3"
  tenant_id         = var.ovh_project_id
  username          = var.ovh_username
  password          = var.ovh_password
  region            = var.region
  domain_name       = "default"
  
  image_name        = "web-server-nginx-{{timestamp}}"
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
    image_type  = "web-server"
    web_server  = "nginx"
    created_by  = "packer"
  }
}

build {
  sources = ["source.openstack.web-server"]

  provisioner "shell" {
    script = "scripts/base-setup.sh"
  }

  provisioner "shell" {
    script = "scripts/nginx-setup.sh"
  }

  provisioner "file" {
    source      = "scripts/nginx-default.conf"
    destination = "/tmp/nginx-default.conf"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/nginx-default.conf /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
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
    output     = "manifest-web.json"
    strip_path = true
  }
}
