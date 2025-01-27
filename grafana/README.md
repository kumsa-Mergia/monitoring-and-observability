

# Terraform Configuration for Deploying Grafana with Docker

This configuration defines the required provider, Docker container, and sets up the environment variables for Grafana admin credentials. Below is a breakdown of the important sections:

## Terraform Block
This block ensures that the Docker provider is installed with the correct version:

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

## Docker Provider Block
It configures the connection to Docker, assuming you are running it locally via the Docker socket:

```hcl
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```

## Docker Image Resource
This pulls the latest Grafana Docker image from Docker Hub:

```hcl
resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}
```

## Docker Container Resource
This block defines the Grafana container:

- **Ports**: Maps internal port `3000` to external port `3000` (Grafana's default).
- **Restart Policy**: Ensures the container restarts automatically.
- **Environment Variables**: Sets the admin username and password for Grafana.

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
    "GF_SECURITY_ADMIN_USER=kumsa",         # Set Grafana admin username
    "GF_SECURITY_ADMIN_PASSWORD=kumsa@1234",    # Set Grafana admin password
  ]
}
```

## To Deploy with This Configuration:

1. **Initialize Terraform**:  
   Run `terraform init` in the same directory as your `.tf` file to download the necessary provider plugin.

2. **Apply the Configuration**:  
   Run `terraform apply` to start the Grafana container. Terraform will display a plan and ask for confirmation. Type `yes` to proceed.

3. **Access Grafana**:  
   Once the container is running, open your web browser and go to `http://<VM_IP>:3000` (replace `<VM_IP>` with your actual VM's IP address).

   - **Username**: `kumsa`
   - **Password**: `kumsa@1234`
