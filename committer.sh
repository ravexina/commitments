#!/bin/bash

# Get the acutal dir of the script
DIR="$(dirname "$(readlink -f "$0")")"

grep "$(date +%F)" "${DIR}/days" &>/dev/null && { echo "Already Done!"; exit 1; }

# Generate a funny name for the day
FUNNY_NAME=$("${DIR}/name_generator.py")

echo "$(date +%F) $FUNNY_NAME">> "${DIR}/days"

# Mark the day status as complete
git --git-dir="${DIR}/.git" --work-tree="$DIR" add days
git --git-dir="${DIR}/.git" --work-tree="$DIR" commit -m "Done"
git --git-dir="${DIR}/.git" --work-tree="$DIR" push
