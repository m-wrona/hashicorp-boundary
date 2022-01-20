#!/bin/bash

function getBoundaryDockerID() {
    local dockerId=`docker ps -a | grep $1 | sed -n -e "s/\([a-z0-9]*\) hashicorp.*/\1/p"`
    echo $dockerId
}

function grepDockerLogs() {
    local logs=`docker logs $1 | grep "$2" | sed -n -e "s/$2: \(.*\)/\1/p"`
    echo $logs
}

dockerDBInitID=`getBoundaryDockerID "boundary-db-init"`
authMethodID=`grepDockerLogs $dockerDBInitID "Auth Method ID"`
adminPass=`grepDockerLogs $dockerDBInitID Password`
