#!/bin/bash

# This script attempts to process a file, but it has a race condition.
# It reads the file size, then tries to read the file content.  If the
# file is modified between these two operations, the script will read
# an inconsistent amount of data, or fail completely.

file_size=$(stat -c%s input.txt)

# ... other commands

content=$(head -c${file_size} input.txt)

echo "Content: ${content}"