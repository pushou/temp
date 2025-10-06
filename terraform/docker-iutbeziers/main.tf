
# Pulls the image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

# Create a container
resource "docker_container" "foo" {
  count             = 3
  image             = docker_image.ubuntu.image_id
  name              = "foo"
  must_run          = true
  publish_all_ports = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]
}
