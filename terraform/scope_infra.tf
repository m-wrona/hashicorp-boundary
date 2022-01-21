resource "boundary_scope" "bms_core_infra" {
  name                     = "core_infra"
  description              = "Project for core part of infrastructure"
  scope_id                 = boundary_scope.bms.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_role" "corainfa_admin" {
  name        = "admin"
  description = "Administrator role"
  principal_ids = concat(
    [for user in boundary_user.admin_users : user.id],
    ["u_auth"]
  )
  grant_strings = ["id=*;type=*;actions=*;output_fields=*"]
  scope_id      = boundary_scope.bms_core_infra.id
}
