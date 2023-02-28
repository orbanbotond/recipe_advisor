resource "aws_iam_role" "ecs_autoscale_role" {
 name = "${var.environment}_ecs_autoscale_role"
 assume_role_policy = "${file("${path.module}/policies/ecs-autoscale-role.json")}"
}
resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
 name = "ecs_autoscale_role_policy"
 policy = "${file("${path.module}/policies/ecs-autoscale-role-policy.json")}"
 role = "${aws_iam_role.ecs_autoscale_role.id}"
}
resource "aws_appautoscaling_target" "target" {
 service_namespace = "ecs"
 resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 role_arn = "${aws_iam_role.ecs_autoscale_role.arn}"
 min_capacity = 2
 max_capacity = 4
}
resource "aws_appautoscaling_policy" "up" {
 name = "${var.environment}_scale_up"
 service_namespace = "ecs"
 resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  metric_aggregation_type = "Maximum"
  step_adjustment {
   metric_interval_lower_bound = 0
   scaling_adjustment = 1
  }
 }
depends_on = ["aws_appautoscaling_target.target"]
}
resource "aws_appautoscaling_policy" "down" {
 name = "${var.environment}_scale_down"
 service_namespace = "ecs"
 resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
 scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  metric_aggregation_type = "Maximum"
  step_adjustment {
   metric_interval_lower_bound = 0
   scaling_adjustment = -1
  }
 }
depends_on = ["aws_appautoscaling_target.target"]
}
/* metric used for auto scale */
resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
 alarm_name = "${var.environment}_rails_terraform_web_cpu_utilization_high"
 comparison_operator = "GreaterThanOrEqualToThreshold"
 evaluation_periods = "3"
 metric_name = "CPUUtilization"
 namespace = "AWS/ECS"
 period = "60"
 statistic = "Maximum"
 threshold = "70"
 dimensions = {
  ClusterName = "${aws_ecs_cluster.cluster.name}"
  ServiceName = "${aws_ecs_service.web.name}"
 }
 alarm_actions = ["${aws_appautoscaling_policy.up.arn}"]
 ok_actions = ["${aws_appautoscaling_policy.down.arn}"]
}