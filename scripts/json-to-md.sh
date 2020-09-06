#!/bin/bash
#
# Script for converting sangraha's crawled json files into readable markdown
# https://github.com/CodeforNepal/akshara-project/tree/210a6276f9b4bda0b33a6ef9f4d36270f7667da0/elasticsearch/data/crawled

# exit the script when a command fails
set -o errexit

# catch exit status for piped commands
set -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

input_json_file=$1
if [ -z "$1" ]; then
  echo "Please supply input json file"
  exit 1
fi

output_markdown_file="${input_json_file%.*}.md"

echo "${input_json_file} -> ${output_markdown_file}"

# append metadata to markdown file
jq --raw-output '. | "---
title: \(.title)
author: \(.author)
genre: \(.genre)
source: \(.source)
source_link: \(.source_link)
language: \(.lang)
---
"' "$input_json_file" > "$output_markdown_file"

# append main html text to markdown file (cleaning up any html attributes)
jq --raw-output '.text' "$input_json_file" \
  | pandoc --from html --to markdown \
           --wrap preserve --lua-filter "${script_dir}/pandoc-remove-html-attr.lua" \
  >> "$output_markdown_file"
