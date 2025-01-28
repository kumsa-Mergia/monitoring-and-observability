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

# Define Grafana container
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
# Define Prometheus container
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  image = docker_image.prometheus.name
  name  = "prometheus"
  ports {
    internal = 9090
    external = 9090
  }
  restart = "always"

  env = [
    "PROMETHEUS_STORAGE_PATH=/prometheus",  # Example environment variable for Prometheus
  ]
}
