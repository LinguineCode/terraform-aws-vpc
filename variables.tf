variable "cidr_block"     {
  description = "VPC CIDR block"
  default = "10.0.0.0/16"
}

variable "cidr_newbits"   {
  description = "VPC subnet newbits"
  default = "6"
}

variable "name_tag_prefix" {
  description = "Resources tags will be prefixed with this string"
  default = ""
}

variable "private_subnet_nametags" {
  description = "List of private subnet nametags"
  default = ["private"]
}

variable "public_subnet_nametags"  {
  description = "List of public subnet nametags"
  default = ["public"]
}