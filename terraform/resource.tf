# ECR repo

resource "aws_ecr_repository" "salsify-ecr" {
  name = "${var.project_name}-repo"
  image_tag_mutability = "IMMUTABLE"
}

# RDS
module "rds" {
  source = "terraform-aws-modules/rds/aws"
  version = ">=  6.12.0"
  identifier = "${var.project_name}-rds"
  engine = "postgres"
  engine_version = "15"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = "appdb"
  username = var.rds_username
  password = var.rds_password
  multi_az = true
  manage_master_user_password = true
  maintenance_window = "Mon:00:00-Mon:03:00"
  skip_final_snapshot = true
  family = var.family
  tags = {
    Name = "${var.project_name}-rds"
  }
}

# resource "aws_security_group" "rds_sg" {
#   name = "rds-sg"

#   ingress {
#     from_port = 5432
#     to_port = 5432
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

data "aws_secretsmanager_secret_version" "rds_master" {
  secret_id = module.rds.db_instance_master_user_secret_arn
}
locals {
  rds_creds = jsondecode(data.aws_secretsmanager_secret_version.rds_master.secret_string)
}

resource "aws_secretsmanager_secret" "db_url" {
  name = "database-app-url"
}

resource "aws_secretsmanager_secret_version" "db_url" {
  secret_id = aws_secretsmanager_secret.db_url.id
  secret_string = format(
    "postgres://%s:%s@%s:5432/%s",
    local.rds_creds.username,
    local.rds_creds.password,
    module.rds.db_instance_address,
    module.rds.db_instance_name
  )
}

output "database_url" {
  value = aws_secretsmanager_secret_version.db_url.secret_string
  sensitive = true
}