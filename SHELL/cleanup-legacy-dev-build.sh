#!/bin/bash

# --- Configuration ---
SEARCH_ROOT="/home/user/projects"
TARGET_DIR_NAMES=(
    "build"
    "dist"
    "node_modules"
    "cache"
)
TARGET_FILE_NAMES=(
    ".DS_Store"
    "Thumbs.db"
    "*.log"
    "error.temp"
)

# --- Function to Dynamically Build Find's OR Pattern (Bash compatible) ---
# Takes the NAME of an array as input and builds the pattern string.
build_pattern() {
    local array_name="$1"
    local pattern=""
    local name

    # Loop through the array using array indirection
    for element in "${!array_name[@]}"; do
        # Access the array element using indirection
        local array_element="${!array_name[$element]}" 
        pattern+="-name \"$array_element\" -o "
    done

    # Remove the trailing ' -o '
    if [[ -n "$pattern" ]]; then
        pattern="${pattern% -o }"
    fi
    echo "$pattern"
}

# Build the patterns
DIR_PATTERN=$(build_pattern TARGET_DIR_NAMES)
FILE_PATTERN=$(build_pattern TARGET_FILE_NAMES)

# --- DRY RUN: Directories and Files that WOULD be deleted ---
echo "--- DRY RUN: Directories and Files to be deleted in $SEARCH_ROOT ---"

# 1. FIND AND PRINT DIRECTORIES
if [[ -n "$DIR_PATTERN" ]]; then
    echo -e "\n--- Found Directories: ---"
    # *** FIX APPLIED: Using 'eval' to correctly parse the parentheses and variables ***
    eval find \"$SEARCH_ROOT\" -type d \( $DIR_PATTERN \) -prune -print
fi

# 2. FIND AND PRINT FILES
if [[ -n "$FILE_PATTERN" ]]; then
    echo -e "\n--- Found Files: ---"
    # *** FIX APPLIED: Using 'eval' to correctly parse the parentheses and variables ***
    eval find \"$SEARCH_ROOT\" -type f \( $FILE_PATTERN \) -print
fi

# --- Execution (Uncomment the entire block below to delete) ---
: '
read -p "Are you sure you want to delete the listed files and directories? (yes/no): " CONFIRM
if [[ "$CONFIRM" == "yes" ]]; then
    
    echo "--- DELETING DIRECTORIES... ---"
    # 1. DELETE DIRECTORIES
    if [[ -n "$DIR_PATTERN" ]]; then
        # *** FIX APPLIED ***
        eval find \"$SEARCH_ROOT\" -type d \( $DIR_PATTERN \) -prune -exec rm -rf {} +
    fi
    
    echo "--- DELETING FILES... ---"
    
    # 2. DELETE FILES
    if [[ -n "$FILE_PATTERN" ]]; then
        # *** FIX APPLIED ***
        eval find \"$SEARCH_ROOT\" -type f \( $FILE_PATTERN \) -exec rm -f {} +
    fi
    
    echo "Cleanup complete."
else
    echo "Deletion cancelled."
fi
'
