#!/bin/bash
export INSTALL_K3S_VERSION=${local_k3s_version}
K3S_CONFIG_PATH=/etc/rancher/k3s/k3s.yaml
KUBE_CONFIG=$HOME/.kube/config
RANCHER_HOSTNAME=${domain_name}
curl -sfL https://get.k3s.io/ | sh -s - server --write-kubeconfig-mode 644 
sudo cp $K3S_CONFIG_PATH $KUBE_CONFIG
sudo chmod 644 $KUBE_CONFIG
sudo snap install helm --classic
helm --kubeconfig $K3S_CONFIG_PATH repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm --kubeconfig $K3S_CONFIG_PATH repo add jetstack https://charts.jetstack.io
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml
helm --kubeconfig $K3S_CONFIG_PATH install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0
helm --kubeconfig $K3S_CONFIG_PATH install rancher rancher-stable/rancher \
  --version ${rancher_server_version} \
  --namespace cattle-system \
  --set hostname=$RANCHER_HOSTNAME \
  --set bootstrapPassword=admin \
  --set global.cattle.psp.enabled=false \
  --set container.initialDelaySeconds=15
