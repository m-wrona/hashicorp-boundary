#!/bin/bash

source ./common.sh

dockerBoundaryID=`getBoundaryDockerID "boundary_1"`
docker logs -f $dockerBoundaryID