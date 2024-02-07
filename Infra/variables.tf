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

variable "runner_access_enabled" {
  type    = bool
  default = true
}

# AWS information

variable "AWS_BUCKET_ACCESS_KEY" {
  type      = string
  sensitive = true
}

variable "AWS_BUCKET_SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
}