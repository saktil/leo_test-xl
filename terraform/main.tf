resource "digitalocean_vpc" "retail_app_droplet" {
  name     = "${var.project_name}-${var.environment}-vpc-${random_string.suffix.result}"
  region   = var.region
  ip_range = var.vpc_cidr
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

data "digitalocean_vpc" "existing" {
  count = var.use_existing_vpc ? 1 : 0
  name  = var.existing_vpc_name
}


resource "digitalocean_droplet" "retail_app_droplet" {
  name     = var.droplet_name
  region   = var.region
  size     = var.size
  image    = var.image
  ssh_keys = ["7d:ce:da:45:17:8d:4c:3f:6c:62:f0:f2:cf:1a:bf:09"]

  tags = ["retail-app", "production"]
}

