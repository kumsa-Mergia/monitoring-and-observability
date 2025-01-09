
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

## Step 2: Configure Prometheus

1. **Prometheus Configuration**:
   - Navigate to the `configs` directory and edit `prometheus.yml` to match your infrastructure.
     ```yaml
     global:
       scrape_interval: 15s

     scrape_configs:
       - job_name: 'example'
         static_configs:
           - targets: ['localhost:9090']
     ```

2. **Start Prometheus**:
   - Use Docker Compose to start Prometheus:
     ```bash
     docker-compose -f docker/prometheus-compose.yml up -d
     ```

---

## Step 3: Add Exporters

1. **Node Exporter**:
   - Install Node Exporter on your target servers to collect hardware and OS metrics.
     ```bash
     wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz
     tar xvfz node_exporter-*.*-amd64.tar.gz
     ./node_exporter
     ```
   - Add the target to your `prometheus.yml` file:
     ```yaml
     - job_name: 'node'
       static_configs:
         - targets: ['<node-exporter-ip>:9100']
     ```

2. **Custom Exporters**:
   - Place any custom exporters in the `exporters` directory and follow the README instructions within the subdirectories.

---

## Step 4: Set Up Alerts

1. **Edit Alert Rules**:
   - Navigate to the `alerts` directory and modify `prometheus-alert-rules.yml` as needed.
     ```yaml
     groups:
     - name: example-alert
       rules:
       - alert: InstanceDown
         expr: up == 0
         for: 5m
         labels:
           severity: critical
         annotations:
           summary: "Instance is down"
     ```

2. **Reload Prometheus**:
   - Apply the new alert rules by reloading Prometheus.
     ```bash
     docker kill --signal=HUP <prometheus-container-id>
     ```

---

## Step 5: Visualize Metrics in Grafana

1. **Add Prometheus as a Data Source**:
   - Navigate to Grafana's Data Sources settings and add Prometheus with the URL `http://<prometheus-ip>:9090`.

2. **Import Dashboards**:
   - Use the JSON files in the `dashboards` directory to import preconfigured dashboards.

---

## Step 6: Test and Validate

1. **Access Prometheus**:
   - Open Prometheus in your browser at `http://<your-server-ip>:9090` and query metrics like `up` or `node_cpu_seconds_total`.

2. **Validate Configuration**:
   - Use the `tests` directory scripts to ensure Prometheus and exporters are correctly configured:
     ```bash
     python tests/test_prometheus_configs.py
     ```

---

## Additional Resources

- [Prometheus Documentation](https://prometheus.io/docs/)
- [Prometheus GitHub Repository](https://github.com/prometheus/prometheus)
- [Prometheus Exporters](https://prometheus.io/docs/instrumenting/exporters/)

---

## Troubleshooting

1. **Prometheus Logs**:
   - Check Prometheus logs for errors:
     ```bash
     docker logs <prometheus-container-name>
     ```

2. **Common Issues**:
   - Ensure firewall rules allow communication on port `9090` for Prometheus and `9100` for Node Exporter.
   - Validate your `prometheus.yml` syntax using a YAML validator.

---

Happy Monitoring with Prometheus! 🚀
