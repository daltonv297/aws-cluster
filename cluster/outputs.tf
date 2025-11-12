output "head_public_ip" {
  description = "Public IP of the head node"
  value       = aws_instance.head.public_ip
}

output "head_private_ip" {
  description = "Private IP of the head node"
  value       = aws_instance.head.private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.cluster_vpc.id
}

output "worker_asg_name" {
  description = "Name of the worker Auto Scaling Group"
  value       = aws_autoscaling_group.workers.name
}
