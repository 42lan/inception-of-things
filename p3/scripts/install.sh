#!/bin/bash -e

# Update package information and install cURL
apt update -y
apt install -y curl

# Install latest release of Docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh

# Install latest release of Kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
KUBERNETES_RELEASE=$(curl -sL https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBERNETES_RELEASE}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/${KUBERNETES_RELEASE}/bin/linux/amd64/kubectl.sha256"
# If the check fails do not continue and exit
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check || exit 1
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install latest version of K3d
# https://k3d.io/v5.4.1/#installation
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
