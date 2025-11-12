variable "allowed_ssh_cidr" {
  type = string
}

variable "ami_id" {
  description = "AMI ID for head and workers (Amazon Linux 2023 kernel-6.12)"
  type        = string
  default     = "ami-03c870feb7c37e4ff"
}

variable "key_name" {
  description = "Name of EC2 key pair to use for SSH"
  type        = string
}
