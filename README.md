# Multi-Server EC2 Infrastructure with Ansible Nginx Installation

Terraform configuration for deploying 4 EC2 servers with different environments and security groups, plus automated nginx installation using Ansible.

## Architecture

- **Configurable EC2 instances** (Free Tier eligible)
- **Custom instance types** per server via array
- **Individual Security Groups** with dynamic port configuration
- **Multiple Environments**: dev, staging, prod, test
- **Default VPC** with automatic AZ selection

## Variables

- `server_count`: Number of servers (default: 1, limited by vCPU quota)
- `server_names`: Server names array
- `environments`: Environment tags for each server
- `server_ports`: Port configuration per server
- `instance_types`: Custom instance type for each server
- `region`: AWS region (default: us-east-1)

## Prerequisites

1. AWS CLI configured:
   ```bash
   aws configure
   ```

2. Install Ansible:
   ```bash
   pip install ansible
   ```

3. SSH key pair:
   ```bash
   ssh-keygen -t rsa -b 2048 -f id_rsa
   ```

## Step-by-Step Deployment

### Step 1: Deploy Infrastructure with Terraform

```bash
# Initialize Terraform
terraform init

# Review deployment plan
terraform plan

# Deploy EC2 instances
terraform apply
```

### Step 2: Get Server IPs

```bash
# Display server IPs
terraform output server_ips
```

### Step 3: Update Ansible Inventory

Edit `inventory` file with the test server IP from Step 2:

```ini
[test]
<TEST_SERVER_IP> ansible_user=ubuntu ansible_ssh_private_key_file=./id_rsa
```

### Step 4: Install Nginx with Ansible

```bash
# Wait 2-3 minutes for servers to fully boot
# Then run nginx installation
ansible-playbook -i inventory install_nginx.yml
```

### Step 5: Verify Installation

```bash
# Test nginx is running
curl http://<TEST_SERVER_IP>
```

### Troubleshooting

**InsufficientInstanceCapacity errors:**
1. Change instance types in `instance_types` array
2. Try different region in terraform.tfvars
3. Wait and retry later

**VcpuLimitExceeded errors:**
1. Reduce `server_count` to fit within vCPU limit
2. Request vCPU limit increase via AWS Service Quotas
3. Use smaller instance types (t2.nano = 1 vCPU)

## Outputs

- `server_ips`: All server public IP addresses

## Cleanup

```bash
terraform destroy
```

## Complete Workflow

1. **Deploy** → Run Terraform to create EC2 instances
2. **Configure** → Update Ansible inventory with server IPs
3. **Install** → Run Ansible playbook to install nginx
4. **Verify** → Test nginx installation

## Files

### Terraform Configuration
- `main.tf` - EC2 instances with count
- `network.tf` - Dynamic security groups and key pair
- `variables.tf` - Input variables
- `outputs.tf` - Server IP outputs
- `providers.tf` - AWS provider configuration
- `terraform.tfvars` - Variable values

### Ansible Configuration
- `install_nginx.yml` - Nginx installation playbook
- `inventory` - Ansible inventory file

### SSH Keys
- `id_rsa` - Private SSH key
- `id_rsa.pub` - Public SSH key