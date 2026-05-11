# 30-Day DevOps Cloud Testing Journey 🚀

This repository tracks my transition from a Manual QA Engineer to a DevOps-aligned Cloud Tester.  
Built from scratch — every script, pipeline, and deployment is hands-on and production-inspired.

---

## 🛠 Tech Stack

| Category | Tools |
|---|---|
| **OS** | macOS (Unix-based), Ubuntu 24.04 (AWS EC2) |
| **Shell** | Bash / Zsh |
| **Version Control** | Git, GitHub, Pull Request Workflow |
| **Containerization** | Docker (Alpine Linux) |
| **CI/CD** | GitHub Actions |
| **Cloud** | AWS EC2 (Mumbai Region) |
| **Monitoring** | curl, nc (Netcat), cron |
| **Editor** | VS Code |

---

## 📈 Learning Progress

- [x] **Day 1:** DevOps Foundations & CLI Basics — navigation, file creation, text manipulation
- [x] **Day 2:** HTTP Protocols & `curl` for API Testing — status codes (200, 404, 405)
- [x] **Day 3:** Networking, DNS & Port Scanning — `nc` (Netcat), port 443 verification
- [x] **Day 4:** Version Control with Git (Local) — init, add, commit, restore, log
- [x] **Day 5:** Remote GitHub Setup — PAT, remote add, push, pull
- [x] **Day 6:** Branching & PR Workflow — feature branches, pull requests, merge to main
- [x] **Day 7:** Repository Hygiene — README, .gitignore, blocking .log & .DS_Store
- [x] **Day 8:** Linux Permissions & Ownership — chmod (755, 400), sudo, ls -l
- [x] **Day 9:** Process Management — top, htop, ps aux, kill, background jobs
- [x] **Day 10:** Log Analysis — tail -f, grep -i, less, real-time error hunting
- [x] **Day 11:** Task Automation — cron scheduling, absolute paths, output redirection
- [x] **Day 12:** Advanced Bash Scripting — variables, arrays, loops, conditionals, functions
- [x] **Day 13:** Docker & Containerization — Dockerfile, Alpine image, build & run containers
- [x] **Day 14:** CI/CD with GitHub Actions — auto build & test on every push/PR
- [x] **Day 15:** AWS Cloud Deployment — EC2 launch, SSH, clone repo, run Docker in cloud

---

## 📂 Project Highlights

### 🛒 Ubuy E-Commerce Monitor (`ubuy_monitor.sh`)
An advanced Bash automation script that monitors live e-commerce endpoints on Ubuy.  
Uses functions, arrays, for loops, and conditional HTTP status handling.  
Logs results with timestamps, raises alerts on failures, and is scheduled via cron to run every 30 minutes.

**HTTP codes handled:** 200 OK, 301 Redirect, 403 Blocked, 404 Not Found, 429 Rate Limited

```bash
./ubuy_monitor.sh
# [2026-05-11 02:01:45] OK [200] — https://www.ubuy.co.in/category/laptops-21457
# [2026-05-11 02:01:45] OK [200] — https://www.ubuy.co.in/brand/3m
# [2026-05-11 02:01:45] OK [200] — https://www.ubuy.co.in/category/keyboards-14289
```

---

### 🐳 Dockerfile
Containerizes the Ubuy monitor using Alpine Linux (5MB base image).  
Installs curl and bash, copies the script, and runs it on container start.  
Ensures identical execution across Mac, Ubuntu, and CI servers.

```bash
docker build -t ubuy-monitor:v1 .
docker run ubuy-monitor:v1
```

---

### ⚙️ GitHub Actions CI/CD (`.github/workflows/ubuy-monitor.yml`)
Automated pipeline that triggers on every `git push` and Pull Request.  
Builds the Docker image and runs the Ubuy monitor in GitHub's cloud — no manual steps required.

**Pipeline steps:**
1. Checkout code
2. Build Docker image
3. Run Ubuy Monitor container
4. Upload logs as artifacts

---

### 🔍 Smoke Test Script (`smoke_test.sh`)
Pings multiple domains to verify basic connectivity — simulates a cloud health check.

### 🌐 Web Monitor (`web_test.sh`)
Uses `curl` to validate HTTP status codes (200, 404, 405) for backend service reliability.

### 🏥 Site Health Checker (`check_site.sh`)
Automated curl-based script that verifies if websites are reachable (200 OK).

### 🔌 Network Port Scanner (`port_check.sh`)
Uses `nc` (Netcat) to verify if service ports (like 443 for HTTPS) are open on target servers.

### 🔗 API Health Check (`api_check.sh`)
Hits the GitHub API endpoint, validates 200 OK status, and uses environment variables for target URLs.

---

## ☁️ Cloud Deployment

Scripts and Docker containers have been deployed to and verified on **AWS EC2 (Mumbai Region)**:

```bash
# SSH into EC2
ssh -i ~/.ssh/devops-key.pem ubuntu@<EC2-PUBLIC-IP>

# Clone repo on cloud server
git clone https://github.com/Dipendu27/devops-cloud-testin.git

# Run Docker container in cloud
docker build -t ubuy-monitor:v1 .
docker run ubuy-monitor:v1
# Result: All 200 OK from AWS Mumbai
```

---

## 🎯 Target Roles

QA Engineer · Cloud Automation Tester · Game Functionality Tester  
Targeting: **InnoWave · iNetFrame · Wipro · Rockstar Games**

---

*Built with 💻 + ☁️ by Dipendu Mukherjee — one day at a time.*