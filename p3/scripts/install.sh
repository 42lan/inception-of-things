#!/bin/bash

# Install cURL
apt install -y curl

# Install Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

# Install the latest release of K8s
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-on-linux
KUBERNETES_RELEASE=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -sLO "https://dl.k8s.io/release/${KUBERNETES_RELEASE}/bin/linux/amd64/kubectl"
# Validate the binary
curl -sLO "https://dl.k8s.io/${KUBERNETES_RELEASE}/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check
if [ $? -eq 0 ]
then
    rm kubectl.sha256
else
    echo "Exit..."
    exit 1
fi
# Install kubectl by setting user and group ownership to root and permission mode -rwxr-xr-x
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install the latest release of K3d
# https://k3d.io/v5.4.1/#installation
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
