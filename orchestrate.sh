#!/bin/bash

python bootstrap.py

echo
echo

docker stack deploy --compose-file stack.yml --orchestrator swarm rinnegan

sleep 2

watch docker stack ps rinnegan
