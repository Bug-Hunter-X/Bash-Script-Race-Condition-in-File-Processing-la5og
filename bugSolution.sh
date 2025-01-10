#!/bin/bash

# This script avoids the race condition by using a lock file.
# It uses flock to acquire an exclusive lock on the input file before
# reading its content.  This ensures that no other process can modify
# the file while it is being read.

while true; do
  flock -x -n 200 input.txt || exit 1  # Try to get a lock for 200 seconds. (Adjust as needed)
  file_size=$(stat -c%s input.txt)
  content=$(head -c${file_size} input.txt)
  echo "Content: ${content}"
  break
done

# Clean up by removing the lock file (although flock handles this typically). 
# rm -f input.txt.lock
#This is better: 
flock -u 200 input.txt 