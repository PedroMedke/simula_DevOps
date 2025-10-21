terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_volume" "pgdata" {
  name = "pgdata"
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = "postgres:14"
  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=admin",
    "POSTGRES_DB=app_db"
  ]
  ports {
    internal = 5432
    external = 5432
  }
  volumes {
    volume_name    = docker_volume.pgdata.name
    container_path = "/var/lib/postgresql/data"
  }
}


resource "docker_image" "api_image" {
  name = "api_image:latest"
  build {
    context    = "./app-build"
    dockerfile = "Dockerfile"
    no_cache   = true
  }
}

resource "docker_container" "api_container" {
  name  = "api_container"
  image = docker_image.api_image.name
  ports {
    internal = 3000
    external = 3000
  }
  env = [
    "DB_HOST=postgres",
    "DB_USER=admin",
    "DB_PASSWORD=admin",
    "DB_NAME=app_db",
    "DB_PORT=5432"
  ]
  depends_on = [docker_container.postgres]
}
