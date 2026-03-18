#!/bin/bash

# --- Global Configuration ---
PROJECTS_DIR="/Users/rv/Documents/projects"

# --- Color Definitions ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# --- 1. Overall System Disk Status ---
echo -e "${BLUE}${BOLD}=== SYSTEM DISK STATUS ===${NC}"
usage_line=$(df -h / | tail -1)
total_cap=$(echo "$usage_line" | awk '{print $2}')
avail_cap=$(echo "$usage_line" | awk '{print $4}')
usage_pct=$(echo "$usage_line" | awk '{print $5}' | tr -d '%')

if [ "$usage_pct" -ge 60 ]; then
    COLOR_USAGE=$RED
    STATUS="[!] ATTENTION: DISK OVER 60%"
else
    COLOR_USAGE=$GREEN
    STATUS="[✓] DISK SPACE HEALTHY"
fi

printf "Total Capacity: ${CYAN}%s${NC}\n" "$total_cap"
printf "Available:      ${CYAN}%s${NC}\n" "$avail_cap"
printf "Usage Status:   ${COLOR_USAGE}%s%% - %s${NC}\n" "$usage_pct" "$STATUS"

# --- 2. Project Directory Analysis ---
echo -e "\n${BLUE}${BOLD}=== TOP 10 LARGEST PROJECTS ===${NC}"
echo -e "${YELLOW}Scanning $PROJECTS_DIR...${NC}"

if [ -d "$PROJECTS_DIR" ]; then
    # The '/*' at the end is the secret for macOS 'du' to list subfolders
    du -sh "$PROJECTS_DIR"/* 2>/dev/null | sort -rh | head -n 10 | while read -r size path; do
        name=$(basename "$path")
        printf "${GREEN}%-10s${NC} | %s\n" "$size" "$name"
    done
else
    echo -e "${RED}Error: $PROJECTS_DIR not found.${NC}"
fi

# --- 3. Rust 'target' Bloat Finder ---
echo -e "\n${BLUE}${BOLD}=== RUST TARGET FOLDER ANALYSIS ===${NC}"
echo -e "${YELLOW}Finding all 'target' directories...${NC}"

# Store the data once to avoid running 'find' twice
target_data=$(find "$PROJECTS_DIR" -name "target" -type d -exec du -sh {} + 2>/dev/null | sort -rh)

if [ -n "$target_data" ]; then
    # Calculate Total Bloat
    # We use 'du -sk' to get KB values for reliable math
    total_kb=$(find "$PROJECTS_DIR" -name "target" -type d -exec du -sk {} + 2>/dev/null | awk '{sum += $1} END {print sum}')
    total_gb=$(echo "scale=2; $total_kb / 1048576" | bc)

    echo -e "${RED}${BOLD}TOTAL TARGET BLOAT: ${total_gb} GB${NC}"
    echo "------------------------------------------------"
    
    echo "$target_data" | head -n 10 | while read -r size path; do
        project=$(basename "$(dirname "$path")")
        printf "${RED}%-10s${NC} | Project: ${CYAN}%-20s${NC}\n" "$size" "$project"
    done
else
    echo -e "${GREEN}No 'target' folders found.${NC}"
fi

echo -e "\n${BLUE}------------------------------------------------${NC}"
