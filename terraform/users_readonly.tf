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
  scope_id    = boundary_scope.bms.id
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
  scope_id    = boundary_scope.bms.id
}
