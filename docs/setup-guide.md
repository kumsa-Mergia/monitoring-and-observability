
# Monitoring and Observability Setup Guide

This guide provides step-by-step instructions to set up a monitoring and observability system using the tools and configurations provided in this repository.

---

## Prerequisites

1. **Infrastructure Requirements**:
   - A server or virtual machine with at least 4 CPUs, 8GB RAM, and 50GB storage.
   - Internet access to download tools and dependencies.

2. **Software Requirements**:
   - Docker and Docker Compose (for containerized setups).
   - Git for version control.
   - Terraform and Ansible (if using Infrastructure as Code).

3. **Access Requirements**:
   - Admin or root access to the system.
   - API access keys for cloud services (if applicable).

---

## Step 1: Clone the Repository

Clone this repository to your local system:
```bash
git clone https://github.com/kumsa-Mergia/monitoring-and-observability.git
cd monitoring-and-observability
```

---

## Step 2: Configure Monitoring Tools

1. **Prometheus**:
   - Navigate to the `configs` directory and edit `prometheus.yml` to match your infrastructure.
   - Start Prometheus using Docker Compose:
     ```bash
     docker-compose -f docker/prometheus-compose.yml up -d
     ```

2. **Grafana**:
   - Place your custom dashboards in the `dashboards` directory.
   - Start Grafana using Docker Compose:
     ```bash
     docker-compose -f docker/grafana-compose.yml up -d
     ```

---

## Step 3: Deploy Infrastructure (Optional)

If you are using Terraform for provisioning:
```bash
cd terraform
terraform init
terraform apply
```

---

## Step 4: Set Up Alerts

1. Navigate to the `alerts` directory.
2. Edit the alert rules as needed in `prometheus-alert-rules.yml`.
3. Reload Prometheus to apply the rules.

---

## Step 5: Test and Validate

1. Open your browser and navigate to:
   - Prometheus: `http://<your-server-ip>:9090`
   - Grafana: `http://<your-server-ip>:3000`

2. Use the provided test scripts in the `tests` directory to validate the configurations:
   ```bash
   python tests/test_prometheus_configs.py
   ```

---

## Additional Resources

- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)

---

## Troubleshooting

Refer to the logs in the `logs` directory for debugging common issues:
```bash
docker logs <container-name>
```

---

Happy Monitoring! 🚀
