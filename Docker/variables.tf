# instance information

variable "instance_ip" {
  type    = string
  default = "54.252.187.239"
}

variable "server_name" {
  type    = string
  default = ""
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

variable "game" {
  type    = string
  default = ""
}