#!/bin/bash

ENV=$1
python bootstrap.py

echo
echo

if [ $ENV == "dev" ]; then
    echo "Running in dev env"
    docker stack deploy --compose-file stack-dev.yml --orchestrator swarm rinnegan
else
    echo "Running in prod env"
    docker stack deploy --compose-file stack-prod.yml --orchestrator swarm rinnegan
fi