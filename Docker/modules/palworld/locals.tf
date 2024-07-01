locals {
  discord_webhook_enable = var.discord_webhook == "" ? false : true
}