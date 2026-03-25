#!/bin/bash

# Colors for better visibility
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner Function
banner() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║                BASH ENUMERATION TOOL                   ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Usage/Help Function
usage() {
    echo -e "Usage: $0 <target_domain_or_IP>"
    echo -e "Example: $0 example.com"
    exit 1
}

# Dependency Check
check_dependencies() {
    local tools=("nmap" "gobuster" "whois" "whatweb" "nikto" "wpscan")
    echo -e "${YELLOW}[*] Checking for required tools...${NC}"
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo -e "${RED}[!] Error: '$tool' is not installed. Please install it to continue.${NC}"
            exit 1
        fi
    done
    echo -e "${GREEN}[✔] All dependencies are met.${NC}\n"
}

# Main Logic
if [[ -z "$1" ]]; then
    usage
fi

target=$1
timestamp=$(date +%Y%m%d_%H%M%S)
report_dir="reports/${target}_${timestamp}"

banner
check_dependencies

# Create Report Directory
mkdir -p "$report_dir"

# Default Protocol
url="http://$target"

echo -e "${BLUE}[*] Target: $target${NC}"
echo -e "${BLUE}[*] Reports will be saved in: $report_dir${NC}\n"

# 1. NMAP SCAN
echo -e "${YELLOW}[1] Starting Nmap Port & Service Scan...${NC}"
nmap -sC -sV -T4 "$target" -oN "$report_dir/nmap.txt"
echo -e "${GREEN}[✔] Nmap scan completed.${NC}\n"

# 2. WHOIS INFO
echo -e "${YELLOW}[2] Gathering WHOIS Information...${NC}"
whois "$target" > "$report_dir/whois.txt" 2>/dev/null
echo -e "${GREEN}[✔] Whois lookup completed.${NC}\n"

# 3. WHATWEB (Tech Stack Identification)
echo -e "${YELLOW}[3] Identifying Tech Stack (WhatWeb)...${NC}"
whatweb "$url" > "$report_dir/whatweb.txt"
echo -e "${GREEN}[✔] WhatWeb identification completed.${NC}\n"

# 4. GOBUSTER (Directory Brute Force)
WORDLIST="/usr/share/wordlists/dirb/common.txt"
if [[ -f "$WORDLIST" ]]; then
    echo -e "${YELLOW}[4] Brute-forcing directories (Gobuster)...${NC}"
    gobuster dir -u "$url" -w "$WORDLIST" -t 30 -q -o "$report_dir/gobuster.txt"
    echo -e "${GREEN}[✔] Gobuster directory scan completed.${NC}\n"
else
    echo -e "${RED}[!] Error: Wordlist not found at $WORDLIST. Skipping Gobuster.${NC}\n"
fi

# 5. NIKTO (Vulnerability Scan)
echo -e "${YELLOW}[5] Running Vulnerability Scan (Nikto)...${NC}"
nikto -h "$url" -Tuning 123bde -o "$report_dir/nikto.txt" &>/dev/null
echo -e "${GREEN}[✔] Nikto scan completed.${NC}\n"

# 6. WPSCAN (Conditional Scan)
echo -e "${BLUE}[?] Checking for WordPress CMS...${NC}"
if whatweb "$url" | grep -qi "WordPress"; then
    echo -e "${YELLOW}[6] WordPress detected! Launching WPScan...${NC}"
    wpscan --url "$url" --enumerate u,p,t --disable-tls-checks -o "$report_dir/wpscan.txt"
    echo -e "${GREEN}[✔] WPScan completed.${NC}\n"
else
    echo -e "${BLUE}[-] WordPress not detected. Skipping WPScan.${NC}\n"
fi

echo -e "${GREEN}======================================================"
echo -e "   [✓] ALL SCANS COMPLETED SUCCESSFULLY!"
echo -e "   Final results stored in: $report_dir"
echo -e "======================================================${NC}"
