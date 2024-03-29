# instance information

variable "instance_ip" {
  type    = string
  default = ""
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
  default   = null
  sensitive = true
}

variable "memory_limit" {
  type    = string
  default = "0"
}