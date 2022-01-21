resource "boundary_host_catalog" "postgres" {
  name        = "postgres"
  description = "Postgres databases running on docker"
  type        = "static"
  scope_id    = boundary_scope.bms_core_infra.id
}

resource "boundary_host" "postgres_1" {
  type            = "static"
  name            = "postgres - instance 1"
  description     = "Postgres instance"
  address         = "postgres"
  host_catalog_id = boundary_host_catalog.postgres.id
}

resource "boundary_host_set" "postgres" {
  type            = "static"
  name            = "Postgres cluster"
  description     = "CLI access to postgres server"
  host_catalog_id = boundary_host_catalog.postgres.id
  host_ids = [
    boundary_host.postgres_1.id
  ]
}

resource "boundary_target" "postgres" {
  type                     = "tcp"
  name                     = "postgres"
  description              = "Postgres server running on docker"
  scope_id                 = boundary_scope.bms_core_infra.id
  session_connection_limit = -1
  session_max_seconds      = 2
  default_port             = 5432
  host_set_ids = [
    boundary_host_set.postgres.id
  ]
}

resource "boundary_target" "postgres_ssh" {
  type         = "tcp"
  name         = "postgres-ssh"
  description  = "SSH access to Postgres server"
  scope_id     = boundary_scope.bms_core_infra.id
  default_port = "22"

  session_connection_limit = -1
  session_max_seconds      = 2

  host_set_ids = [
    boundary_host_set.postgres.id
  ]
}