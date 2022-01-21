resource "boundary_scope" "global" {
  global_scope = true
  description  = "Global scope"
  scope_id     = "global"
}