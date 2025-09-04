variable "aws_region" {
  description = "AWS region"
  type = string
  default = "eu-north-1"
}

variable "project_name" {
  description = "Project name"
  type = string
  default = "salsify-task"
}

variable "docker_img" {
  description = "Project name"
  type = string
  default = "gitmachine-3526d67646a16929e36117f9f5974cf080c806ac"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
}

variable "db_subnet_cidrs" {
  type = list(string)
  default = ["10.0.20.0/24","10.0.21.0/24","10.0.22.0/24"]
}

variable "node_instance_type" {
  type = string
  default = "t3.medium"
}

variable "node_desired_capacity" {
  type = number
  default = 2
}

variable "rds_username" {
  type = string
  default = "appuser"
}

variable "family" {
  type = string
  default = "postgres15"
}

variable "rds_password" {
  type = string
  default = "ChangeMe123!" # replace with secure secret or pass via -var-file or secrets manager
}
