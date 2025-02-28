#!/bin/bash

# scpipe - A simple utility to copy files between servers via local machine
# Usage: ./scpipe --from user@serverA:/path/to/source --to user@serverB:/path/to/destination

set -e  # Exit immediately if a command exits with a non-zero status

# Function to display help
show_help() {
    echo "Usage: scpipe --from SOURCE --to DESTINATION"
    echo
    echo "Arguments:"
    echo "  --from SOURCE       Source path in format: username@server:/path/to/source"
    echo "  --to DESTINATION    Destination path in format: username@server:/path/to/destination"
    echo
    echo "Example:"
    echo "  scpipe --from john@server1example.com:/home/john/data.txt --to mary@server2.example.com:/home/mary/backup/"
    echo
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --from)
            source_location="$2"
            shift 2
            ;;
        --to)
            dest_location="$2"
            shift 2
            ;;
        --help|-h)
            show_help
            ;;
        *)
            echo "Unknown option: $1" >&2
            show_help
            ;;
    esac
done

# Check if both source and destination are provided
if [ -z "$source_location" ] || [ -z "$dest_location" ]; then
    echo "Error: Both --from and --to arguments are required." >&2
    show_help
fi

# Get the filename from the source path
filename=$(basename "${source_location#*:}")
echo "File: $filename" >&2

# Step 1: Copy from source server to local machine (current directory)
echo "Copying from $source_location to current directory..." >&2
scp "$source_location" "./$filename"

# Step 2: Copy from local machine to destination server
echo "Copying from current directory to $dest_location..." >&2
scp "./$filename" "$dest_location"

echo "File transfer completed successfully!" >&2
echo "Source: $source_location" >&2
echo "Destination: $dest_location" >&2
echo "Local copy saved as: $(pwd)/$filename" >&2

exit 0
