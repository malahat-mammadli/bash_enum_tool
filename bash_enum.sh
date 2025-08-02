#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Banner
echo -e "${YELLOW}"
echo "╔══════════════════════════════════════╗"
echo "║          Web Enumeration Tool        ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

read -p "Enter target IP or domain: " target

# Simple check (e.g., warning if input is empty)
if [[ -z "$target" ]]; then
    echo -e "${RED}[ERROR] Target cannot be empty!${NC}"
    exit 1
fi

mkdir -p reports

echo -e "${BLUE}[*] Starting Nmap...${NC}"
nmap -sC -sV -A "$target" -oN reports/nmap_$target.txt
echo -e "${GREEN}[✔] Nmap completed.${NC}\n"

echo -e "${BLUE}[*] Starting Gobuster...${NC}"
gobuster dir -u http://$target -w /usr/share/wordlists/dirb/common.txt -o reports/gobuster_$target.txt
echo -e "${GREEN}[✔] Gobuster completed.${NC}\n"

echo -e "${BLUE}[*] Gathering WHOIS info...${NC}"
whois $target > reports/whois_$target.txt
echo -e "${GREEN}[✔] Whois completed.${NC}\n"

echo -e "${BLUE}[*] Running WhatWeb...${NC}"
whatweb http://$target > reports/whatweb_$target.txt
echo -e "${GREEN}[✔] WhatWeb completed.${NC}\n"

echo -e "${BLUE}[*] Running Nikto...${NC}"
nikto -h http://$target -output reports/nikto_$target.txt
echo -e "${GREEN}[✔] Nikto completed.${NC}\n"

echo -e "${BLUE}[*] Running WPScan (for WordPress targets)...${NC}"
wpscan --url http://$target --enumerate u --disable-tls-checks -o reports/wpscan_$target.txt
echo -e "${GREEN}[✔] WPScan completed.${NC}\n"

echo -e "${YELLOW}[✓] All scan results saved in the 'reports/' directory.${NC}"
