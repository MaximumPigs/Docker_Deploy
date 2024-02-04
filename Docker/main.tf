module "palworld" {
  source          = "./modules/palworld"
  count           = var.game == "palworld" ? 1 : 0
  server_name     = var.server_name
  instance_ip     = var.instance_ip
  server_password = var.server_password
  discord_webhook = var.discord_webhook
}

module "enshrouded" {
  source          = "./modules/enshrouded"
  count           = var.game == "enshrouded" ? 1 : 0
  server_name     = var.server_name
  instance_ip     = var.instance_ip
  server_password = var.server_password
  discord_webhook = var.discord_webhook
}

output "game" {
  value = var.game
}