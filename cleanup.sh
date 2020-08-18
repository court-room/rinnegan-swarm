#!/bin/bash

docker stack rm rinnegan
docker network prune --force
docker secret rm database-password database-user
docker system prune --all --force --volumes
