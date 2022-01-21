resource "boundary_host_catalog" "nginx" {
  name        = "nginx"
  description = "Nginx running on docker"
  type        = "static"
  scope_id    = boundary_scope.bms_core_infra.id
}

resource "boundary_host" "nginx" {
  type            = "static"
  name            = "nginx"
  description     = "Nginx instance"
  address         = "localhost"
  host_catalog_id = boundary_host_catalog.nginx.id
}

resource "boundary_host_set" "nginx" {
  type            = "static"
  name            = "nginx"
  description     = "Nginx servers"
  host_catalog_id = boundary_host_catalog.nginx.id
  host_ids = [
    boundary_host.nginx.id
  ]
}

resource "boundary_target" "nginx" {
  type         = "tcp"
  name         = "nginx"
  description  = "HTTP access to nginx server"
  scope_id     = boundary_scope.bms_core_infra.id
  default_port = "8080"

  host_set_ids = [
    boundary_host_set.nginx.id
  ]
}

resource "boundary_target" "nginx_ssh" {
  type         = "tcp"
  name         = "nginx-ssh"
  description  = "SSH access to Nginx server"
  scope_id     = boundary_scope.bms_core_infra.id
  default_port = "22"

  host_set_ids = [
    boundary_host_set.nginx.id
  ]
}
