variable "boundary_api_url" {
  type        = string
  description = "Url to Boundary API"
  default     = "http://127.0.0.1:9200"
}

variable "boundary_auth_method_id" {
  type        = string
  description = "Auth Method ID for chosen administrator"
  default     = "ampw_SmoCM2Flem"
}

variable "boundary_admin_user" {
  type        = string
  description = "Boundary admin name"
  default     = "admin"
}

variable "boundary_admin_pass" {
  type        = string
  description = "Boundary admin pass"
  default = "JYGOuBvHy7U20mN8aWCT"
}

variable "users" {
  type    = set(string)
  default = [
    "Jim",
    "Mike",
    "Todd",
    "Jeff",
    "Randy",
    "Susmitha"
  ]
}

variable "readonly_users" {
  type    = set(string)
  default = [
    "Chris",
    "Pete",
    "Justin"
  ]
}

variable "backend_server_ips" {
  type    = set(string)
  default = [
    "10.1.0.1",
    "10.1.0.2",
  ]
}
