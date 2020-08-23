# rinnegan-platform-setup

[![lint Actions Status](https://github.com/court-room/rinnegan-platform-setup/workflows/lint/badge.svg)](https://github.com/court-room/rinnegan-platform-setup/actions)
[![DeepSource](https://static.deepsource.io/deepsource-badge-light-mini.svg)](https://deepsource.io/gh/court-room/rinnegan-platform-setup/?ref=repository-badge)

## Architecture

### Service level Architecture

![service architecture](https://rinnegan-assets.s3.ap-south-1.amazonaws.com/architecture-asstes/Service-Level-Architecture.png)

### Network level Architecture

![network architeture](https://rinnegan-assets.s3.ap-south-1.amazonaws.com/architecture-asstes/Network-Level-Architecture.png)

Currently we have a 4 node cluster in the following pattern

- 1 manager
- 3 worker

This setup has a fault tolerance of 0 as only 1 manager is present, scale the system accordingly.
Preferably keep 3 managers at very least.

## Pre-Requisite

Procure 4 hosts running **Ubuntu-18.04 LTS** and run the following on each of them

- Make sure host is using latest system packages

  ```bash
  $ sudo apt update
  $ sudo apt list --upgradable
  $ sudo apt upgrade
  $ sudo apt autoremove
  ```

- Once updated Login to the host and create a new user

  ```bash
  $ sudo adduser <USER>
  ```

- Once done switch to a new user and add the public key with proper permissions

  ```bash
  $ sudo su - <USER>
  $ mkdir .ssh
  $ chmod 700 .ssh
  $ touch .ssh/authorized_keys
  $ chmod 600 .ssh/authorized_keys
  $ echo <PUBLIC_KEY> >> .ssh/authorized_keys
  $ exit
  $ sudo usermod -aG sudo <USER>
  ```

- Login as the created user and install docker via [get.docker.com](https://get.docker.com/)

  ```bash
  $ curl -fsSL https://get.docker.com -o get-docker.sh
  $ sh get-docker.sh
  $ rm get-docker.sh
  ```

- Add you user to the docker group so that you don't have to prefix docker commands with `sudo`

  ```bash
  $ sudo usermod -aG docker <USER>
  ```

- Login to the manager node and create a virtual environment using python3

  ```bash
  $ python3 -m venv ~/env
  ```

- Activate the environemnt and install the dependencies

  ```bash
  $ source ~/env/bin/activate
  (env) $ pip install --upgrade pip setuptools
  (env) $ pip install --requirement requirements.txt
  ```

## Setup

Once the setup for all nodes is done, login to the node you want to keep as manager

- Initialize the swarm on the manager node

  ```bash
  $ docker swarm init
  ```

- Copy the output of the previous command and run it on all worker nodes,
  to verify that the nodes have joined the swarm cluster type the following,
  you will see 4 entries

  ```bash
  $ docker node ls
  ```

- Makse sure you have created a `.secrets.database` file by using `.secrets.database.example`
  as a template

- Activate the virtual environment and run the following script

  ```bash
  $ source ~/env/bin/activate
  (env) $ ./orchestrate.sh
  ```

- Once the services are running you can verify the setup by going to following address `http://<MANAGER_IP>:8080`

## Contact

For any issue please contact the following persons

- [onlinejudge95](https://github.com/onlinejudge95)
