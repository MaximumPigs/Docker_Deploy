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

variable "profile_name" {
  type    = string
  default = "Null"
}