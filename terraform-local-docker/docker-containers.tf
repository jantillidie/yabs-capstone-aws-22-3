resource "docker_container" "mariadb_container" {
  name         = "db_yabs"
  image        = docker_image.mariadb_image.image_id
  command      = ["--default-authentication-plugin=mysql_native_password"]
  restart      = "always"
  network_mode = "wp_net_yabs"
  env = [
    var.MYSQL_ROOT_PASSWORD,
    var.MYSQL_DATABASE,
    var.MYSQL_USER,
    var.MYSQL_PASSWORD
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
    var.WORDPRESS_DB_HOST,
    var.WORDPRESS_DB_USER,
    var.WORDPRESS_DB_PASSWORD,
    var.WORDPRESS_DB_NAME
  ]
  mounts {
    type   = "volume"
    target = "/var/www/html"
    source = "wp_data"
  }
}
