resource "aws_alb_target_group" "alb_target_group" {
  name = "${var.environment}-alb-target-group-${random_id.target_group_sufix.hex}"
  port = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
  target_type = "ip"
 lifecycle {
  create_before_destroy = true
  }
}