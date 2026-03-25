## Bash Enumeration Tool

A powerful, automated Bash script for web enumeration and information gathering. This tool integrates several industry-standard security tools into a single workflow to speed up the reconnaissance phase of a penetration test.

## Features
- **Automated Workflow:** Runs multiple tools sequentially and organizes results.
- **Port Scanning:** Uses `Nmap` for service and version detection.
- **Technology Profiling:** Identifies CMS, frameworks, and server info via `WhatWeb`.
- **Directory Brute-forcing:** Finds hidden files and folders using `Gobuster`.
- **Vulnerability Scanning:** Performs web server security tests with `Nikto`.
- **CMS Specific:** Automatically detects WordPress and launches `WPScan` if found.
- **Clean Reporting:** Saves all results into a timestamped directory under `reports/`.

## Requirements
The script requires the following tools to be installed on your system (standard on Kali Linux):
* `nmap`
* `gobuster`
* `whois`
* `whatweb`
* `nikto`
* `wpscan`

## Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/bash_enum_tool.git](https://github.com/YOUR_USERNAME/bash_enum_tool.git)
   cd bash_enum_tool
   ```

2. **Give execution permissions:**
   ```bash
   chmod +x bash_enum_tool.sh
   ```

## Usage
To start a scan, simply provide the target domain or IP address as an argument:

```bash
./bash_enum_tool.sh example.com
```

### Example Workflow:
1. Checks if all required tools are installed.
2. Creates a dedicated report folder: `reports/example.com_20260325_1500/`.
3. Runs Nmap, Whois, WhatWeb, and Gobuster.
4. If WordPress is detected, it automatically initiates a user and plugin enumeration.
5. Summarizes the status and location of all output files.

## Project Structure
```text
.
├── bash_enum_tool.sh   # Main script
├── README.md           # Documentation
└── reports/            # Generated scan results (Auto-created)
```

## Disclaimer
This tool is for educational purposes and authorized penetration testing only. Usage of this tool for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state, and federal laws.

## Contributing
Feel free to fork this repository, open issues, or submit pull requests to make this tool even better!

