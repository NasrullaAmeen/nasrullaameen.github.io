---
title: My HomeLab
description: >
  An overview of my home lab infrastructure, hardware, and the services I'm running.
author: Nasrulla Ameen
date: 2025-12-08 10:00:00 -0600
last_modified_at: 2025-12-10 21:17:39 -0600
tags: [homelab, hardware, infrastructure, overview]
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

- **Motherboard:** Atermiter dual x99
- **CPU:** Xeon 2660v4 x2 (Dual processors)
- **RAM:** 128 GB
- **Storage:**
  - NVMe: 500GB and 1TB
  - SSD: 1TB x2
- **Power Supply:** 850 watts
- **Graphics Cards:**
  - GIGABYTE RX 5700 XT GAMING OC
  - NVIDIA GT710

### Networking Equipment

- **Router:** Echolife HG8245W5-6T
- **Switch:** NETGEAR ProSafe | Plus Switch GS408E
- **Access Points:** [Your AP configuration]

### Storage

- **Primary Storage:** NVMe drives (500GB + 1TB)
- **Secondary Storage:** SSD drives (1TB x2)
- **Backup Storage:** CasaOS storage

## Software Stack

### Virtualization

- **Hypervisor:** Proxmox VE
- **Virtual Machines:** 
  - macOS 15
  - Windows 11
  - Arch Linux with OmniArch
- **Containers & LXC:** 
  - Kubernetes
  - Portainer

### Operating Systems

- **Main OS:** Proxmox
- **Virtual Machines:** macOS 15, Windows 11, Arch Linux
- **Specialized:** PfSense, PiHole

### Firewall & Network Security

- **SDN:** Software Defined Networking
- **PfSense:** Firewall and router
- **PiHole:** DNS-based ad blocking

## Services Running

### Infrastructure Services

- **DNS:** PiHole
- **Firewall:** PfSense
- **SDN:** Software Defined Networking
- **Backup:** CasaOS storage
- **Storage Management:** CasaOS VM

### Development Tools

- **Container Orchestration:** Kubernetes
- **Container Management:** Portainer
- **CI/CD:** GitLab CI/CD
- **Infrastructure as Code:** Terraform
- **Configuration Management:** Ansible
- **Network Automation:** Packet

### Automation Workflow

- **Terraform:** Infrastructure provisioning
- **Ansible:** Configuration management
- **GitLab CI/CD:** Continuous integration and deployment
- **Packet:** Network automation

## Network Architecture

```
[Internet]
    |
[Router/Firewall - PfSense]
    |
[SDN Network]
    |
[Core Switch]
    |
    +-- [Proxmox Host]
    |   +-- [macOS 15 VM]
    |   +-- [Windows 11 VM]
    |   +-- [Arch Linux VM]
    |   +-- [CasaOS VM]
    |   +-- [Kubernetes Cluster]
    |   +-- [Portainer]
    +-- [Access Points]
    +-- [Other Devices]
```

### VLANs

- **VLAN 10:** Management
- **VLAN 20:** Servers
- **VLAN 30:** Workstations
- **VLAN 40:** IoT Devices
- **VLAN 50:** Guest Network

## Security Practices

- Firewall rules and network segmentation (PfSense)
- DNS-based ad blocking (PiHole)
- Software Defined Networking (SDN)
- Regular security updates
- SSL/TLS certificates for all services
- VPN access for remote management
- Regular backups to CasaOS storage
- Disaster recovery testing

## Backup Strategy

- **Backup Target:** CasaOS storage
- **Storage Management:** CasaOS VM
- **Automated Backups:** Regular backup schedule
- **Disaster Recovery:** Tested recovery procedures

## Future Plans

- [ ] Expand storage capacity
- [ ] Enhance Kubernetes cluster
- [ ] Implement more automation
- [ ] Enhance monitoring and alerting
- [ ] Add more self-hosted services
- [ ] Optimize network performance

## Documentation

All configurations, setup guides, and troubleshooting notes are documented in this site. Check the [tags](/tags/) to find specific topics.

---

*This is a living document and will be updated as my lab evolves.*
