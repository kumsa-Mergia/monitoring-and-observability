
# Grafana Setup and Usage Guide

This guide provides detailed instructions for setting up Grafana, connecting data sources, and creating dashboards for monitoring and observability.

---

## Prerequisites

1. **Infrastructure Requirements**:

   - A server or virtual machine with at least 2 CPUs, 4GB RAM, and 20GB storage.
   - Internet access for downloading Grafana and plugins.

2. **Software Requirements**:

   - Docker and Docker Compose (recommended for containerized Grafana setup).
   - Optional: Grafana CLI (for manual installation of plugins).

3. **Access Requirements**:

   - Admin or root access to the system.
   - Credentials for data sources like Prometheus, InfluxDB, or MySQL.

---

## Step 1: Install Grafana

### **Option 1: Using Docker**

1. Pull the official Grafana image:
   ```bash
   docker pull grafana/grafana:latest
   ```

2. Run Grafana as a container:

   ```bash
   docker run -d -p 3000:3000 --name=grafana grafana/grafana:latest
   ```

### **Option 2: Native Installation**

For native installation on Linux:

1. Download the Grafana package:

   ```bash
   wget https://dl.grafana.com/oss/release/grafana-<version>.deb
   ```

2. Install Grafana:

   ```bash
   sudo dpkg -i grafana-<version>.deb
   ```

3. Start the Grafana service:

   ```bash
   sudo systemctl start grafana-server
   ```

---

## Step 2: Access Grafana

1. Open a web browser and navigate to `http://<server-ip>:3000`.
2. Log in with default credentials:

   - Username: `admin`

   - Password: `admin`

   (You will be prompted to set a new password on the first login.)

---

## Step 3: Add a Data Source

1. Navigate to **Configuration > Data Sources** in the Grafana UI.
2. Select your desired data source (e.g., Prometheus, InfluxDB, MySQL).

   - Provide the connection details (e.g., URL, authentication credentials).

   - Test the connection to verify.

---

## Step 4: Create a Dashboard

1. Go to **Dashboards > + New Dashboard**.
2. Add panels for each metric you want to visualize.
   - Select the data source and query for the desired metric.
   - Customize the visualization (e.g., Graph, Gauge, Table).
3. Save the dashboard with a meaningful name.

---

## Step 5: Install Plugins (Optional)

1. Use the Grafana CLI to install plugins:

   ```bash
   grafana-cli plugins install <plugin-name>
   ```

2. Restart the Grafana service:

   ```bash
   sudo systemctl restart grafana-server
   ```

---

## Step 6: Configure Alerts

1. Navigate to **Alerting > Alert Rules**.

2. Create a new alert rule:

   - Define the query and conditions for triggering the alert.

   - Set up notification channels (e.g., Email, Slack, PagerDuty).

3. Save the alert and test it.

---

## Troubleshooting

1. **Unable to Access Grafana:**

   - Check if the Grafana service is running:

     ```bash
     sudo systemctl status grafana-server
     ```
   - Verify the firewall settings to allow traffic on port 3000.

2. **Plugins Not Loading:**

   - Ensure the plugin directory has the correct permissions.

   - Restart the Grafana service.

---

## Additional Resources

- [Grafana Documentation](https://grafana.com/docs/)

- [Grafana Plugins](https://grafana.com/grafana/plugins/)

- [Community Forums](https://community.grafana.com/)

---

Enjoy creating insightful dashboards with Grafana! 🚀
