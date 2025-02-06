# Define the required providers for the Terraform script
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"  # Specify the Docker provider source from the registry
      version = "~> 2.22.0"           # Specify the version constraint for the Docker provider
    }
  }
}

# Configure the Docker provider with a Unix socket for Docker communication
provider "docker" {
  host = "unix:///var/run/docker.sock"  # Set the Docker host to communicate with the local Docker daemon through the Unix socket
}

# Define the Grafana Docker image resource
resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"  # Specify the image name and version for Grafana
}

# Define the Grafana Docker container resource
resource "docker_container" "grafana" {
  image = docker_image.grafana.name  # Use the image defined above for this container
  name  = "grafana"                 # Set the container name as "grafana"
  
  # Map internal container port 3000 to external port 3000
  ports {
    internal = 3000
    external = 3000
  }
  
  restart = "always"  # Set the container to always restart on failure or Docker daemon restart

  # Define environment variables for Grafana configuration
  env = [
    "GF_SECURITY_ADMIN_USER=kumsa",        # Set the admin username for Grafana
    "GF_SECURITY_ADMIN_PASSWORD=kumsa@1234",  # Set the admin password for Grafana
  ]
}

# Define the Prometheus Docker image resource
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"  # Specify the image name and version for Prometheus
}

# Define the Prometheus Docker container resource
resource "docker_container" "prometheus" {
  image = docker_image.prometheus.name  # Use the image defined above for this container
  name  = "prometheus"                 # Set the container name as "prometheus"
  
  # Map internal container port 9090 to external port 9090
  ports {
    internal = 9090
    external = 9090
  }
  
  restart = "always"  # Set the container to always restart on failure or Docker daemon restart

  # Define environment variables for Prometheus configuration
  env = [
    "PROMETHEUS_STORAGE_PATH=/prometheus",  # Set the Prometheus storage path to /prometheus
  ]
}

# Define the InfluxDB Docker image resource
resource "docker_image" "influxdb" {
  name = "influxdb:latest"  # Specify the image name and version for InfluxDB
}

# Define the InfluxDB Docker container resource
resource "docker_container" "influxdb" {
  image = docker_image.influxdb.name  # Use the image defined above for this container
  name  = "influxdb"                 # Set the container name as "influxdb"
  
  # Map internal container port 8086 to external port 8086
  ports {
    internal = 8086
    external = 8086
  }
  
  restart = "always"  # Set the container to always restart on failure or Docker daemon restart

  # Define environment variables for InfluxDB configuration
  env = [
    "INFLUXDB_ADMIN_USER=kumsa",           # Set the admin username for InfluxDB
    "INFLUXDB_ADMIN_PASSWORD=kumsa@1234",  # Set the admin password for InfluxDB
    "INFLUXDB_DB=mydb"                    # Set the default database for InfluxDB
  ]
}
