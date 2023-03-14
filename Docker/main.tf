resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 80
    protocol = "tcp"
  }
}