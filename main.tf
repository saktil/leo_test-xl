resource "digitalocean_vpc" "retail_store_vpc" {
  name     = "${var.project_name}-vpc"
  region   = var.region
  ip_range = var.vpc_cidr
}

resource "digitalocean_droplet" "retail_store_droplet" {
  image    = var.droplet_image
  name     = "${var.project_name}-droplet"
  region   = var.region
  size     = var.droplet_size
  vpc_uuid = digitalocean_vpc.retail_store_vpc.id
  ssh_keys = var.ssh_keys

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose
              systemctl start docker
              systemctl enable docker
              EOF
}

resource "digitalocean_firewall" "retail_store_firewall" {
  name = "${var.project_name}-firewall"

  droplet_ids = [digitalocean_droplet.retail_store_droplet.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "droplet_ip" {
  value = digitalocean_droplet.retail_store_droplet.ipv4_address
}