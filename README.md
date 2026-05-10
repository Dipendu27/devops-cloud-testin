# 30-Day DevOps Cloud Testing Journey 🚀

This repository tracks my transition from a Manual QA Engineer (formerly at **Ubuy**) to a DevOps-aligned Cloud Tester. 

## 🛠 Tech Stack
* **OS:** macOS (Unix-based Testing)
* **Shell:** Bash / Zsh
* **Tools:** VS Code, Git, Curl
* **Cloud:** AWS (In Progress)

## 📈 Learning Progress
- [x] **Day 1:** DevOps Foundations & CLI Basics
- [x] **Day 2:** HTTP Protocols & `curl` for API Testing
- [x] **Day 3:** Networking, DNS, & Port Scanning (`nc`)
- [x] **Day 4:** Version Control with Git (Local)

## 📂 Project Highlights
### Smoke Test Script (`smoke_test.sh`)
A Bash script that pings multiple domains and verifies connectivity, simulating a basic cloud health check.

### Web Monitor (`web_test.sh`)
Utilizes `curl` to validate HTTP status codes (200, 404, 405) to ensure backend service reliability.

### Site Health Checker (`check_site.sh`)
An automated bash script that uses `curl` to capture HTTP status codes and verify if a website is reachable (200 OK).

### Network Port Scanner (`port_check.sh`)
A networking utility that uses `nc` (Netcat) to verify if specific service ports (like 443 for HTTPS) are open on a target server.