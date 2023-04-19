module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "nodejs-hello-1"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Hello"
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name_prefix       = "nodejs-hello-1logs"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "this" {
  family                   = "nodejs-hello-1tasks"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"

  execution_role_arn = "arn:aws:iam::777156806021:role/githubactionprovider-role"


  container_definitions = <<EOF
[
  {
    "name": "nodejs-hello-1cont",
    "image": "public.ecr.aws/d0y1a6a0/nodejs-hello",
    "portMappings": [
        {
            "containerPort": 8080,
            "hostPort": 8080
        }
    ],
    "cpu": 256,
    "memory": 512,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "us-east-1",
        "awslogs-group": "${aws_cloudwatch_log_group.this.name}",
        "awslogs-stream-prefix": "ec2"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "this" {
  name            = "nodejs-hello-1taskdef"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-03fd28980b2369959", "subnet-0a10fbb089d5486e0"]
    security_groups  = ["sg-01aa38bb901146c8e"]
    assign_public_ip = true
  }


  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}