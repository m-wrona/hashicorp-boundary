disable_mlock = true

controller {
  name = "docker-controller"
  description = "A controller for a docker demo!"
  database {
      url = "env://BOUNDARY_POSTGRES_URL"
  }
}

worker {
  name = "docker-worker"
  description = "A worker for a docker demo"
  // public address 127 because we're portforwarding the connection from docker to host machine.
  // So for the client running in host machine, the connection ip is 127
  // If you're using this in a remote server, then the ip should be changed to machine public address, so that your local machine can communicate to this worker.
  public_addr = "127.0.0.1"
}

listener "tcp" {
  address = "boundary"
  purpose = "api"
  tls_disable = true 
}

listener "tcp" {
  address = "boundary"
  purpose = "cluster"
  tls_disable = true 
}

listener "tcp" {
	address = "boundary"
	purpose = "proxy"
	tls_disable = true
}

// for dev purposes. Yoy can generate the keys by 
// `python3 kyegen.py`
// Ref: https://www.boundaryproject.io/docs/configuration/kms/aead
// Repo: https://github.com/hashicorp/boundary-reference-architecture/blob/main/deployment/docker/compose/keygen.py
kms "aead" {
  purpose = "root"
  aead_type = "aes-gcm"
  key = "sP1fnF5Xz85RrXyELHFeZg9Ad2qt4Z4bgNHVGtD6ung="
  key_id = "global_root"
}

kms "aead" {
  purpose = "worker-auth"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_worker-auth"
}

kms "aead" {
  purpose = "recovery"
  aead_type = "aes-gcm"
  key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
  key_id = "global_recovery"
}