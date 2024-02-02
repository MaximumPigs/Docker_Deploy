# instance information

variable "instance_ip" {
  type    = string
  default = "3.25.127.56"
}

variable "server_password" {
  type    = string
  default = ""
  sensitive = true
}

variable "github_webhook" {
  type    = string
  default = ""
  sensitive = true
}