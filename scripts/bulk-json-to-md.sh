#!/bin/bash
#
# Apply json-to-md.sh to all contents of a directory
#
# Usage: ./bulk-json-to-md.sh [RAW_DATA_DIR]

# exit the script when a command fails
set -o errexit

# cacth exit status for piped commands
set -o pipefail

DEFAULT_RAW_DATA_DIR="../data/json"

# if no arg is provided to the script, use the default
RAW_DATA_DIR="${1:-${DEFAULT_RAW_DATA_DIR}}"

if [ ! -d "$RAW_DATA_DIR" ]; then
  echo "${RAW_DATA_DIR}: No such directory"
  exit 1
fi

#CONVERSION_SCRIPT="echo"
CONVERSION_SCRIPT="./json-to-md.sh"

###############################################################################

echo "Converting json files in directory: ${RAW_DATA_DIR}"

find "$RAW_DATA_DIR" -type f -name '*.json' -print0 | xargs -0 -I{} $CONVERSION_SCRIPT '{}'
