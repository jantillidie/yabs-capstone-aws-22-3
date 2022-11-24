variable "MYSQL_ROOT_PASSWORD" {
  description = "Database root password"
  type = string
  sensitive   = true
}
variable "MYSQL_DATABASE" {
  description = "Database name"
  type = string
  sensitive   = true
}
variable "MYSQL_USER" {
  description = "Database user"
  type = string
  sensitive   = true
}
variable "MYSQL_PASSWORD" {
  description = "Database password"
  type = string
  sensitive   = true
}
variable "WORDPRESS_DB_HOST" {
  description = "Database container name"
  type = string
  sensitive   = true
}
variable "WORDPRESS_DB_USER" {
  description = "Database user"
  type = string
  sensitive   = true
}
variable "WORDPRESS_DB_PASSWORD" {
  description = "Database password"
  type = string
  sensitive   = true
}
variable "WORDPRESS_DB_NAME" {
  description = "Database name"
  type = string
  sensitive   = true
}
