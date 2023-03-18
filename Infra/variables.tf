# provider information

variable "key_pair" {
  type = string
}

# network information

variable "my_ip" {
  type = string
}

variable "runner_ip" {
  type = string
}

variable "storage_id" {
  type = string
}

# AWS specific information

variable "availability_zone" {
  type    = string
  default = "ap-southeast-2a"
}