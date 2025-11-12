resource "aws_instance" "head" {
  ami                         = var.ami_id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  key_name                    = "default"
  vpc_security_group_ids      = [aws_security_group.cluster_sg.id]
  placement_group             = aws_placement_group.cluster_pg.name
}

resource "aws_launch_template" "worker_lt" {
  name_prefix            = "cluster-worker-"
  image_id               = var.ami_id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.cluster_sg.id]
  placement {
    group_name = aws_placement_group.cluster_pg.name
  }
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
    }
  }
}

resource "aws_autoscaling_group" "workers" {
  name                = "cluster-workers"
  max_size            = 10
  min_size            = 0
  desired_capacity    = 5
  vpc_zone_identifier = [aws_subnet.private_subnet.id]
  launch_template {
    id      = aws_launch_template.worker_lt.id
    version = "$Latest"
  }
  capacity_rebalance = true
}
