terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.23.1"
    }
  }
}

provider "docker" {}

resource "docker_volume" "db_data" {}
resource "docker_volume" "wp_data" {}

resource "docker_network" "wp_net_yabs" {
  name = "wp_net_yabs"
}

resource "docker_image" "mariadb_image" {
  name = "mariadb:10.10.2"
}
resource "docker_image" "wordpress_image" {
  name = "wordpress:latest"
}

resource "docker_container" "mariadb_container" {
  name  = "db_yabs"
  image = docker_image.mariadb_image.image_id
  command      = ["--default-authentication-plugin=mysql_native_password"]
  restart      = "always"
  network_mode = "wp_net_yabs"
  env = [
    "MYSQL_ROOT_PASSWORD=somewordpress",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=wordpress"
  ]
  mounts {
    type   = "volume"
    target = "/var/lib/mysql"
    source = "db_data"
  }

}

resource "docker_container" "wp_container" {
  name  = "wp_yabs"
  image = docker_image.wordpress_image.image_id
  ports {
    internal = 80
    external = 8080
  }
  restart      = "always"
  network_mode = "wp_net_yabs"
  env = [
    "WORDPRESS_DB_HOST=db_yabs",
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_PASSWORD=wordpress",
    "WORDPRESS_DB_NAME=wordpress"
  ]
  mounts {
    type   = "volume"
    target = "/var/www/html"
    source = "wp_data"
  }
}

