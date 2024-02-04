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

variable "instance_state" {
  type    = string
  default = "running"
}

variable "game" {
  type    = string
  default = "enshrouded"
}

variable "runner_access_enabled" {
  type    = bool
  default = true
}