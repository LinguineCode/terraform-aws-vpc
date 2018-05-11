# terraform-aws-vpc

A terraform module that takes a simple approach to setting up a VPC with all the dozens of related resources in only ~100 lines of code.

## Features

  1. Creates VPC, NAT gateways, routing tables, routes. Unlimited quantity of private/public subnets-per-AZ based on your input.
  1. Automatically discover availability zones.
  1. Automatically calculate CIDR ranges based on quantity of availability zones and the size you want the subnets to be.
  1. Create two NAT Gateways and assign them to subnets on an odd/even basis for multi-AZ.
  1. Resists the temptation to allow for snowflake customization features like VPC Peering, VPN routing, DHCP Options, etc. Keep it simple, when possible.