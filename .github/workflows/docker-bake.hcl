// docker-bake.hcl - for GitHub CI docker/bake-action@v4

target "docker-metadata-action" {}

target "build" {
  inherits = ["docker-metadata-action"]
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm/v7",
    "linux/arm/v8",
    "linux/arm64"
  ]
}