# instance information

variable "instance_ip" {
  type    = string
  default = "3.106.164.103"
}

variable "server_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "discord_webhook" {
  type      = string
  default   = ""
  sensitive = true
}