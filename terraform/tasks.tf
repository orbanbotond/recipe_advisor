/* the task definition for the web service */
data "template_file" "web_task" {
 template = "${file("${path.module}/tasks/web_task_definition.json")}"
vars = {
 image = "${aws_ecr_repository.rails_terraform_app.repository_url}"
 secret_key_base = "${var.secret_key_base}"
 database_url = "postgresql://${var.database_username}:${var.database_password}@${var.database_endpoint}:5432/${var.database_name}?encoding=utf8&pool=40"
 log_group = "${aws_cloudwatch_log_group.rails_terraform.name}"
 }
}
resource "aws_ecs_task_definition" "web" {
 family = "${var.environment}_web"
 container_definitions = "${data.template_file.web_task.rendered}"
 requires_compatibilities = ["FARGATE"]
 network_mode = "awsvpc"
 cpu = "256"
 memory = "512"
 execution_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
 task_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
}
/* the task definition for the db migration */
data "template_file" "db_migrate_task" {
 template = "${file("${path.module}/tasks/db_migrate_task_definition.json")}"
vars = {
 image = "${aws_ecr_repository.rails_terraform_app.repository_url}"
 secret_key_base = "${var.secret_key_base}"
 database_url = "postgresql://${var.database_username}:${var.database_password}@${var.database_endpoint}:5432/${var.database_name}?encoding=utf8&pool=40"
 log_group = "rails_terraform"
 }
}
resource "aws_ecs_task_definition" "db_migrate" {
 family = "${var.environment}_db_migrate"
 container_definitions = "${data.template_file.db_migrate_task.rendered}"
 requires_compatibilities = ["FARGATE"]
 network_mode = "awsvpc"
 cpu = "256"
 memory = "512"
 execution_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
 task_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
}