#!/bin/bash

if [ $# -ne 2 ]; then
    echo "wrong params, uasge: $0 <log_file> <keyword>"
    exit 1
fi

LOG_FILE="$1"
KEYWORD="$2"

if [ ! -f "$LOG_FILE" ]; then
    echo "filw $LOG_FILE not found"
    exit 1
fi

OUTPUT_FILE="${LOG_FILE%.*}_${KEYWORD}.log"

grep -i "$KEYWORD" "$LOG_FILE" > "$OUTPUT_FILE"

COUNT=$(wc -l < "$OUTPUT_FILE")
COUNT=$(echo "$COUNT" | tr -d ' ')

echo "found string with '$KEYWORD': $COUNT"
echo "results in $OUTPUT_FILE"