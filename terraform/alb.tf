resource "aws_alb" "alb_rails-terraform" {
 name = "${var.environment}-alb-rails-terraform"
 subnets = "${var.public_subnet_ids}"
 security_groups = "${concat(var.security_groups_ids, [aws_security_group.web_inbound_sg.id])}"
 tags = {
  Name = "${var.environment}-alb-rails_terraform"
  Environment = "${var.environment}"
  }
}
resource "aws_alb_listener" "rails_terraform" {
 load_balancer_arn = "${aws_alb.alb_rails-terraform.arn}"
 port = "80"
 protocol = "HTTP"
 depends_on = ["aws_alb_target_group.alb_target_group"]
 default_action {
  target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
  type = "forward"
 }
}