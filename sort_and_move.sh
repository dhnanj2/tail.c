#!/bin/bash

# Prompt the user to enter the name of a directory
read -p "Enter the name of the directory: " input_directory

# Check if the directory exists
if [ ! -d "$input_directory" ]; then
    echo "Error: Directory '$input_directory' does not exist."
    exit 1
fi

# List all the files in the given directory and sort them alphabetically
files_list=$(ls "$input_directory" | sort)

# Create a new directory named "sorted" inside the given directory
sorted_directory="$input_directory/sorted"
mkdir -p "$sorted_directory"

# Move each file from the original directory to the "sorted" directory
moved_files=0
for file in $files_list; do
    mv "$input_directory/$file" "$sorted_directory/"
    moved_files=$((moved_files + 1))
done

# Display the success message with the total number of files moved
echo "Successfully moved $moved_files files to '$sorted_directory'."
