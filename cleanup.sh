#!/bin/bash

docker stack rm rinnegan
docker system prune --all --force --volumes
docker network prune --force
docker secret rm database-password database-user
docker secret rm backend-secret-key backend-database-string backend-test-database-string
docker secret rm streaming-database-password streaming-database-user
