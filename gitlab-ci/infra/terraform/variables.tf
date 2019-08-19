variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable private_key_path {
  description = "Path to the private_key used for ssh access"
}

variable count_instance {
  description = "count of instances"
  default     = "1"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "docker-base"
}

#задаем количество создаваемых инстансов
variable "docker_count" {
  default = 1
}

variable "no_docker_count" {
  default = 0
}
