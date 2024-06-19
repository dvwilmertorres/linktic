variable "aws_region" {
  description = "the aws region to deploy in"
  default     = "us-east-1"
}
variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}
variable "key_name" {
  description = "ssh key name"
  default     = "dvwilmertorres"
}
variable "ami_ubuntu" {
  description = "ami base by ubuntu"
  default     = "ami-04b70fa74e45c3917"
}
variable "ami_redhat" {
  description = "ami base by RedHat"
  default     = "ami-0fe630eb857a6ec83"
}
variable "db_name" {
  description = "linktic"
  default     = "linkticdb"
}
variable "db_username" {
  description = "admin"
  default     = "admin"
}
variable "db_password" {
  description = "admin"
  default     = "admin"
}