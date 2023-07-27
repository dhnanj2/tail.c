#!/bin/bash

logs_directory="logs"   # Specify the logs directory name

# Task 1, 2, 3, 4
filtered_logs=$(find "$logs_directory" -type f -name "log_*.txt" -exec awk '/Timestamp:/{ts=$2} /Message:/{print ts,$2}' {} + | awk -v date="2022-01-01" '$1 >= date')

# Task 5
echo "$filtered_logs" > filtered_logs.txt

# Task 6, 7
max_average_diff=0
max_average_file=""
while read -r timestamp message; do
    if [[ -z $prev_timestamp ]]; then
        prev_timestamp=$timestamp
    else
        time_diff=$(date -d "$timestamp" +%s) # Convert timestamp to seconds since Epoch
        prev_time_diff=$(date -d "$prev_timestamp" +%s)
        average_diff=$((time_diff - prev_time_diff))
        if (( average_diff > max_average_diff )); then
            max_average_diff=$average_diff
            max_average_file=${message%%.*}   # Get the filename from the log message
        fi
        prev_timestamp=$timestamp
    fi
done <<< "$filtered_logs"

# Task 8
echo "Filename: $max_average_file.txt" > output.txt
echo "Maximum Average Time Difference: $max_average_diff seconds." >> output.txt

# Task 9
max_average_length=0
max_average_length_file=""
while read -r timestamp message; do
    length=${#message}
    if (( length > max_average_length )); then
        max_average_length=$length
        max_average_length_file=${message%%.*}   # Get the filename from the log message
    fi
done <<< "$filtered_logs"

# Task 10
echo "Filename: $max_average_length_file.txt" >> output.txt
echo "Longest Average Message Length: $max_average_length characters." >> output.txt

# Display the output on the terminal
cat output.txt
