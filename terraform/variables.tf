variable "users" {
  type    = set(string)
  default = [
    "m-wrona",
    "Mike",
  ]
}

variable "readonly_users" {
  type    = set(string)
  default = [
    "Tom",
    "Jerry",
  ]
}

variable "backend_server_ips" {
  type    = set(string)
  default = [
    "10.1.0.1",
    "10.1.0.2",
  ]
}
