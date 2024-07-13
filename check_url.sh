#!/bin/bash

input_file="urls.txt"
output_file="url_status.csv"

if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

echo "URL,Status" > "$output_file"

while IFS= read -r url; do
  if [[ -n "$url" ]]; then
    status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")

    echo "$url,$status" >> "$output_file"
  fi
done < "$input_file"

echo "URL status check completed. Results saved in $output_file."
