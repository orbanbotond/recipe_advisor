resource "aws_ecr_repository" "rails_terraform_app" {
 name = "${var.repository_name}"
}