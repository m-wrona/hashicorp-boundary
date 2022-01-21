resource "boundary_host_catalog" "nginx" {
  name        = "nginx"
  description = "Nginx running on docker"
  type        = "static"
  scope_id    = boundary_scope.bms_core_infra.id
}

resource "boundary_host" "nginx_1" {
  type            = "static"
  name            = "nginx - instance 1"
  description     = "Nginx instance"
  address         = "nginx"
  host_catalog_id = boundary_host_catalog.nginx.id
}

resource "boundary_host_set" "nginx" {
  type            = "static"
  name            = "nginx"
  description     = "Nginx cluster"
  host_catalog_id = boundary_host_catalog.nginx.id
  host_ids = [
    boundary_host.nginx_1.id
  ]
}

resource "boundary_target" "nginx" {
  type         = "tcp"
  name         = "nginx"
  description  = "HTTP access to nginx server"
  scope_id     = boundary_scope.bms_core_infra.id
  default_port = "80"

  session_connection_limit = -1
  session_max_seconds      = 2

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

  session_connection_limit = -1
  session_max_seconds      = 2

  host_set_ids = [
    boundary_host_set.nginx.id
  ]
}
