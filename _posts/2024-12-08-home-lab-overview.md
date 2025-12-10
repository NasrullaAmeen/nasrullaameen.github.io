---
title: My HomeLab
description: >
  An overview of my home lab infrastructure, hardware, and the services I'm running.
author: Nasrulla Ameen
date: 2025-12-08 10:00:00 -0600
categories: [Homelab, Infrastructure]
tags: [homelab, hardware, infrastructure, overview]
pin: false
---

# My HomeLab

Welcome to my home lab! This post provides an overview of my infrastructure, hardware, and the services I'm running.

## Lab Philosophy

My home lab serves multiple purposes:
- **Learning**: Hands-on experience with enterprise technologies
- **Testing**: Safe environment to test configurations before production
- **Services**: Self-hosted applications for personal use
- **Backup**: Redundant storage and backup solutions

## Hardware Overview

### Main Server
- **CPU**: [Your CPU model]
- **RAM**: [Your RAM amount]
- **Storage**: [Your storage configuration]
- **Network**: [Your network setup]

### Networking Equipment
- **Router**: [Your router model]
- **Switch**: [Your switch model]
- **Access Points**: [Your AP configuration]

### Storage
- **Primary Storage**: [Your primary storage]
- **Backup Storage**: [Your backup solution]

## Software Stack

### Virtualization
- **Hypervisor**: Proxmox VE / VMware ESXi
- **Virtual Machines**: Multiple VMs for different services
- **Containers**: Docker and container orchestration

### Operating Systems
- **Linux**: Ubuntu Server, Debian, CentOS
- **Windows**: Windows Server for specific services
- **Specialized**: pfSense, TrueNAS, etc.

## Services Running

### Infrastructure Services
- **DNS**: Pi-hole / AdGuard Home
- **Reverse Proxy**: Nginx / Traefik
- **Monitoring**: Prometheus + Grafana
- **Backup**: Automated backup solutions

### Self-Hosted Applications
- **Media**: Plex / Jellyfin
- **File Sharing**: Nextcloud
- **Password Manager**: Vaultwarden
- **Note Taking**: [Your note-taking solution]

### Development Tools
- **Git**: Self-hosted Git server
- **CI/CD**: Jenkins / GitLab CI
- **Container Registry**: Private Docker registry

## Network Architecture

```
[Internet]
    |
[Router/Firewall]
    |
[Core Switch]
    |
    +-- [Server 1]
    +-- [Server 2]
    +-- [Access Points]
    +-- [Other Devices]
```

### VLANs
- **VLAN 10**: Management
- **VLAN 20**: Servers
- **VLAN 30**: Workstations
- **VLAN 40**: IoT Devices
- **VLAN 50**: Guest Network

## Security Practices

- Firewall rules and network segmentation
- Regular security updates
- SSL/TLS certificates for all services
- VPN access for remote management
- Regular backups and disaster recovery testing

## Future Plans

- [ ] Expand storage capacity
- [ ] Add Kubernetes cluster
- [ ] Implement more automation
- [ ] Enhance monitoring and alerting
- [ ] Add more self-hosted services

## Documentation

All configurations, setup guides, and troubleshooting notes are documented in this site. Check the categories and tags to find specific topics.

---

*This is a living document and will be updated as my lab evolves.*

