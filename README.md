
# Bash Enumeration Tool

A simple Bash script for basic web enumeration tasks like Nmap scanning, Gobuster directory brute-forcing, Whois lookup, WhatWeb, Nikto, and WPScan.

## Features

- Runs Nmap with default scripts and service/version detection.
- Performs directory enumeration with Gobuster.
- Gathers Whois information.
- Runs WhatWeb to identify web technologies.
- Performs Nikto web server vulnerability scanning.
- Scans WordPress sites with WPScan.

## Requirements

- bash
- nmap
- gobuster
- whois
- whatweb
- nikto
- wpscan

Make sure these tools are installed on your system.

## Usage

1. Clone this repository or download the `bash_enum.sh` script.

```bash
git clone https://github.com/malahat-mammadli/bash_enum_tool.git
cd bash_enum_tool
````

2. Make the script executable:

```bash
chmod +x bash_enum.sh
```

3. Run the script:

```bash
./bash_enum.sh
```

4. Enter the target IP address or domain when prompted.

5. Reports will be saved inside the `reports/` folder.

## Disclaimer

Use this tool responsibly and only on systems you own or have explicit permission to test.

---

Created by Malahat Mammadli
[GitHub Profile](https://github.com/malahat-mammadli)

