resource "docker_image" "image" {
  name = "itzg/minecraft-bedrock-server:latest"
}

resource "docker_container" "container" {
  name  = "nginx"
  image = docker_image.image.image_id

  ports {
    internal = 19132
    external = 19132
    protocol = "udp"
  }

  env = [
    "EULA=TRUE",
    "SERVER_NAME=Chicken",
    "GAMEMODE=creative"
  ]

  volumes {
    volume_name    = "mc-bedrock-data"
    container_path = "/data"
    host_path      = "/mnt/data"
  }

}