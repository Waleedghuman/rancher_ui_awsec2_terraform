#========================================================================================================================================================
#                                                             AWS-instance                                                                    || 
#========================================================================================================================================================
resource "aws_instance" "rancher-server" {
  ami                         = var.image_id
  instance_type               = var.machine_type
  associate_public_ip_address = var.ec2_public_ip
  vpc_security_group_ids      = ["${aws_security_group.rancher-sg.id}"]
  key_name                    = aws_key_pair.rancher-keypair.key_name
  user_data                   = data.template_file.rancherui.rendered
  tags = {
    Name = "Rancher-UI"
  }
  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }
}
resource "aws_route53_record" "domain" {
  zone_id = data.aws_route53_zone.route53.id
  type    = var.route53_record_type
  name    = var.route53_domain
  ttl     = var.route53_ttl
  records = [aws_instance.rancher-server.public_ip]
}
data "aws_vpc" "default" {
  default = true
}
data "aws_route53_zone" "route53" {
  name = var.aws_route53_zone
}
data "template_file" "rancherui" {
  template = file("${path.module}/rancherui.sh")
  vars = {
    domain_name            = "${var.route53_domain}"
    local_k3s_version  = "${var.local_k3s_version}"
    rancher_server_version = "${var.rancher_server_version}"
  }
}
#========================================================================================================================================================
#                                                             ssh-key                                                                         || 
#========================================================================================================================================================
resource "aws_key_pair" "rancher-keypair" {
  key_name   = "rancher-keypair"
  public_key = file("${path.module}/id_rsa.pub")
}
#========================================================================================================================================================
#                                                            security group                                            
#========================================================================================================================================================

resource "aws_security_group" "rancher-sg" {
  name        = "rancher-sg"
  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id
  vpc_id = data.aws_vpc.default.id
  dynamic "ingress" {
    for_each = var.machine_ports
    iterator = port
    content {
      description = "ports to be open"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "rancher-sg"
  }
}
