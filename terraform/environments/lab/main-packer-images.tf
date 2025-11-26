# Récupérer les images créées par Packer (avec timestamp)
data "openstack_images_image_v2" "base_ubuntu" {
  name_regex  = "^base-ubuntu-"
  most_recent = true
}

data "openstack_images_image_v2" "web_server" {
  name_regex  = "^web-server-nginx-"
  most_recent = true
}

data "openstack_images_image_v2" "db_server" {
  name_regex  = "^db-server-postgresql-"
  most_recent = true
}

# Récupérer le flavor
data "openstack_compute_flavor_v2" "flavor" {
  name = "b2-7"
}

# Clé SSH
resource "openstack_compute_keypair_v2" "lab_keypair" {
  name       = var.ssh_key_name
  public_key = file("~/.ssh/id_ed25519.pub")
}

# Réseau
data "openstack_networking_network_v2" "ext_net" {
  name = "Ext-Net"
}

# Déployer un serveur web avec l'image Packer
module "web_instance" {
  source = "../../modules/instance"

  instance_name = "web-server-prod"
  flavor_id     = data.openstack_compute_flavor_v2.flavor.id
  image_id      = data.openstack_images_image_v2.web_server.id
  key_pair      = openstack_compute_keypair_v2.lab_keypair.name
  network_id    = data.openstack_networking_network_v2.ext_net.id
  region        = var.region

  providers = {
    openstack = openstack
  }
}

# Déployer un serveur DB avec l'image Packer
module "db_instance" {
  source = "../../modules/instance"

  instance_name = "db-server-prod"
  flavor_id     = data.openstack_compute_flavor_v2.flavor.id
  image_id      = data.openstack_images_image_v2.db_server.id
  key_pair      = openstack_compute_keypair_v2.lab_keypair.name
  network_id    = data.openstack_networking_network_v2.ext_net.id
  region        = var.region

  providers = {
    openstack = openstack
  }
}
