data "docker_image" "debianiut" {
  name = "registry.iutbeziers.fr/debianiut:latest"
}

# Pulls the image
resource "docker_image" "debianiut" {
  name = data.docker_image.debianiut.name
}

# Create a container
resource "docker_container" "debianiut" {
  count             = 1
  image             = docker_image.debianiut.name
  name              = "debianiut"
  must_run          = true
  publish_all_ports = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]
}
