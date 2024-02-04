resource "docker_image" "image" {
  name = "jammsen/palworld-dedicated-server:latest"
}

resource "docker_container" "container" {
  name  = "palworld"
  image = docker_image.image.image_id

  ports {
    internal = 8211
    external = 8211
    protocol = "udp"
  }

  ports {
    internal = 25575
    external = 25575
    protocol = "tcp"
  }

  env = [
    "SERVER_SETTINGS_MODE=auto",
    "ALWAYS_UPDATE_ON_START=true",
    "MAX_PLAYERS=10",
    "MULTITHREAD_ENABLED=true",
    "COMMUNITY_SERVER=false",
    "RCON_ENABLED=false",
    "RCON_PORT=25575",
    "PUBLIC_IP=${var.instance_ip}",
    "PUBLIC_PORT=8211",
    "SERVER_NAME=${var.server_name}",
    "SERVER_DESCRIPTION=BroPals, Bro",
    "ADMIN_PASSWORD=${var.server_password}!",
    "SERVER_PASSWORD=${var.server_password}",
    "WEBHOOK_ENABLED=${local.discord_webhook_enable}",
    "WEBHOOK_URL=${var.discord_webhook}",
    "WEBHOOK_START_TITLE=Server is up",
    "WEBHOOK_START_DESCRIPTION=The gameserver is up, at ${var.instance_ip}:8211, join now with password ${var.server_password}"
  ]

  mounts {
    type   = "bind"
    target = "/palworld"
    source = "/data"
  }
}