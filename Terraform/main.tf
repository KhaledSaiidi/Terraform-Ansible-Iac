### Provider Configuration ###
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"  
        }  
    }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "terraform"
}

### Resource Provisioning Configuration ###

 resource "digitalocean_droplet" "web-server" {
    image = "ubuntu-20-04-x64"
    name = "webserver"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = [
        data.digitalocean_ssh_key.terraform.id
        ]
 }

 ### Output of Server Information ###

output "webserver_ip" {
  description = "Public IP of Server"
  value = digitalocean_droplet.web-server.ipv4_address
}