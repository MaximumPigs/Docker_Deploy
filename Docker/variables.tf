# instance information

variable "instance_ip" {
  type    = string
  default = "54.252.195.0"
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