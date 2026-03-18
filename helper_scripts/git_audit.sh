#!/bin/bash
PROJECTS_DIR="$HOME/Documents/projects"

# Standard ANSI Color Codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

printf "${BLUE}Scanning %s...${NC}\n" "$PROJECTS_DIR"
echo "------------------------------------------------"

# Collect results into a variable
output=$(
    for dir in "$PROJECTS_DIR"/*/; do
        [ -d "$dir" ] || continue
        project_name=$(basename "$dir")
        
        # 1. Check if it is a Git repo
        if [ ! -d "$dir/.git" ]; then
            # Priority 4: NO GIT
            printf "4 [NO GIT]   %s\n" "$project_name"
            continue
        fi

        # Move into directory, suppress errors
        cd "$dir" || continue
        
        # 2. Logic for Status and Sorting Priority
        if ! git diff --quiet || ! git diff --cached --quiet; then
            # Priority 1: PENDING
            printf "1 ${RED}[PENDING]${NC}   %s (Uncommitted changes)\n" "$project_name"
        elif [ -n "$(git cherry -v 2>/dev/null)" ]; then
            # Priority 2: PUSH REQ
            printf "2 ${YELLOW}[PUSH REQ]${NC}  %s (Commits ready to push)\n" "$project_name"
        else
            # Priority 3: CLEAN
            printf "3 ${GREEN}[CLEAN]${NC}     %s\n" "$project_name"
        fi
        
        cd - > /dev/null
    done
)

# Sort by the priority number, then remove the first two characters (the number and space)
# Using 'echo -e' here to ensure the already-formatted $output renders correctly on Mac
echo -e "$output" | sort -k1,1 | sed 's/^[0-9] //'

echo "------------------------------------------------"
