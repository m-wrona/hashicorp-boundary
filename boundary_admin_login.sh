#!/bin/bash

source ./common.sh

boundary authenticate password \
  -auth-method-id=$authMethodID \
  -login-name=admin \
  -password=$adminPass
