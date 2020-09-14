#!/bin/bash

ENV=$1

clear

python bootstrap.py

echo
echo

if [ $ENV == "dev" ]; then
    echo "Running in dev env"
    docker stack deploy --compose-file stack-dev.yml --orchestrator swarm --prune rinnegan
else
    echo "Running in prod env"
    docker stack deploy --compose-file stack-prod.yml --orchestrator swarm --prune rinnegan
fi

watch docker stack ps rinnegan