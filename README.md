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
| **Cloud** | AWS EC2 & S3 (Mumbai Region), IAM Secure Roles |
| **Monitoring & Validation** | curl, nc (Netcat), cron, jq |
| **API Testing** | Postman Collections, Newman, Newman HTML Extra Reporter |
| **AI Benchmarking** | Python, Ollama |
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
- [x] **Day 13:** CI/CD Fundamentals — GitHub Actions introduction
- [x] **Day 14:** CI/CD Automation — auto build & test on every push/PR
- [x] **Day 15:** AWS Cloud Deployment — EC2 launch, SSH, clone repo
- [x] **Day 16:** API Test Reporting — Newman setup with HTML Extra Reporter dependency
- [x] **Day 17:** JSON Inventory Validation — Introduction to `jq` for extracting specific API data points
- [x] **Day 18:** Local AI Benchmarking — Python script for Ollama response speed testing
- [x] **Day 19:** Dynamic Data Parsing — Bash `for` loops combined with `jq` to iterate through JSON arrays dynamically
- [x] **Day 20:** Containerization (Docker) — Eliminating "It works on my machine" by writing a Dockerfile (Alpine), building images, and running isolated environments
- [x] **Day 21:** CI/CD Master Pipeline — Merging Docker execution, Newman API testing, and automated artifact uploads into a unified GitHub Actions workflow
- [x] **Day 22:** Production Cloud Infrastructure — Provisioning an AWS EC2 Ubuntu instance in the Mumbai region and configuring SSH key access
- [x] **Day 23:** Cloud-Native Environments — Installing Docker on EC2, managing Linux user group security privileges, and executing isolated containers in production
- [x] **Day 24:** Cloud Observability & Security — Building passwordless infrastructure using AWS IAM roles and routing system outputs securely to Amazon S3
- [x] **Day 25:** Enterprise Pipeline Orchestration — Writing an automated wrapper script to capture real-time test executions, format timestamped metrics, and handle zero-touch object archiving to S3

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

### 🐳 Docker Containers (`Dockerfile`)
Containerizes automation scripts (like the Ubuy monitor and JSON inventory checker) using Alpine Linux (5MB base image).

Installs required dependencies (`curl`, `bash`, `jq`), copies the local scripts, and runs them isolated on container start.

Ensures perfectly identical execution across my MacBook, Ubuntu, and CI servers.

```bash
docker build -t ubuy-monitor-app .
docker run ubuy-monitor-app
```

---

### ⚙️ GitHub Actions CI/CD (`.github/workflows/ubuy-monitor.yml`)
Automated Master Pipeline that triggers on every `git push` and Pull Request.

Builds the Docker multi-tool environment, runs concurrent health monitors, runs Node.js/Newman API collections, and exports downloadable HTML test reports directly to GitHub.

---

### ☁️ AWS Cloud Orchestration (`cloud_test_runner.sh`)
A production-grade shell wrapper deployed on AWS EC2 that handles hands-off continuous testing and observability. It isolates execution within a Docker runtime, captures log data, and utilizes IAM security credentials to auto-archive timestamped files directly into Amazon S3.

```bash
./cloud_test_runner.sh
# ==========================================
# 🚀 [AWS Cloud Orchestration] Starting Automated Run
# 📦 Running test suite inside Docker container...
# ☁️ Archiving artifacts to Amazon S3...
# ✅ SUCCESS: Log archived safely to s3://dipendu-qa-test-artifacts/logs/
# ==========================================
```

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

### 📦 Dynamic JSON Validation (`inventory_check.sh`, `ubuy_inventory.json`)
Validates product availability across a dynamic inventory JSON file using `jq` and Bash loops.

The script asks `jq` for the array length, loops through each item dynamically (preventing hardcoded index errors), and prints either an OK message for available stock or a critical alert when a product is out of stock.

```bash
./inventory_check.sh
# Starting Full Inventory Scan...
# OK: MacBook Pro M5 is in stock (Qty: 15).
# ❌ ALERT: Air Jordan 1 Low is out of stock!
# OK: iPhone 15 is in stock (Qty: 37).
# Scan Complete.
```

### 🧪 Newman HTML Reporting (`package.json`, `package-lock.json`)
Adds `newman-reporter-htmlextra` so API test runs can generate richer HTML reports from Newman collections.

```bash
npm install
newman run ubuy_api_tests.json -r cli,htmlextra
```

### ⚡ Ollama Model Benchmark (`benchmark.py`)
Benchmarks a local Ollama model by calling the generate API, measuring total response time, token count, and tokens per second.

```bash
ollama pull llama3.2
python3 benchmark.py
```

---

## ☁️ Cloud Deployment

Scripts and Docker containers have been deployed to and verified on **AWS EC2 (Mumbai Region)**:

```bash
# SSH into EC2
ssh -i ~/.ssh/devops-cloud-key.pem ubuntu@<EC2-PUBLIC-IP>

# Clone repo on cloud server
git clone https://github.com/Dipendu27/devops-cloud-testin.git

# Run Docker container in cloud
docker build -t ubuy-monitor-app .
docker run ubuy-monitor-app
# Result: Execution identical to local environment
```

---

## 🎯 Target Roles

QA Engineer · Cloud Automation Tester · Game Functionality Tester  

---

*Built with 💻 + ☁️ by Dipendu Mukherjee — one day at a time.*
