resource "aws_instance" "servers" {
  count                       = var.server_count
  ami                         = var.ami_id
  instance_type               = var.instance_types[count.index]
  key_name                    = aws_key_pair.server_key.key_name
  vpc_security_group_ids      = [aws_security_group.server_sg[count.index].id]
  associate_public_ip_address = var.associate_public_ip
  monitoring                  = true


  root_block_device {
    encrypted = true
  }

  tags = {
    Name        = var.server_names[count.index]
    Environment = var.environments[count.index]
  }
}
