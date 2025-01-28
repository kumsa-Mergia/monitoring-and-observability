
# Terraform Explanation for Docker Containers

## Overview
The provided Terraform file automates the provisioning of Docker containers for Grafana and Prometheus using the Docker provider. Below is a detailed breakdown of the file and its functionalities.

---

## Terraform File Breakdown

### 1. **Required Providers**
```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}
```
- **Purpose**: Specifies the Docker provider as a dependency.
- **Source**: `kreuzwerker/docker` indicates the plugin for managing Docker resources.
- **Version**: Ensures compatibility by locking to version `2.22.x`.

---

### 2. **Docker Provider Configuration**
```hcl
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```
- **Purpose**: Configures the Docker provider to communicate with the Docker daemon on the local host.
- **Host**: `unix:///var/run/docker.sock` points to the Unix socket file for Docker.

---

### 3. **Grafana Container**

#### Grafana Docker Image Resource
```hcl
resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}
```
- **Purpose**: Pulls the latest Grafana image from Docker Hub.
- **Key Attribute**:
  - `name`: Specifies the Grafana image and its tag (`latest`).

#### Grafana Docker Container Resource
```hcl
resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name  = "grafana"
  ports {
    internal = 3000
    external = 3000
  }
  restart = "always"

  env = [
    "GF_SECURITY_ADMIN_USER=kumsa",
    "GF_SECURITY_ADMIN_PASSWORD=kumsa@1234",
  ]
}
```
- **Purpose**: Runs the Grafana container based on the pulled image.
- **Key Attributes**:
  - `image`: Links to the Grafana image defined earlier.
  - `name`: Names the container `grafana`.
  - `ports`: Maps port `3000` on the container to port `3000` on the host machine.
  - `restart`: Ensures the container restarts automatically if it stops.
  - `env`: Sets environment variables for Grafana, including the admin username and password.

---

### 4. **Prometheus Container**

#### Prometheus Docker Image Resource
```hcl
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}
```
- **Purpose**: Pulls the latest Prometheus image from Docker Hub.
- **Key Attribute**:
  - `name`: Specifies the Prometheus image and its tag (`latest`).

#### Prometheus Docker Container Resource
```hcl
resource "docker_container" "prometheus" {
  image = docker_image.prometheus.name
  name  = "prometheus"
  ports {
    internal = 9090
    external = 9090
  }
  restart = "always"

  env = [
    "PROMETHEUS_STORAGE_PATH=/prometheus",
  ]
}
```
- **Purpose**: Runs the Prometheus container based on the pulled image.
- **Key Attributes**:
  - `image`: Links to the Prometheus image defined earlier.
  - `name`: Names the container `prometheus`.
  - `ports`: Maps port `9090` on the container to port `9090` on the host machine.
  - `restart`: Ensures the container restarts automatically if it stops.
  - `env`: Sets an example environment variable for Prometheus.

---

## Summary
This Terraform file:
1. Defines the Docker provider for managing local Docker resources.
2. Automates the creation of Docker images and containers for Grafana and Prometheus.
3. Configures ports, restart policies, and environment variables for each container.

By applying this configuration, you will have two Docker containers running Grafana and Prometheus, with predefined ports and credentials for Grafana.

---

## Instructions
1. Install Terraform and Docker.
2. Save this file as `main.tf`.
3. Run the following commands in your terminal:
   ```bash
   terraform init
   terraform apply
   ```
4. Access Grafana at `http://localhost:3000` and Prometheus at `http://localhost:9090`.

---
