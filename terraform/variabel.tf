variable "do_token" {
  description = "Token autentikasi untuk DigitalOcean"
  type        = string
}

variable "region" {
  description = "Region untuk droplet DigitalOcean"
  type        = string
  default     = "sgp1"
}

variable "droplet_name" {
  description = "Nama untuk droplet DigitalOcean"
  type        = string
  default     = "retail-sample-app"
}

variable "ssh_fingerprint" {
  description = "Fingerprint untuk kunci SSH"
  type        = string
}

variable "image" {
  description = "Image yang digunakan untuk droplet"
  type        = string
  default     = "docker-20-04"  // Menggunakan image dengan Docker pre-installed
}

variable "size" {
  description = "Ukuran droplet"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "retail-app"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "use_existing_vpc" {
  description = "Whether to use an existing VPC"
  type        = bool
  default     = false
}

variable "existing_vpc_name" {
  description = "Name of existing VPC to use if use_existing_vpc is true"
  type        = string
  default     = ""
}