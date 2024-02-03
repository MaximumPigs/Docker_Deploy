resource "docker_image" "image" {
  name = "sknnr/enshrouded-dedicated-server:latest"
}

resource "docker_container" "container" {
  name  = "enshrouded"
  image = docker_image.image.image_id

  ports {
    internal = 15636
    external = 15636
    protocol = "udp"
  }

  ports {
    internal = 15636
    external = 15636
    protocol = "tcp"
  }

  ports {
    internal = 15637
    external = 15637
    protocol = "udp"
  }

  ports {
    internal = 15637
    external = 15637
    protocol = "tcp"
  }  

  env = [
    "SERVER_NAME=[AU]BroShrouded",
    "SERVER_PASSWORD=${var.server_password}",
    "SERVER_IP=${var.instance_ip}",
    "GAME_PORT=15636",
    "QUERY_PORT=15637",
    "SERVER_SLOTS=10"
  ]

  mounts {
    type   = "bind"
    target = "/home/steam/enshrouded/savegame"
    source = "/data/enshrouded"
  }
}