# hashicorp-boundary

Learning about Harhicorp Boundary.

Requirements:
* Docker  
* Docker-compose


## Local development

1) Start boundary 

```sh
make local-docker
```

2) Stop boundary

```sh
make local-docker-stop
```

3) Run terraform to create boundary resources

```sh 
cd terraform
terraform apply
```

4) Clean boundary

```sh
make local-docker-down
```

#### Login to boundary

1) Check admin password

```sh
./boundary_printh.sh
```

2) Login via UI

a) Go to URL: http://localhost:9200

b) Use `admin` creds from point 1

3) Login via CLI (using pass from point 1)

```sh
boundary authenticate password -auth-method-id=${auth_method_id} -login-name=admin -password=${password}
```

#### Postgresql

1) Login to Postgresql DB

```sh
docker exec -it ${docker_postgresql_id} /bin/bash -c  "psql -U admin -d postgres"
```

2) Checking config

```sh
docker exec -it ${docker_postgresql_id} /bin/bash -c "cat /var/lib/postgresql/data/pg_hba.conf"
```

## Boundary - installing locally using brew

0) Install

```sh
brew install hashicorp-boundary-desktop
```

1) Start boundary

```sh
boundary dev
```

2) Login as dev admin

```sh
boundary authenticate password -auth-method-id=ampw_1234567890 -login-name=admin -password=password
```

## Docs
* [Boundary - basic admin](https://learn.hashicorp.com/tutorials/boundary/manage-intro?in=boundary/basic-administration)
* [Boundary - sample deployments](https://github.com/hashicorp/boundary-reference-architecture)
* [Sample plugin for AWS EC2](https://github.com/hashicorp/boundary-plugin-host-aws)
* [Boundary provider for Terraform](https://registry.terraform.io/providers/hashicorp/boundary/1.0.5/docs)
