# wordpressOnEKS

This repo contains a working example of deploying an application on AWS EKS with managed node group. The project is structured to allow multiple environments.

## Requirements

* [tfswicth](https://warrensbox.github.io/terraform-switcher/) (or Terraform 0.12.24)
* wget
* kubectl
* Helm 3
* awscli installed and configured
* AWS account

## How to build it

The core infrastructure is written in terraform and all the code is under the terraform directory.
The prod directory containes the live code. EVery module can be customized by editing the **locals.tf** file.

To install the proper version of terraform:

```
cd terraform
tfswitch
```

There's a logical dependency among modules and as such you should build the following modules first
and in the following particular order.

1. terraform/prod/tfstate
2. terraform/prod/network
3. terraform/prod/eks

The remaining modules can be applied in any order.

The tfstate module contains the resources that host the terraform state. As usual 
the s3 backed code in the backed.tf file should be commented out the first time you 
run ''terraform init''.

Once the terraform has being applied you can start deploying applications on the k8s cluster by issueing this command:

```
aws eks update-kubeconfig --name wponeks-prod
```

A sample wordpress application is in the **application** folder.

The application leverage the docker image in the application/docker/wordpress directory.
The application/helm directory contains all the necessary resources to actually deploy 
the application on k8s.

You can build the image with the following commands:

```
cd application/docker/wordpress
docker build -t wponeks-prod-wordpress .
docker tag wponeks-prod-wordpress 123456789123.dkr.ecr.eu-west-1.amazonaws.com/wponeks-prod-wordpress:stable-1.0
$(aws ecr get-login)
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 123456789123.dkr.ecr.eu-west-1.amazonaws.com/wponeks-prod-wordpress
docker push 123456789123.dkr.ecr.eu-west-1.amazonaws.com/wponeks-prod-wordpress:stable-1.0.0
```

where 123456789123.dkr.ecr.eu-west-1.amazonaws.com/wponeks-prod-wordpress is your ecr repository.

Once the image is available in the repository you can install the helm chart simply by:

```
cd application/helm/mywp
helm install mywp .
```

Tweak the parameters in application/helm/mywp/template/values.yaml to suit your needs.

## Infrastructure

The infrastructure is composed by a vpc with 6 subents: 2 public, 2 private, 2 database.
Each subnet is in a different AZ.
The EKS cluster is composed by two managed node groups, each one in its own availability zone.

To support the application, a multi AZ RDS instance, an ECR repository and an EFS storage had been deployed.

## Missing points

* Cluster Autoscaler
* Horizontal pod autoscaler
* Properly manage secrets by avoiding to have them in clear text in git
* Automatically manage the external dns
* https terminated on the ALB
* Properly configuring monitoring and alerting
* Properly configuring AWS backup for efs and rds
* Configure wordpress to offload the static assets to s3
* Hardening nginx configuration specifically for wordpress
* Ship applications logs to cloudwatch