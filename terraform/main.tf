resource "boundary_scope" "global" {
  global_scope = true
  description  = "Global scope"
  scope_id     = "global"
}

resource "boundary_scope" "corp" {
  name                     = "bms"
  description              = "Big Mike Solutions"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

## Use password auth method
resource "boundary_auth_method" "password" {
  name     = "Corp Password"
  scope_id = boundary_scope.corp.id
  type     = "password"
}

resource "boundary_account" "admin_users_acct" {
  count          = length(local.admin_users)
  name           = local.admin_users[count.index]
  description    = "User account for ${local.admin_users[count.index]}"
  type           = "password"
  login_name     = lower(local.admin_users[count.index])
  password       = "password"
  auth_method_id = boundary_auth_method.password.id
}

resource "boundary_user" "admin_users" {
  count       = length(local.admin_users)
  name        = local.admin_users[count.index]
  description = "User ${local.admin_users[count.index]}"
  scope_id    = boundary_scope.corp.id
  account_ids = [
    boundary_account.admin_users_acct[count.index].id
  ]

  depends_on = [
    boundary_account.admin_users_acct
  ]
}

resource "boundary_account" "readonly_users_acct" {
  count          = length(local.readonly_users)
  name           = local.readonly_users[count.index]
  description    = "User account for ${local.readonly_users[count.index]}"
  type           = "password"
  login_name     = lower(local.readonly_users[count.index])
  password       = "password"
  auth_method_id = boundary_auth_method.password.id
}

resource "boundary_user" "readonly_users" {
  count       = length(local.readonly_users)
  name        = local.readonly_users[count.index]
  description = "User ${local.readonly_users[count.index]}"
  scope_id    = boundary_scope.corp.id
  account_ids = [
    boundary_account.readonly_users_acct[count.index].id
  ]

  depends_on = [
    boundary_account.readonly_users_acct
  ]
}

resource "boundary_group" "readonly" {
  name        = "read-only"
  description = "Organization group for readonly users"
  member_ids  = [for user in boundary_user.readonly_users : user.id]
  scope_id    = boundary_scope.corp.id
}

resource "boundary_role" "organization_readonly" {
  name          = "Read-only"
  description   = "Read-only role"
  principal_ids = [boundary_group.readonly.id]
  grant_strings = ["id=*;type=*;actions=read"]
  scope_id      = boundary_scope.corp.id
}

resource "boundary_role" "organization_admin" {
  name        = "admin"
  description = "Administrator role"
  principal_ids = concat(
    [for user in boundary_user.admin_users : user.id]
  )
  grant_strings = ["id=*;type=*;actions=create,read,update,delete"]
  scope_id      = boundary_scope.corp.id
}

resource "boundary_scope" "core_infra" {
  name                   = "core_infra"
  description            = "Project for core part of infrastructure"
  scope_id               = boundary_scope.corp.id
  auto_create_admin_role = true
}
