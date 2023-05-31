
terraform {
    backend "s3" {
        bucket = "test1234omkarterraform"
        
        key = "backend-state"
        region = "ap-southeast-1"
        dynamodb_table = "Test_Dynamodb"
        encrypt = true
    }
}
variable "access" {}
variable "secret" {}
resource "aws_default_vpc" "default_vpc" {
}
data "aws_subnets" "subnets_id" {
  filter {
    name = "vpc-id"
    values = [aws_default_vpc.default_vpc.id]
  }
}



variable "ins_type" {
  default = "t2.micro"
}
variable "ami_id" {
  default = "ami-082b1f4237bd816a1"
}
