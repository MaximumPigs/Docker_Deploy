# provider information

variable "key_pair" {
  type    = string
  default = "MaximumPigs_Key_Pair"
}

# network information

variable "my_ip" {
  type    = string
  default = ""
}

variable "game" {
  type = string
}

variable "environment" {
  type = string
}

variable "runner_access_enabled" {
  type    = bool
  default = true
}

variable "vm_size" {
  type    = string
  default = "default"
}