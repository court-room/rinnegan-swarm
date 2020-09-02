import docker


class DockerClient:
    def __init__(self):
        self.client = docker.from_env()

    def manage_networks(self, requested_networks):
        print("Initializing networks...\n")
        current_networks = [
            network.name for network in self.client.networks.list()
        ]

        for requested_network in requested_networks:
            if requested_network not in current_networks:
                self.client.networks.create(
                    name=requested_network,
                    driver="overlay",
                    attachable=True,
                    scope="swarm",
                )
                print(f"* Successfully created {requested_network}")
                continue

            print(f"* {requested_network} already exists")
        print("\nNetwork setup completed\n\n")

    def manage_volumes(self, requested_volumes):
        print("Initializing volumes...\n")
        current_volumes = [
            volume.name for volume in self.client.volumes.list()
        ]

        for requested_volume in requested_volumes:
            if requested_volume not in current_volumes:
                self.client.volumes.create(name=requested_volume)
                print(f"* Successfully created {requested_volume}")
                continue

            print(f"* {requested_volume} already exists")
        print("\nVolume setup completed\n\n")

    def manage_secrets(self, requested_secrets):
        print("Initializing secrets...\n")
        current_secrets = [
            secret.name for secret in self.client.secrets.list()
        ]

        for requested_secret in requested_secrets:
            env_file = f".secrets.{requested_secret}"
            secrets = {}

            with open(env_file, "r") as fp:
                for line in fp.readlines():
                    pairs = line.strip().split("=")
                    secrets[pairs[0]] = pairs[1]

            for key, value in secrets.items():
                if key not in current_secrets:
                    self.client.secrets.create(name=key, data=value)
                    print(f"* Successfully created {key}")
                    continue
                print(f"* {key} already exists")

        print("\nSecrets setup completed")


if __name__ == "__main__":
    obj = DockerClient()
    obj.manage_networks(
        [
            "rinnegan-database-network",
            "rinnegan-backend-network",
            "rinnegan-queue-network",
        ]
    )
    obj.manage_volumes(["rinnegan-database-volume", "rinnegan-queue-volume"])
    obj.manage_secrets(["database", "backend"])
