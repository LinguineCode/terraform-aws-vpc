# terraform-aws-vpc

A terraform module that takes a simple approach to setting up a VPC and all related resources in only ~100 lines of code.

## Features

  1. Automatically discover availability zones
  1. Automatically calculate CIDR ranges. The only input needed is the VPC network ID and how big you want the subnets to be.
  1. Create two NAT Gateways for multi-AZ
  1. Unlimited amount of public subnets and private subnets
  1. Optionally launch an SSH bastion instance