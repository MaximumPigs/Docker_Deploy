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
    "ALWAYS_UPDATE_ON_START=true",
    "MAX_PLAYERS=32",
    "MULTITHREAD_ENABLED=true",
    "COMMUNITY_SERVER=true",
    "RCON_ENABLED=true",
    "RCON_PORT=25575",
    "PUBLIC_IP=${var.instance_ip}",
    "PUBLIC_PORT=8211",
    "SERVER_NAME=[AU]BroWorld",
    "SERVER_DESCRIPTION=BroWorld, Bro",
    "SERVER_PASSWORD=Icecream420Sandwich69Nice",
    "ADMIN_PASSWORD=Icecream420Sandwich69Nice!"
  ]

  volumes {
    container_path = "/palworld"
    host_path      = "/data"
  }
}