#!/bin/bash

docker stack rm rinnegan
docker system prune --all --force --volumes
docker network prune --force
docker secret rm database-password database-user
docker secret rm backend-secret-key backend-redis-string backend-database-string backend-test-database-string
