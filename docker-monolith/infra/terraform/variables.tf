variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-d"
}

variable gcp_user {                                          
  description = "GCP username"                                
} 

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable machine_type {
  description = "Machine type"
  default     = "n1-standard-1"
}

variable disk_image {
  description = "Disk image"
  default     = "ubuntu-1604-lts"
}

variable dockerhost_count {
  description = "Docker host instances count"
  default     = 3
}
