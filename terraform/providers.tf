terraform {
  required_version = ">= 0.15.5"
}

provider "boundary" {
  addr                            = "http://127.0.0.1:9200"
  auth_method_id                  = "ampw_SmoCM2Flem"
  password_auth_method_login_name = "admin"
  password_auth_method_password   = "JYGOuBvHy7U20mN8aWCT"
}