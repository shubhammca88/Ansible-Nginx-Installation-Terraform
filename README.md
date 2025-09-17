# EC2 + Nginx with Terraform & Ansible

Deploy EC2 instances and install nginx automatically.

## Quick Start

1. **Setup**
   ```bash
   aws configure
   pip install ansible
   ```

2. **Deploy**
   ```bash
   terraform init
   terraform apply
   ```

3. **Install Nginx**
   ```bash
   # Update ansible-playbooks/inventory with server IP
   terraform output server_ips
   ansible-playbook -i ansible-playbooks/inventory ansible-playbooks/install_nginx.yml
   ```

4. **Test**
   ```bash
   curl http://<SERVER_IP>
   ```

## Configuration

- Edit `terraform.tfvars` for server count, regions, instance types
- Modify `ansible-playbooks/inventory` with server IPs

## Cleanup

```bash
terraform destroy
```