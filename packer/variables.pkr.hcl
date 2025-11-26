variable "ovh_username" {
  type        = string
  description = "OpenStack username"
}

variable "ovh_password" {
  type        = string
  sensitive   = true
  description = "OpenStack password"
}

variable "ovh_project_id" {
  type        = string
  description = "OVH Project ID"
}

variable "region" {
  type        = string
  description = "OpenStack region"
  default     = "UK1"
}

variable "source_image" {
  type        = string
  description = "Source image name"
  default     = "Ubuntu 22.04"
}

variable "flavor" {
  type        = string
  description = "Instance flavor"
  default     = "b2-7"
}

variable "ssh_username" {
  type        = string
  description = "SSH username"
  default     = "ubuntu"
}

variable "network_uuid" {
  type        = string
  description = "Network UUID for Ext-Net"
  default     = "6011fbc9-4cbf-46a4-8452-6890a340b60b"
}
