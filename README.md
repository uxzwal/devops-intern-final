# DevOps Intern Final Assessment

**Name:** Your Name

**Submission Date:** 2026-10-29

---

## Overview

This repository implements an end-to-end DevOps pipeline for a containerised NGINX web application. The pipeline covers:

1. **Source Control** – GitHub repository with conventional commits, feature branches, PR workflow, and a `v1.0.0` tag.
2. **Linux Scripting** – Helper scripts for system information and health checking.
3. **Containerisation** – Docker image built from a pinned NGINX base, non‑root runtime, health endpoint, and build‑time SHA injection.
4. **Continuous Integration** – GitHub Actions workflow that lints, builds, tests, and publishes the image to GHCR.
5. **Orchestration** – Nomad job specification deploying the image with dynamic ports and Consul health checks.
6. **Observability** – Loki stack (Loki, Promtail, Grafana) aggregating logs with labelled queries.

The sections below document each task, the commands used, and the observed outputs. Follow the **Quick Start** to reproduce the entire flow on a clean machine.

---

## Repository Structure

```
devops-intern-final/
├── README.md
├── .gitignore
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
├── scripts/
│   ├── sysinfo.sh
│   └── healthcheck.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── nomad/
│   └── nginx-app.nomad.hcl
├── monitoring/
│   ├── loki-config.yaml
│   ├── promtail-config.yaml
│   ├── docker-compose.yaml
│   └── loki_setup.md
└── docs/
    └── screenshots/
```

---

## CI Status Badge

[![CI](https://github.com/yourusername/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/yourusername/devops-intern-final/actions/workflows/ci.yml)

---

## Quick Start (Clone → Run)

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/devops-intern-final.git
cd devops-intern-final

# 2. Build the Docker image (CI does this automatically, but you can run locally)
docker build -t devops-nginx:$(git rev-parse --short HEAD) -f app/Dockerfile app

# 3. Run the container locally
docker run -d -p 8080:8080 --name devops-nginx devops-nginx:$(git rev-parse --short HEAD)

# 4. Verify health endpoint
./scripts/healthcheck.sh http://localhost:8080

# 5. (Optional) Start Loki stack for log aggregation
docker-compose -f monitoring/docker-compose.yaml up -d
```

---

*Further sections will be added as tasks are completed.*