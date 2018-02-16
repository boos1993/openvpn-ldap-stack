#!/bin/bash

source docker.env

docker network create --subnet=$NETWORK_SUBNET $NETWORK_NAME
