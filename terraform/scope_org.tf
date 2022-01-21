resource "boundary_scope" "bms" {
  name                     = "bms"
  description              = "Big Mike Solutions"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

## Use password auth method
resource "boundary_auth_method" "password" {
  name     = "Corp Password"
  scope_id = boundary_scope.bms.id
  type     = "password"
}

resource "boundary_role" "organization_readonly" {
  name          = "Read-only"
  description   = "Read-only role"
  principal_ids = [boundary_group.readonly.id]
  grant_strings = ["id=*;type=*;actions=read;output_fields=*"]
  scope_id      = boundary_scope.bms.id
}

resource "boundary_role" "organization_admin" {
  name        = "admin"
  description = "Administrator role"
  principal_ids = concat(
    [for user in boundary_user.admin_users : user.id],
    ["u_auth"]
  )
  grant_strings  = ["id=*;type=*;actions=*;output_fields=*"]
  scope_id       = "global"
  grant_scope_id = boundary_scope.bms.id
}

