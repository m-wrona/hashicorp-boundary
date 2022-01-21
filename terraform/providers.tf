terraform {
  required_version = ">= 0.15.5"
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.5"
    }
  }
}

provider "boundary" {
  addr             = "http://127.0.0.1:9200"
  recovery_kms_hcl = <<EOT
    kms "aead" {
      purpose = "recovery"
      aead_type = "aes-gcm"
      key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
      key_id = "global_recovery"
    }
EOT
}