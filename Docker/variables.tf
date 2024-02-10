# instance information

variable "instance_ip" {
  type = string
}

variable "server_name" {
  type    = string
  default = "blank"
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
  type = string
}

variable "memory" {
  type = number
}