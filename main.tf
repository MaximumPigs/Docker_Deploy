resource "docker_image" "hello-world" {
  name = "hello-world:latest"
}

resource "docker_container" "hello-world" {
  name = "hello-world"
  image = docker_image.hello-world.image_id
}