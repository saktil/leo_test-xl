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
