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
  scope_id    = boundary_scope.bms.id
  account_ids = [
    boundary_account.admin_users_acct[count.index].id
  ]

  depends_on = [
    boundary_account.admin_users_acct
  ]
}

resource "boundary_group" "admins" {
  name        = "admin"
  description = "Organization group for admin users"
  member_ids  = [for user in boundary_user.admin_users : user.id]
  scope_id    = boundary_scope.bms.id
}
