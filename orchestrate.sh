#!/bin/bash

source env/bin/activate

python bootstrap.py

deactivate

echo
echo

docker stack deploy --compose-file stack.yml --orchestrator swarm rinnegan

watch docker stack ps rinnegan
