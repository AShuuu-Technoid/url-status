#!/bin/bash

# Define the input and output file paths
input_file="urls.txt"
output_file="url_status.csv"

# Check if input file exists
if [ ! -f "$input_file" ]; then
  echo "Input file not found!"
  exit 1
fi

# Write the header to the output file
echo "URL,Status" > "$output_file"

# Read URLs from the input file and check their status
while IFS= read -r url; do
  if [[ -n "$url" ]]; then
    # Get the HTTP status code for the URL
    status=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")
    
    # Write the URL and status to the output file
    echo "$url,$status" >> "$output_file"
  fi
done < "$input_file"

echo "URL status check completed. Results saved in $output_file."
