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
| **Scheduling** | Linux Cron (local & cloud), @reboot jobs |
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
- [x] **Day 16:** API Test Reporting — Newman setup with HTML Extra Reporter
- [x] **Day 17:** JSON Inventory Validation — `jq` for extracting specific API data points
- [x] **Day 18:** Local AI Benchmarking — Python script for Ollama response speed testing
- [x] **Day 19:** Dynamic Data Parsing — Bash `for` loops combined with `jq` for JSON arrays
- [x] **Day 20:** Containerization (Docker) — Dockerfile (Alpine), building images, isolated environments
- [x] **Day 21:** CI/CD Master Pipeline — Docker, Newman, and artifact uploads in unified GitHub Actions workflow
- [x] **Day 22:** Production Cloud Infrastructure — AWS EC2 Ubuntu provisioning, SSH key access
- [x] **Day 23:** Cloud-Native Environments — Docker on EC2, Linux user group security, isolated containers
- [x] **Day 24:** Cloud Observability & Security — AWS IAM roles, passwordless infrastructure, S3 routing
- [x] **Day 25:** Enterprise Pipeline Orchestration — automated wrapper script, timestamped metrics, zero-touch S3 archiving
- [x] **Day 26:** Linux Cron Jobs in the Cloud — scheduling `*/30` and `@reboot` cron jobs on EC2 for 24/7 unattended testing

---

## 📂 Project Highlights

### 🛒 Ubuy E-Commerce Monitor (`ubuy_monitor.sh`)
An advanced Bash automation script that monitors live e-commerce endpoints on Ubuy.  
Uses functions, arrays, for loops, and conditional HTTP status handling.  
Logs results with timestamps, raises alerts on failures, and is scheduled via cron to run every 30 minutes.

**HTTP codes handled:** 200 OK, 301 Redirect, 403 Blocked, 404 Not Found, 429 Rate Limited

```bash
./ubuy_monitor.sh
# [2026-05-18 10:08:28] OK [200] — https://www.ubuy.co.in/category/laptops-21457
# [2026-05-18 10:08:28] OK [200] — https://www.ubuy.co.in/brand/3m
# [2026-05-18 10:08:28] OK [200] — https://www.ubuy.co.in/category/keyboards-14289
```

---

### ☁️ AWS Cloud Orchestration (`cloud_test_runner.sh`)
A production-grade shell wrapper deployed on AWS EC2 for hands-off continuous testing.

Executes the test suite inside a Docker container, captures timestamped logs, and auto-archives to Amazon S3 using IAM roles — zero hardcoded credentials.

Scheduled via cron to run every 30 minutes and on every EC2 reboot.

```bash
./cloud_test_runner.sh
# ==========================================
# 🚀 [AWS Cloud Orchestration] Starting Automated Run
# ⏰ Timestamp: 2026-05-18_10-08-28
# 📦 Running test suite inside Docker container...
# ☁️ Archiving artifacts to Amazon S3...
# ✅ SUCCESS: Log archived safely to s3://dipendu-qa-test-artifacts/logs/
# ==========================================
```

---

### 🐳 Docker Containers (`Dockerfile`)
Containerizes automation scripts using Alpine Linux (5MB base image).

Installs `curl`, `bash`, `jq`, copies scripts, and runs them isolated on container start.

Ensures identical execution across MacBook, Ubuntu EC2, and CI servers.

```bash
docker build -t ubuy-monitor-app .
docker run ubuy-monitor-app
```

---

### ⚙️ GitHub Actions CI/CD (`.github/workflows/ubuy-monitor.yml`)
Automated Master Pipeline triggering on every `git push` and Pull Request:

1. Checkout code
2. Build Docker image
3. Run Ubuy Monitor container
4. Run Newman API test suite
5. Upload HTML test report as artifact
6. Upload logs as artifact

---

### 🧪 Newman API Test Suite (`ubuy_api_tests.json`)
Postman collection written from scratch, executed via Newman CLI.

Tests 3 endpoints with 6 assertions covering status codes, response times, and content types.

Generates professional HTML reports via `newman-reporter-htmlextra`.

```bash
./node_modules/.bin/newman run ubuy_api_tests.json -r htmlextra --reporter-htmlextra-export ubuy_report.html
# 3 requests | 6 assertions | 0 failures | avg response: 498ms
```

---

### 📦 Dynamic JSON Validation (`inventory_check.sh`, `ubuy_inventory.json`)
Validates product availability across a dynamic inventory JSON file using `jq` and Bash loops.

```bash
./inventory_check.sh
# OK: MacBook Pro M5 is in stock (Qty: 15).
# ❌ ALERT: Air Jordan 1 Low is out of stock!
# OK: iPhone 15 is in stock (Qty: 37).
```

---

### 🔍 Smoke Test (`smoke_test.sh`) · 🌐 Web Monitor (`web_test.sh`) · 🏥 Site Health Checker (`check_site.sh`) · 🔌 Port Scanner (`port_check.sh`) · 🔗 API Health Check (`api_check.sh`)
A suite of targeted Bash scripts covering connectivity, HTTP validation, port scanning, and API health — built progressively across Days 1-11.

---

### ⚡ Ollama Model Benchmark (`benchmark.py`)
Benchmarks a local Ollama LLM by measuring response time, token count, and tokens per second.

```bash
ollama pull llama3.2
python3 benchmark.py
```

---

## ☁️ Cloud Deployment

Scripts and Docker containers deployed and verified on **AWS EC2 (Mumbai Region)**

with automated S3 artifact archiving and 24/7 cron scheduling:

```bash
# SSH into EC2
ssh -i ~/.ssh/devops-cloud-key.pem ubuntu@<EC2-PUBLIC-IP>

# Cron jobs active on EC2
crontab -l
# */30 * * * * /home/ubuntu/devops-cloud-testin/cloud_test_runner.sh >> cron.log 2>&1
# @reboot  /home/ubuntu/devops-cloud-testin/cloud_test_runner.sh >> cron.log 2>&1

# Verify S3 artifacts
aws s3 ls s3://dipendu-qa-test-artifacts/logs/
```

---

## 🎯 Target Roles

QA Engineer · Cloud Automation Tester · Game Functionality Tester  
Targeting: **InnoWave · iNetFrame · Wipro · Rockstar Games**

---

*Built with 💻 + ☁️ by Dipendu Mukherjee — one day at a time.*
