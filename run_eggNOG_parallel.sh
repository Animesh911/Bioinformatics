#!/bin/bash

# Define the number of CPUs to use
num_cpus=50

# Define the maximum number of jobs to run in parallel
jobs_limit=3

# Define the function to run the emapper.py command
run_emapper() {
  fasta_file="$1"
  folder=$(dirname "$fasta_file")
  emapper.py --data_dir /home/usr/database/eggnog/ -i "$fasta_file" -o "$folder/eggnog_output" --cpu 10 --temp_dir "$folder/" --override
}

# Export the function to make it available to GNU Parallel
export -f run_emapper

# Find all the fasta files in the current directory and its subdirectories: ./bin1/PROKKA*.faa
fasta_files=$(find . -type f -name "PROKKA_*.faa")

# Loop through the fasta files and run the emapper.py command on a limited number of files at a time
echo "$fasta_files" | while read fasta_file; do
  # Wait until the number of running jobs is less than the limit
  while [ $(jobs -rp | wc -l) -ge $jobs_limit ]; do
    sleep 1
  done

  # Run the emapper.py command in the background
  run_emapper "$fasta_file" &

done

# Wait for all the background jobs to finish
wait
