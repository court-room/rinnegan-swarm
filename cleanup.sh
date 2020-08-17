#!/bin/bash

docker network prune --force
docker secret rm database-user database-password
docker system prune --all --force --volumes
