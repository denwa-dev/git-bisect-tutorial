#!/bin/bash

# Exit on error
set -e

# Start fresh
rm -rf hello-bug-project
mkdir hello-bug-project
cd hello-bug-project
git init

# Create initial commit with the expected business logic
echo 'console.log("Hello!");' >main.js
git add main.js
git commit -m "Initial commit with expected business logic"

echo "Creating more commits. Suppressing git output to obscure commit details. No peeking! :)"
# Create random number of before-bug commits
TOTAL_COMMIT_COUNT=$(((RANDOM % 10) + 10))
COMMIT_COUNT_BEFORE_BUG=$((TOTAL_COMMIT_COUNT - (RANDOM % TOTAL_COMMIT_COUNT)))
CURRENT_COMMIT_COUNT=0

for i in $(seq 1 $COMMIT_COUNT_BEFORE_BUG); do
    let CURRENT_COMMIT_COUNT+=1
    git commit --allow-empty -m "commit $CURRENT_COMMIT_COUNT" >/dev/null 2>&1 # Suppress output to obscure commit details
done

# Create a commit with a bug in the business logic
echo 'console.log("Bug!");' >main.js
git add main.js
git commit -m "commit $CURRENT_COMMIT_COUNT" >/dev/null 2>&1 # Suppress output to obscure commit details

# Create random number of after-bug commits
for i in $(seq $((COMMIT_COUNT_BEFORE_BUG + 1)) $TOTAL_COMMIT_COUNT); do
    let CURRENT_COMMIT_COUNT+=1
    git commit --allow-empty -m "commit $CURRENT_COMMIT_COUNT" >/dev/null 2>&1 # Suppress output to obscure commit details
done

echo "Done creating commit history. Try using git bisect to find the first bad commit with the bug!"
