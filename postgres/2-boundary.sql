CREATE DATABASE "boundary";
REVOKE ALL PRIVILEGES ON DATABASE "boundary" FROM public;
CREATE USER boundary_admin WITH ENCRYPTED PASSWORD 'pass' NOINHERIT NOSUPERUSER NOCREATEROLE NOCREATEDB;
GRANT ALL PRIVILEGES ON DATABASE "boundary" TO boundary_admin;
