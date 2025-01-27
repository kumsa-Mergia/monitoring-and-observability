terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name  = "grafana"
  ports {
    internal = 3000
    external = 3000
  }
  restart = "always"

  env = [
    "GF_SECURITY_ADMIN_USER=kumsa",         # Set Grafana admin username
    "GF_SECURITY_ADMIN_PASSWORD=kumsa@1234",    # Set Grafana admin password
  ]
}

