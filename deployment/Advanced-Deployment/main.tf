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

# Create a custom Docker network
resource "docker_network" "monitoring" {
  name = "monitoring_network"
}

# Grafana Docker Image
resource "docker_image" "grafana" {
  name = "grafana/grafana:10.1.1"
}

# Grafana Docker Container
resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name  = "grafana"
  
  ports {
    internal = 3000
    external = 3000
  }
  
  restart = "always"
  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = "grafana_data"
    container_path = "/var/lib/grafana"
  }

  env = [
    "GF_SECURITY_ADMIN_USER=${var.grafana_admin_user}",
    "GF_SECURITY_ADMIN_PASSWORD=${var.grafana_admin_password}"
  ]
}

# Prometheus Docker Image
resource "docker_image" "prometheus" {
  name = "prom/prometheus:v2.44.0"
}

# Prometheus Docker Container
resource "docker_container" "prometheus" {
  image = docker_image.prometheus.name
  name  = "prometheus"

  ports {
    internal = 9090
    external = 9090
  }

  restart = "always"
  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = "prometheus_data"
    container_path = "/prometheus"
  }

  env = [
    "PROMETHEUS_STORAGE_PATH=/prometheus"
  ]
}

# InfluxDB Docker Image
resource "docker_image" "influxdb" {
  name = "influxdb:2.7.1"
}

# InfluxDB Docker Container
resource "docker_container" "influxdb" {
  image = docker_image.influxdb.name
  name  = "influxdb"

  ports {
    internal = 8086
    external = 8086
  }

  restart = "always"
  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    volume_name    = "influxdb_data"
    container_path = "/var/lib/influxdb"
  }

  env = [
    "INFLUXDB_ADMIN_USER=${var.influxdb_admin_user}",
    "INFLUXDB_ADMIN_PASSWORD=${var.influxdb_admin_password}",
    "INFLUXDB_DB=mydb"
  ]
}

# Define Docker Volumes for Persistent Storage
resource "docker_volume" "grafana_data" {
  name = "grafana_data"
}

resource "docker_volume" "prometheus_data" {
  name = "prometheus_data"
}

resource "docker_volume" "influxdb_data" {
  name = "influxdb_data"
}
