#PoC-Packer-Terraform-nginx-postgresql

Dans terraform/environements/lab/terraform.tfvars compléter avec vos vraies valeurs
```
ovh_application_key    = "ovh_appkey"
ovh_application_secret = "ovh_appsecret"
ovh_consumer_key       = "ovh_consumerkey"
ovh_project_id         = "ovh_projectid"

openstack_username = "openstack_username"
openstack_password = "openstack_password"

region        = "UK1"
instance_name = "nginx-lab"
ssh_key_name  = "lab-key"
```

Dans packer/config.auto.pkrvars.hcl
```
ovh_username   = "openstack_username"      
ovh_password   = "openstack_password"   
ovh_project_id = "ovh_projectid"  
region         = "UK1"
flavor         = "b2-7"
source_image   = "Ubuntu 22.04"
ssh_username   = "ubuntu"
network_uuid   = "your_network_uuid"
