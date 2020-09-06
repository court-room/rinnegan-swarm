#!/bin/bash

docker stack rm rinnegan
docker system prune --all --force --volumes
docker network prune --force
docker secret rm database-password database-user
docker secret rm backend-secret-key
docker secret rm backend-redis-string
docker secret rm backend-database-string
docker secret rm backend-test-database-string
docker secret rm backend-twitter-consumer-key
docker secret rm backend-twitter-consumer-secret
docker secret rm backend-cloud-vendor
docker secret rm backend-aws-access-key-id
docker secret rm backend-aws-secret-access-key
docker secret rm backend-s3-bucket
docker secret rm backend-monkeylearn-api-token
docker secret rm backend-monkeylearn-model-id