variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_types" {
  description = "EC2 instance types for each server"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "server_count" {
  description = "Number of servers to create"
  type        = number

  validation {
    condition     = var.server_count > 0 && var.server_count <= 10
    error_message = "Server count must be between 1 and 10."
  }
}

variable "server_names" {
  description = "Names for the servers"
  type        = list(string)

  validation {
    condition     = length(var.server_names) > 0
    error_message = "Server names list cannot be empty."
  }
}

variable "environments" {
  description = "Environment for each server"
  type        = list(string)
}

variable "server_ports" {
  description = "Port configuration for each server"
  type        = list(list(number))
}

variable "associate_public_ip" {
  description = "Associate public IP address"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed for ingress"
  type        = list(string)
}

