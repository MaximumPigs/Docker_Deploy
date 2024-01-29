# provider information

variable "key_pair" {
  type = string
}

# network information

variable "my_ip" {
  type    = string
  default = ""
}

# infra

variable "instance_state" {
  type    = string
  default = "running"
}