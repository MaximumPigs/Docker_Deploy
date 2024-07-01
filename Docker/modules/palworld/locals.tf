locals {
  discord_webhook_enable = length(var.discord_webhook) > 0 ? true : false
}