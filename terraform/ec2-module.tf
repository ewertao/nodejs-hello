module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "hello-world-ec2"

  ami                    = "ami-0fa03365cde71e0ab"
  instance_type          = "t2.micro"
  key_name               = "default"
  monitoring             = true
  vpc_security_group_ids = ["sg-088391bb7d9535cf0"]
  subnet_id              = "subnet-0dbbc5a928adacdb7"
  user_data              = "${file("user_data.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}