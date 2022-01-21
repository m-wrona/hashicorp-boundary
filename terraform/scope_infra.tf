resource "boundary_scope" "bms_core_infra" {
  name                     = "core_infra"
  description              = "Project for core part of infrastructure"
  scope_id                 = boundary_scope.bms.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_role" "core_infra_readonly" {
  name          = "Core-infra read-only"
  description   = "Read-only role for core-infra"
  principal_ids = [boundary_group.readonly.id]
  grant_strings = ["id=*;type=*;actions=read;output_fields=*"]
  scope_id      = boundary_scope.bms.id
}

resource "boundary_role" "core_infa_admin" {
  name        = "core-infra admin"
  description = "Administrator role for core-infra"
  principal_ids = [boundary_group.admins.id]
  grant_strings = ["id=*;type=*;actions=*;output_fields=*"]
  scope_id      = boundary_scope.bms_core_infra.id
}
