---
title: Home Lab Network Setup and VLAN Configuration
description: >
  A comprehensive guide to setting up network segmentation, VLANs, and routing in a home lab environment.
author: Nasrulla Ameen
date: 2024-12-08 16:00:00 -0600
categories: [Networking, Tutorial, Homelab]
tags: [networking, vlan, routing, firewall, homelab, network-segmentation]
---

# Home Lab Network Setup and VLAN Configuration

This guide covers setting up a segmented network with VLANs, proper routing, and firewall rules for a secure home lab environment.

## Network Design

### VLAN Structure

```
VLAN 10 - Management (10.0.10.0/24)
VLAN 20 - Servers (10.0.20.0/24)
VLAN 30 - Workstations (10.0.30.0/24)
VLAN 40 - IoT Devices (10.0.40.0/24)
VLAN 50 - Guest Network (10.0.50.0/24)
```

### IP Addressing Scheme

| VLAN | Purpose | Subnet | Gateway | DHCP Range |
|------|---------|--------|---------|------------|
| 10 | Management | 10.0.10.0/24 | 10.0.10.1 | 10.0.10.100-200 |
| 20 | Servers | 10.0.20.0/24 | 10.0.20.1 | 10.0.20.100-200 |
| 30 | Workstations | 10.0.30.0/24 | 10.0.30.1 | 10.0.30.100-200 |
| 40 | IoT | 10.0.40.0/24 | 10.0.40.1 | 10.0.40.100-200 |
| 50 | Guest | 10.0.50.0/24 | 10.0.50.1 | 10.0.50.100-200 |

## Hardware Requirements

- Managed switch (supports VLANs)
- Router/firewall (pfSense, OPNsense, or enterprise router)
- Access points (VLAN-aware)

## pfSense Configuration

### Interface Setup

```bash
# Assign VLANs to interfaces
Interfaces > Assignments > VLANs

# Create VLAN interfaces
VLAN 10 - Management
VLAN 20 - Servers
VLAN 30 - Workstations
VLAN 40 - IoT
VLAN 50 - Guest
```

### DHCP Configuration

For each VLAN, configure DHCP:

```
Interfaces > [VLAN] > DHCP Server

Enable DHCP server
Range: 10.0.X.100 - 10.0.X.200
Gateway: 10.0.X.1
DNS: 10.0.10.10 (Pi-hole)
```

### Firewall Rules

#### Management VLAN (10)
- Allow: All management protocols
- Allow: Access to all other VLANs
- Deny: Inbound from other VLANs

#### Server VLAN (20)
- Allow: Management access from VLAN 10
- Allow: Outbound internet
- Allow: Specific services to other VLANs
- Deny: Direct access from Guest/IoT

#### Workstation VLAN (30)
- Allow: Internet access
- Allow: Access to servers (specific ports)
- Allow: Management access from VLAN 10
- Deny: Inter-VLAN communication (except servers)

#### IoT VLAN (40)
- Allow: Internet access only
- Deny: All inter-VLAN communication
- Deny: Access to management and servers

#### Guest VLAN (50)
- Allow: Internet access only
- Deny: All inter-VLAN communication
- Rate limiting enabled

## Switch Configuration

### Example: Cisco Switch

```cisco
! Create VLANs
vlan 10
 name Management
vlan 20
 name Servers
vlan 30
 name Workstations
vlan 40
 name IoT
vlan 50
 name Guest

! Configure trunk port (to router)
interface GigabitEthernet0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30,40,50

! Configure access ports
interface GigabitEthernet0/2
 switchport mode access
 switchport access vlan 20
```

### Example: Ubiquiti UniFi

Configure through UniFi Controller:
1. Networks > Create New Network
2. Set VLAN ID
3. Configure subnet and DHCP
4. Apply to switch ports

## Router Configuration

### Static Routes

If using multiple routers or complex routing:

```bash
# Add static routes
ip route add 10.0.20.0/24 via 10.0.10.2
ip route add 10.0.30.0/24 via 10.0.10.2
```

## Testing Connectivity

### From Management VLAN

```bash
# Test server access
ping 10.0.20.10
ssh admin@10.0.20.10

# Test workstation access
ping 10.0.30.50
```

### From Workstation VLAN

```bash
# Test server access (should work)
curl http://10.0.20.10:8080

# Test IoT access (should fail)
ping 10.0.40.10
```

### From Guest/IoT VLAN

```bash
# Test internet (should work)
ping 8.8.8.8

# Test server access (should fail)
ping 10.0.20.10
```

## Security Best Practices

### Firewall Rules
- Default deny, explicit allow
- Log all denied traffic
- Regular rule review

### Network Monitoring
- Monitor inter-VLAN traffic
- Alert on unusual patterns
- Regular security audits

### Access Control
- Use strong passwords
- Implement 802.1X if possible
- Regular firmware updates

## Troubleshooting

### VLAN Not Working

```bash
# Check VLAN assignment
show vlan brief

# Check trunk configuration
show interfaces trunk

# Verify switch port configuration
show interfaces status
```

### Routing Issues

```bash
# Check routing table
ip route show
route -n

# Test connectivity
traceroute 10.0.20.10
```

### DHCP Issues

```bash
# Check DHCP leases
cat /var/lib/dhcp/dhcpd.leases

# Test DHCP
dhclient -v
```

## Advanced Configuration

### Inter-VLAN Routing

Allow specific services between VLANs:

```bash
# Firewall rule example
Allow: VLAN 30 → VLAN 20 (Port 443, 80)
Allow: VLAN 30 → VLAN 20 (Port 3306) # MySQL
Deny: All other traffic
```

### VPN Access

Configure VPN to access management VLAN:

```bash
# OpenVPN configuration
Client can access: 10.0.10.0/24
Route to: 10.0.20.0/24 (optional)
```

## Documentation

Maintain network documentation:
- Network diagram
- IP address assignments
- Firewall rule documentation
- Change log

## Resources

- [pfSense Documentation](https://docs.netgate.com/pfsense/)
- [VLAN Best Practices](https://www.cisco.com/c/en/us/support/docs/lan-switching/8021q/17056-741-4.html)
- [Network Segmentation Guide](https://www.nist.gov/publications/guide-industrial-control-systems-ics-security)

---

*Keep your network documentation updated as you make changes!*

