resource "aws_launch_template" "ev_lt" {
  name_prefix   = "ev-lt-"
  image_id      = "ami-0c7217cdde317cfec"  # Ubuntu 22.04 LTS us-east-1
  instance_type = var.instance_type
  key_name      = "ev-key"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y python3 python3-pip unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && ./aws/install
mkdir -p /var/www/html
chown -R ubuntu:ubuntu /var/www/html
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = { Name = "ev-station-instance" }
  }
}
