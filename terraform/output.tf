output "droplet_ip" {
  description = "IP Address dari droplet yang dibuat"
  value       = digitalocean_droplet.retail_app_droplet.ipv4_address
}
