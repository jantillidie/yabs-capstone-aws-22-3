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
