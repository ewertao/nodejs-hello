# NODEJS-HELLO

Hello World.
___

## Description

This is a containerized "Hello World" application written in Node.js based on a Youtube¹ video, running on a ECS (Elastic Container Service). 
By implementing Infrastructure as a Code (IaaC) via Terraform Modules² ³ and the Application following the CI/CD pipeline via Github.


___

## Main Technologies

#### Code

***Node.js*** is the programming language used to develop the system


#### Build and Repository

The application build and its storage is done by ***Github***
Infrastructure as a Code is made by ***Terraform***

#### Servers

The application image runs on ***Docker Containers*** orchestrated by a ***AWS ECS Fargate***

___

## Architecture

ECR and ECS Fargate needs to be create first by code.

Github stores all the code package.

Github has an OIDC Provider that permits it to assume a propre role to execute Github Action pushing images to ECR assuming a Role and not a user profile.

ECS Fargate requests ECR nodejs-hello image and deploys

User can access the public IP using the port 8080


![Screenshot 2023-04-18 174637](https://user-images.githubusercontent.com/66280558/232989899-c4a940ec-3254-4102-9135-c136f105d99f.png)

___

## How to

1. Clone the repository to your local machine.
2. On terraform folder run `terraform init` to download all dependencies and modules.
3. After download, run `terraform plan `to check all infrastructure deploy followed by `terraform apply`.
4. Move to nodejs-hello folder and run `git push` to start the pipeline on Github.


---

### Credits, Sources and References

***¹ https://www.youtube.com/watch?v=8MlO2oSBdYw&t=1120s***

***² https://registry.terraform.io/modules/terraform-aws-modules/ecr/aws/latest#public-repository***

***³ https://registry.terraform.io/modules/terraform-aws-modules/ecs/aws/latest#fargate-capacity-providers***
