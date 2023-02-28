resource "aws_security_group" "web_inbound_sg" {
 name = "${var.environment}-web-inbound-sg"
 description = "Allow HTTP from Anywhere into ALB"
 vpc_id = "${var.vpc_id}"
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 8
  to_port = 0
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
  Name = "${var.environment}-web-inbound-sg"
 }
}