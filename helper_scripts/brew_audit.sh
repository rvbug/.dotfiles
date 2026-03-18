#!/bin/bash

# --- Color Definitions ---
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo " "
echo -e "${BLUE}Fetching installed packages & descriptions...${NC}"
echo "--------------------------------------------------------------"

brew leaves --installed-on-request | xargs brew desc | while read -r line; do
    pkg=$(echo "$line" | cut -d: -f1)
    desc=$(echo "$line" | cut -d: -f2- | sed 's/^ //')

    printf "${CYAN}%-25s${NC} | ${YELLOW}%s${NC}\n" "$pkg" "$desc"
done
