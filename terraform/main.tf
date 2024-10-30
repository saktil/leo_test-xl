resource "digitalocean_vpc" "retail_app" {
  name     = "example-project-network"
  region   = "nyc3"
  ip_range = "10.10.10.0/24"
}
resource "digitalocean_droplet" "retail_app_droplet" {
  name     = var.droplet_name
  region   = var.region
  size     = var.size
  image    = var.image
  ssh_keys = ["7d:ce:da:45:17:8d:4c:3f:6c:62:f0:f2:cf:1a:bf:09"]

  tags = ["retail-app", "production"]
}

