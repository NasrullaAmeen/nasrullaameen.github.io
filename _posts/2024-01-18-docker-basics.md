---
title: Docker Basics for Home Lab
description: >
  Essential Docker commands and concepts for managing containers in your home lab environment.
author: Nasrulla Ameen
date: 2024-01-18 11:00:00 -0600
categories: [Docker, Tutorial]
tags: [docker, containers, homelab, devops]
---

# Docker Basics for Home Lab

Essential Docker commands and concepts for managing containers in your home lab.

## What is Docker?

Docker is a platform for developing, shipping, and running applications in containers. Containers allow you to package an application with all its dependencies into a standardized unit.

## Basic Commands

### Container Management

```bash
# Run a container
docker run -d --name mycontainer nginx:latest

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop mycontainer

# Start a stopped container
docker start mycontainer

# Remove a container
docker rm mycontainer

# Remove a running container (force)
docker rm -f mycontainer
```

### Image Management

```bash
# List images
docker images

# Pull an image
docker pull nginx:latest

# Remove an image
docker rmi nginx:latest

# Remove unused images
docker image prune
```

### Container Interaction

```bash
# Execute command in running container
docker exec -it mycontainer /bin/bash

# View container logs
docker logs mycontainer

# Follow logs in real-time
docker logs -f mycontainer

# View container stats
docker stats mycontainer
```

## Docker Compose

Docker Compose allows you to define and run multi-container applications.

### Example docker-compose.yml

```yaml
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    restart: unless-stopped

  database:
    image: postgres:15
    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  db_data:
```

### Docker Compose Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild services
docker-compose up -d --build

# Stop and remove volumes
docker-compose down -v
```

## Networking

```bash
# List networks
docker network ls

# Create a network
docker network create mynetwork

# Inspect a network
docker network inspect mynetwork

# Connect container to network
docker network connect mynetwork mycontainer
```

## Volumes

```bash
# List volumes
docker volume ls

# Create a volume
docker volume create myvolume

# Inspect a volume
docker volume inspect myvolume

# Remove unused volumes
docker volume prune
```

## Best Practices

1. **Use specific tags** instead of `latest` in production
2. **Use volumes** for persistent data
3. **Set restart policies** for important containers
4. **Use Docker Compose** for multi-container applications
5. **Clean up** unused resources regularly
6. **Monitor** container resource usage

## Useful Commands

```bash
# Clean up everything (containers, images, volumes, networks)
docker system prune -a --volumes

# View disk usage
docker system df

# Export a container
docker export mycontainer > mycontainer.tar

# Import a container
docker import mycontainer.tar myimage:tag
```

## Troubleshooting

### Container won't start

```bash
# Check logs
docker logs mycontainer

# Inspect container
docker inspect mycontainer

# Check container status
docker ps -a
```

### Permission issues

```bash
# Run container with specific user
docker run -u $(id -u):$(id -g) myimage
```

### Network connectivity

```bash
# Test network from container
docker exec mycontainer ping google.com

# Check network configuration
docker network inspect bridge
```

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/)

Happy containerizing!

