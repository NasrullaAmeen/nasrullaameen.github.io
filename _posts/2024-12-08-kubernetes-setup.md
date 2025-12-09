---
title: Setting Up Kubernetes in Home Lab
description: >
  A guide to setting up a Kubernetes cluster in your home lab environment using k3s or kubeadm.
author: Nasrulla Ameen
date: 2024-12-08 14:00:00 -0600
categories: [Kubernetes, Tutorial, Homelab]
tags: [kubernetes, k3s, kubeadm, containers, orchestration, homelab]
---

# Setting Up Kubernetes in Home Lab

This guide walks through setting up a Kubernetes cluster in a home lab environment. We'll cover both k3s (lightweight) and kubeadm (full Kubernetes) options.

## Choosing Your Kubernetes Distribution

### k3s (Recommended for Home Labs)
- **Pros**: Lightweight, easy to install, minimal resource requirements
- **Cons**: Some features may differ from standard Kubernetes
- **Best for**: Small to medium home labs, learning

### kubeadm (Full Kubernetes)
- **Pros**: Standard Kubernetes, all features available
- **Cons**: More resource-intensive, complex setup
- **Best for**: Production-like environments, advanced learning

## Option 1: k3s Installation

### Prerequisites
- Ubuntu 20.04+ or similar Linux distribution
- At least 1GB RAM per node
- Root or sudo access

### Master Node Setup

```bash
# Install k3s
curl -sfL https://get.k3s.io | sh -

# Check status
sudo systemctl status k3s

# Get kubeconfig
sudo cat /etc/rancher/k3s/k3s.yaml
```

### Worker Node Setup

```bash
# On master, get the token
sudo cat /var/lib/rancher/k3s/server/node-token

# On worker, install with token
curl -sfL https://get.k3s.io | K3S_URL=https://master-ip:6443 K3S_TOKEN=your-token sh -
```

### Verify Installation

```bash
# Check nodes
kubectl get nodes

# Check pods
kubectl get pods --all-namespaces
```

## Option 2: kubeadm Installation

### Prerequisites
- Ubuntu 20.04+ or similar
- At least 2GB RAM per node
- Swap disabled
- Container runtime (containerd or Docker)

### Master Node Setup

```bash
# Install container runtime
sudo apt-get update
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# Install kubeadm, kubelet, kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install network plugin (Flannel)
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

### Worker Node Setup

```bash
# Install container runtime and kubeadm (same as master)

# Join the cluster (use the join command from master init output)
sudo kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

## Deploying Your First Application

### Create a Deployment

```yaml
# nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

```bash
# Apply the deployment
kubectl apply -f nginx-deployment.yaml

# Check deployment
kubectl get deployments
kubectl get pods
```

### Expose Service

```yaml
# nginx-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: NodePort
```

```bash
kubectl apply -f nginx-service.yaml
kubectl get services
```

## Useful Commands

```bash
# Get cluster information
kubectl cluster-info

# View all resources
kubectl get all --all-namespaces

# Describe a resource
kubectl describe pod <pod-name>

# View logs
kubectl logs <pod-name>

# Execute command in pod
kubectl exec -it <pod-name> -- /bin/bash

# Scale deployment
kubectl scale deployment nginx-deployment --replicas=5
```

## Monitoring

### Install Metrics Server

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### View Resource Usage

```bash
kubectl top nodes
kubectl top pods
```

## Troubleshooting

### Common Issues

**Pods not starting:**
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

**Node not ready:**
```bash
kubectl get nodes
kubectl describe node <node-name>
```

**Network issues:**
```bash
# Check CNI plugin
kubectl get pods -n kube-system
```

## Next Steps

- Set up persistent storage (NFS, local storage)
- Configure ingress controller (Nginx, Traefik)
- Implement monitoring (Prometheus, Grafana)
- Set up CI/CD pipelines
- Explore Helm charts

## Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [k3s Documentation](https://k3s.io/)
- [kubeadm Documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)

Happy orchestrating!

